import 'package:flutter/widgets.dart';
import 'package:pangolin/services/service.dart';
import 'package:pangolin/services/service_manager.dart';

// ignore: avoid_private_typedef_functions
typedef _ServiceBuilder = Widget Function(
  BuildContext context,
  bool isSupported,
  Widget? child,
);

@Deprecated("Not usable at the moment")
class ServiceBuilder extends StatefulWidget {
  final Service service;
  final _ServiceBuilder builder;
  final Widget? child;

  @Deprecated("Not usable at the moment")
  const ServiceBuilder({
    Key? key,
    required this.service,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  _ServiceBuilderState createState() => _ServiceBuilderState();
}

// ignore: deprecated_member_use_from_same_package
class _ServiceBuilderState extends State<ServiceBuilder> {
  @override
  Widget build(BuildContext context) {
    return ServiceManager().isActive(widget.service)
        ? widget.builder(context, widget.service.isSupported(), widget.child)
        : const Text("Service is not running");
  }
}
