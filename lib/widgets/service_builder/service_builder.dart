import 'package:flutter/widgets.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/services/service_manager.dart';

// ignore: avoid_private_typedef_functions
typedef _ServiceBuilder = Widget Function(
  BuildContext context,
  bool isSupported,
  Widget? child,
);

class ServiceBuilder extends StatefulWidget {
  final Service service;
  final _ServiceBuilder builder;
  final Widget? child;
  const ServiceBuilder({
    Key? key,
    required this.service,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  _ServiceBuilderState createState() => _ServiceBuilderState();
}

class _ServiceBuilderState extends State<ServiceBuilder> {
  @override
  Widget build(BuildContext context) {
    return ServiceManager().isActive(widget.service)
        ? widget.builder(context, widget.service.isSupported(), widget.child)
        : const Text("Service is not running");
  }
}
