import 'package:flutter/material.dart';
import 'package:pangolin/services/service.dart';

class ServiceEntry<T extends Service<T>> {
  final ServiceBuilder<T> builder;
  final T? fallback;

  const ServiceEntry(this.builder, [this.fallback]);

  void register() {
    ServiceManager.registerService<T>(builder, fallback: fallback);
  }
}

class ServiceBuilderWidget extends StatefulWidget {
  final List<ServiceEntry> services;
  final ValueWidgetBuilder<bool> builder;
  final Future<void> Function()? onLoaded;
  final Widget? child;

  const ServiceBuilderWidget({
    required this.services,
    required this.builder,
    this.onLoaded,
    this.child,
    super.key,
  });

  @override
  State<ServiceBuilderWidget> createState() => _ServiceBuilderWidgetState();
}

class _ServiceBuilderWidgetState extends State<ServiceBuilderWidget> {
  bool started = false;

  @override
  void initState() {
    super.initState();
    for (final ServiceEntry entry in widget.services) {
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
