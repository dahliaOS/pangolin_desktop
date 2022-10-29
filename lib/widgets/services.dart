import 'package:flutter/material.dart';
import 'package:pangolin/services/service.dart';

class ServiceEntry<T extends Service<T>> {

  const ServiceEntry(this.builder, [this.fallback]);
  final ServiceBuilder<T> builder;
  final T? fallback;

  void register() {
    ServiceManager.registerService<T>(builder, fallback: fallback);
  }
}

class ServiceBuilderWidget extends StatefulWidget {

  const ServiceBuilderWidget({
    required this.services,
    required this.builder,
    this.onLoaded,
    this.child,
    super.key,
  });
  final List<ServiceEntry> services;
  final ValueWidgetBuilder<bool> builder;
  final Future<void> Function()? onLoaded;
  final Widget? child;

  @override
  State<ServiceBuilderWidget> createState() => _ServiceBuilderWidgetState();
}

class _ServiceBuilderWidgetState extends State<ServiceBuilderWidget> {
  bool started = false;

  @override
  void initState() {
    super.initState();
    for (final entry in widget.services) {
      entry.register();
    }
    _startServices();
  }

  @override
  void dispose() {
    ServiceManager.stopServices();
    super.dispose();
  }

  Future<void> _startServices() async {
    await ServiceManager.startServices();
    await widget.onLoaded?.call();
    started = true;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, started, widget.child);
  }
}

class ListenableServiceBuilder<T extends ListenableService<T>>
    extends StatelessWidget {

  const ListenableServiceBuilder({
    required this.builder,
    this.child,
    super.key,
  });
  final TransitionBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ServiceManager.getService<T>()!,
      builder: builder,
      child: child,
    );
  }
}

mixin StatelessServiceListener<S extends ListenableService<S>>
    on StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = ServiceManager.getService<S>()!;

    return ListenableServiceBuilder<S>(
      builder: (context, _) => buildChild(context, service),
    );
  }

  Widget buildChild(BuildContext context, S service);
}

mixin StateServiceListener<S extends ListenableService<S>,
    T extends StatefulWidget> on State<T> {
  @override
  Widget build(BuildContext context) {
    final service = ServiceManager.getService<S>()!;

    return ListenableServiceBuilder<S>(
      builder: (context, _) => buildChild(context, service),
    );
  }

  Widget buildChild(BuildContext context, S service);
}
