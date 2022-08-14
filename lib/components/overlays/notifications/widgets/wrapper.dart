import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pangolin/components/overlays/notifications/widgets/notification.dart';
import 'package:pangolin/services/notifications.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pausable_timer/pausable_timer.dart';

class NotificationViewWrapper extends StatelessWidget {
  final NotificationWrapperData notification;
  final ValueChanged<int>? onClose;
  final bool clipChild;

  const NotificationViewWrapper({
    required this.notification,
    this.onClose,
    this.clipChild = false,
  });

  @override
  Widget build(BuildContext context) {
    final CurvedAnimation curved = CurvedAnimation(
      parent: notification.controller,
      curve: decelerateEasing,
      reverseCurve: decelerateEasing.flipped,
    );

    return MouseRegion(
      onEnter: (event) {
        notification.timer?.pause();
      },
      onExit: (event) {
        notification.timer?.start();
      },
      child: AnimatedBuilder(
        animation: curved,
        builder: (context, child) {
          return _NotificationDismissible(
            onDismissing: (value) => notification.controller.value = value,
            onKept: () => notification.controller.animateTo(1),
            onDismissed: () => onClose?.call(notification.notification.id),
            value: notification.controller.value,
            child: Visibility(
              visible: curved.value > 0,
              child: child!,
            ),
          );
        },
        child: ClipPath(
          clipBehavior: clipChild ? Clip.antiAlias : Clip.none,
          clipper: const ShapeBorderClipper(shape: Constants.mediumShape),
          child: FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curved),
              child: SizeTransitionWithBehavior(
                sizeFactor: curved,
                clipBehavior: clipChild ? Clip.antiAlias : Clip.none,
                clipShape: Constants.mediumShape,
                axisAlignment: 1,
                child: NotificationView(
                  key: ValueKey(notification.hashCode),
                  notification: notification.notification,
                  onClose: onClose,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationDismissible extends StatelessWidget {
  final Widget child;
  final double value;
  final ValueChanged<double> onDismissing;
  final VoidCallback? onKept;
  final VoidCallback? onDismissed;

  const _NotificationDismissible({
    required this.child,
    required this.value,
    required this.onKept,
    required this.onDismissing,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;

        if (box == null) return;

        final double fraction = details.localPosition.dx / box.size.width;
        onDismissing(1 - fraction);
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 250) {
          return onDismissed?.call();
        }

        if (value > 0.5) {
          return onKept?.call();
        } else {
          return onDismissed?.call();
        }
      },
      child: child,
    );
  }
}

class SizeTransitionWithBehavior extends AnimatedWidget {
  final Axis axis;
  Animation<double> get sizeFactor => listenable as Animation<double>;
  final double axisAlignment;
  final Clip clipBehavior;
  final ShapeBorder clipShape;
  final Widget? child;

  const SizeTransitionWithBehavior({
    super.key,
    this.axis = Axis.vertical,
    required Animation<double> sizeFactor,
    this.axisAlignment = 0.0,
    this.clipBehavior = Clip.hardEdge,
    this.clipShape = const RoundedRectangleBorder(),
    this.child,
  }) : super(listenable: sizeFactor);

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }
    return ClipPath(
      clipper: ShapeBorderClipper(shape: clipShape),
      clipBehavior: clipBehavior,
      child: Align(
        alignment: alignment,
        heightFactor: axis == Axis.vertical ? max(sizeFactor.value, 0.0) : null,
        widthFactor:
            axis == Axis.horizontal ? max(sizeFactor.value, 0.0) : null,
        child: child,
      ),
    );
  }
}

class NotificationWrapperData {
  final UserNotification notification;
  final AnimationController controller;
  final PausableTimer? timer;

  const NotificationWrapperData({
    required this.notification,
    required this.controller,
  }) : timer = null;

  const NotificationWrapperData.incoming({
    required this.notification,
    required this.controller,
    required this.timer,
  });
}
