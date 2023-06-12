import 'package:flutter/material.dart';
import 'package:pangolin/services/power.dart';

typedef PowerServiceWidgetBuilder = Widget Function(
  BuildContext context,
  Widget? child,
  int percentage,
  bool charging,
  bool powerSaver,
);

class PowerServiceBuilder extends StatelessWidget {
  final PowerServiceWidgetBuilder builder;
  final Widget? child;

  const PowerServiceBuilder({
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        PowerService.current.mainBattery,
        PowerService.current.activeProfileNotifier,
      ]),
      builder: (context, child) {
        final device = PowerService.current.mainBattery!;
        final percentage = device.percentage.toInt();
        final charging = device.state == UPowerDeviceState.charging;
        final activeProfile = PowerService.current.activeProfile;

        return builder(
          context,
          child,
          percentage,
          charging,
          activeProfile == PowerProfile.powerSaver,
        );
      },
      child: child,
    );
  }
}

class BatteryIndicator extends StatelessWidget {
  final BatteryIndicatorPainter? painter;
  final BatteryIndicatorDelegate? delegate;
  final int percentage;
  final bool charging;
  final bool powerSaving;
  final double? size;
  final Color? color;
  final Color? lowBatteryColor;
  final Color? powerSavingColor;

  const BatteryIndicator({
    required this.percentage,
    this.charging = false,
    this.powerSaving = false,
    BatteryIndicatorDelegate this.delegate =
        const VerticalBatteryIndicatorDelegate(),
    this.size,
    this.color,
    this.lowBatteryColor,
    this.powerSavingColor,
  }) : painter = null;

  const BatteryIndicator.withPainter({
    required BatteryIndicatorPainter this.painter,
    required this.percentage,
    this.charging = false,
    this.powerSaving = false,
    this.size,
    this.color,
    this.lowBatteryColor,
    this.powerSavingColor,
  }) : delegate = null;

  @override
  Widget build(BuildContext context) {
    assert(painter != null || delegate != null);

    return CustomPaint(
      size: Size.square(size ?? 20),
      painter: _BatteryIndicatorCustomPainter(
        painter: painter ?? _DefaultBatteryIndicatorPainter(delegate!),
        percentage: percentage,
        status: _status,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        lowBatteryColor: lowBatteryColor ?? Colors.red,
        powerSavingColor: lowBatteryColor ?? Colors.orange,
      ),
    );
  }

  BatteryStatus get _status {
    if (charging) return BatteryStatus.charging;
    if (powerSaving) return BatteryStatus.powerSavingMode;
    return BatteryStatus.none;
  }
}

enum BatteryStatus { none, charging, powerSavingMode }

class _BatteryIndicatorCustomPainter extends CustomPainter {
  final BatteryIndicatorPainter painter;
  final int percentage;
  final BatteryStatus status;
  final Color color;
  final Color lowBatteryColor;
  final Color powerSavingColor;

  const _BatteryIndicatorCustomPainter({
    required this.painter,
    required this.percentage,
    required this.status,
    required this.color,
    required this.lowBatteryColor,
    required this.powerSavingColor,
  }) : assert(percentage >= 0 && percentage <= 100);

  @override
  void paint(Canvas canvas, Size size) {
    painter.paint(
      canvas,
      size,
      percentage: percentage,
      status: status,
      color: color,
      lowBatteryColor: lowBatteryColor,
      powerSavingColor: powerSavingColor,
    );
  }

  @override
  bool shouldRepaint(covariant _BatteryIndicatorCustomPainter old) {
    return painter != old.painter ||
        percentage != old.percentage ||
        status != old.status ||
        color != old.color ||
        lowBatteryColor != old.lowBatteryColor ||
        powerSavingColor != old.powerSavingColor ||
        // the painter can choose to force a repaint (eg if they handle animations themselves)
        painter.shouldRepaint();
  }
}

abstract class BatteryIndicatorPainter {
  const BatteryIndicatorPainter();

  void paint(
    Canvas canvas,
    Size size, {
    required int percentage,
    required BatteryStatus status,
    required Color color,
    required Color lowBatteryColor,
    required Color powerSavingColor,
  });

  bool shouldRepaint() => false;
}

class _DefaultBatteryIndicatorPainter extends BatteryIndicatorPainter {
  final BatteryIndicatorDelegate delegate;

  const _DefaultBatteryIndicatorPainter(this.delegate);

  @override
  void paint(
    Canvas canvas,
    Size size, {
    required int percentage,
    required BatteryStatus status,
    required Color color,
    required Color lowBatteryColor,
    required Color powerSavingColor,
  }) {
    Color getLevelPathColor() {
      if (status == BatteryStatus.powerSavingMode) return powerSavingColor;
      if (percentage <= 20 && status != BatteryStatus.charging) {
        return lowBatteryColor;
      }

      return color;
    }

    Path getLevelClipPath() {
      if (delegate.getBatteryLevelClipPath(percentage) != null) {
        return delegate.getBatteryLevelClipPath(percentage)!;
      }

      final bounds = delegate.batteryLevelPath.getBounds();

      return Path()
        ..addRect(
          Rect.fromLTRB(
            bounds.left,
            bounds.top + bounds.height * (100 - percentage) / 100,
            bounds.right,
            bounds.bottom,
          ),
        );
    }

    canvas.scale(
      size.width / delegate.designSize.width,
      size.height / delegate.designSize.height,
    );

    final rectPath = Path.combine(
      PathOperation.intersect,
      delegate.batteryLevelPath,
      getLevelClipPath(),
    );

    final indicatorPath = switch (status) {
      BatteryStatus.charging => delegate.chargingIndicatorPath,
      BatteryStatus.powerSavingMode => delegate.powerSavingIndicatorPath,
      BatteryStatus.none => null,
    };

    canvas.saveLayer(null, Paint());
    if (delegate.batteryBackgroundPath != null) {
      canvas.clipPath(delegate.batteryBackgroundPath!);

      canvas.drawPath(
        delegate.batteryBackgroundPath!,
        Paint()..color = color.withOpacity(0.4),
      );
    }
    final levelPathColor = getLevelPathColor();

    canvas.drawPath(rectPath, Paint()..color = levelPathColor);
    if (indicatorPath != null) {
      switch (status) {
        case BatteryStatus.charging:
          canvas.drawPath(
            indicatorPath,
            Paint()
              ..strokeWidth = 2
              ..style = PaintingStyle.stroke
              ..strokeJoin = StrokeJoin.round
              ..color = levelPathColor,
          );
          canvas.drawPath(indicatorPath, Paint()..color = levelPathColor);

          canvas.drawPath(
            indicatorPath,
            Paint()
              ..color = Colors.white
              ..blendMode = BlendMode.clear,
          );
        default:
          canvas.drawPath(indicatorPath, Paint()..color = color);
      }
    }

    canvas.drawPath(delegate.batteryPath, Paint()..color = color);
    canvas.restore();
  }
}

abstract class BatteryIndicatorDelegate {
  final Size designSize;
  const BatteryIndicatorDelegate(this.designSize);

  Path get batteryPath;
  Path? get batteryBackgroundPath => null;
  Path get batteryLevelPath;
  Path? getBatteryLevelClipPath(int percentage) => null;
  Path get chargingIndicatorPath;
  Path get powerSavingIndicatorPath;
}

class VerticalBatteryIndicatorDelegate extends BatteryIndicatorDelegate {
  const VerticalBatteryIndicatorDelegate() : super(const Size.square(24));

  @override
  Path get batteryPath => Path()
    ..moveTo(9, 0)
    ..lineTo(15, 0)
    ..lineTo(15, 2)
    ..lineTo(16, 2)
    ..cubicTo(17.1046, 2, 18, 2.89543, 18, 4)
    ..lineTo(18, 22)
    ..cubicTo(18, 23.1046, 17.1046, 24, 16, 24)
    ..lineTo(8, 24)
    ..cubicTo(6.89543, 24, 6, 23.1046, 6, 22)
    ..lineTo(6, 4)
    ..cubicTo(6, 2.89543, 6.89543, 2, 8, 2)
    ..lineTo(9, 2)
    ..lineTo(9, 0)
    ..close()
    ..moveTo(16, 4)
    ..lineTo(8, 4)
    ..lineTo(8, 22)
    ..lineTo(16, 22)
    ..lineTo(16, 4)
    ..close();

  @override
  Path get batteryLevelPath => Path()
    ..moveTo(8, 4)
    ..lineTo(16, 4)
    ..lineTo(16, 22)
    ..lineTo(8, 22)
    ..lineTo(8, 4)
    ..close();

  @override
  Path get chargingIndicatorPath => Path()
    ..moveTo(12, 14)
    ..lineTo(9, 14)
    ..lineTo(12, 7)
    ..lineTo(12, 12)
    ..lineTo(15, 12)
    ..lineTo(12, 19)
    ..lineTo(12, 14)
    ..close();

  @override
  Path get powerSavingIndicatorPath => Path()
    ..moveTo(9, 14)
    ..lineTo(9, 12)
    ..lineTo(11, 12)
    ..lineTo(11, 10)
    ..lineTo(13, 10)
    ..lineTo(13, 12)
    ..lineTo(15, 12)
    ..lineTo(15, 14)
    ..lineTo(13, 14)
    ..lineTo(13, 16)
    ..lineTo(11, 16)
    ..lineTo(11, 14)
    ..lineTo(9, 14)
    ..close();
}

class VerticalOreoBatteryIndicatorDelegate extends BatteryIndicatorDelegate {
  const VerticalOreoBatteryIndicatorDelegate() : super(const Size.square(24));

  @override
  Path get batteryBackgroundPath => Path()
    ..moveTo(9, 0)
    ..lineTo(15, 0)
    ..lineTo(15, 2)
    ..lineTo(16, 2)
    ..cubicTo(17.1046, 2, 18, 2.89543, 18, 4)
    ..lineTo(18, 22)
    ..cubicTo(18, 23.1046, 17.1046, 24, 16, 24)
    ..lineTo(8, 24)
    ..cubicTo(6.89543, 24, 6, 23.1046, 6, 22)
    ..lineTo(6, 4)
    ..cubicTo(6, 2.89543, 6.89543, 2, 8, 2)
    ..lineTo(9, 2)
    ..lineTo(9, 0)
    ..close();

  @override
  Path get batteryPath => Path();

  @override
  Path get batteryLevelPath =>
      Path()..addRect(batteryBackgroundPath.getBounds());

  @override
  Path get chargingIndicatorPath => Path()
    ..moveTo(12, 13)
    ..lineTo(9, 13)
    ..lineTo(12, 6)
    ..lineTo(12, 11)
    ..lineTo(15, 11)
    ..lineTo(12, 18)
    ..lineTo(12, 13)
    ..close();

  @override
  Path get powerSavingIndicatorPath => Path()
    ..moveTo(9, 13)
    ..lineTo(9, 11)
    ..lineTo(11, 11)
    ..lineTo(11, 9)
    ..lineTo(13, 9)
    ..lineTo(13, 11)
    ..lineTo(15, 11)
    ..lineTo(15, 13)
    ..lineTo(13, 13)
    ..lineTo(13, 15)
    ..lineTo(11, 15)
    ..lineTo(11, 13)
    ..lineTo(9, 13)
    ..close();
}

class CircleBatteryIndicatorDelegate extends BatteryIndicatorDelegate {
  const CircleBatteryIndicatorDelegate() : super(const Size.square(24));

  @override
  Path get batteryBackgroundPath => Path()..addOval(Offset.zero & designSize);

  @override
  Path get batteryLevelPath => Path()..addOval(Offset.zero & designSize);

  @override
  Path get batteryPath => Path();

  @override
  Path get chargingIndicatorPath {
    const vDelegate = VerticalBatteryIndicatorDelegate();
    final cPath = vDelegate.chargingIndicatorPath;
    final transform = Matrix4.identity();
    transform.translate(0.0, -1.0);
    transform.translate(designSize.width / 2, designSize.height / 2);
    transform.scale(1.4);
    transform.translate(-designSize.width / 2, -designSize.height / 2);

    return cPath.transform(transform.storage);
  }

  @override
  Path get powerSavingIndicatorPath {
    const vDelegate = VerticalBatteryIndicatorDelegate();
    final pPath = vDelegate.powerSavingIndicatorPath;
    final transform = Matrix4.identity();
    transform.translate(0.0, -1.0);
    transform.translate(designSize.width / 2, designSize.height / 2);
    transform.scale(1.4);
    transform.translate(-designSize.width / 2, -designSize.height / 2);

    return pPath.transform(transform.storage);
  }
}

class RadialBatteryIndicatorDelegate extends BatteryIndicatorDelegate {
  const RadialBatteryIndicatorDelegate() : super(const Size.square(24));

  @override
  Path get batteryBackgroundPath => Path()..addOval(Offset.zero & designSize);

  @override
  Path get batteryLevelPath => Path()..addOval(Offset.zero & designSize);

  @override
  Path? getBatteryLevelClipPath(int percentage) => Path()
    ..addOval(
      Rect.fromCircle(
        center: designSize.center(Offset.zero),
        radius: percentage / 100 * designSize.width / 2,
      ),
    );

  @override
  Path get batteryPath => Path();

  @override
  Path get chargingIndicatorPath {
    const vDelegate = VerticalBatteryIndicatorDelegate();
    final cPath = vDelegate.chargingIndicatorPath;
    final transform = Matrix4.identity();
    transform.translate(0.0, -1.0);
    transform.translate(designSize.width / 2, designSize.height / 2);
    transform.scale(1.4);
    transform.translate(-designSize.width / 2, -designSize.height / 2);

    return cPath.transform(transform.storage);
  }

  @override
  Path get powerSavingIndicatorPath {
    const vDelegate = VerticalBatteryIndicatorDelegate();
    final pPath = vDelegate.powerSavingIndicatorPath;
    final transform = Matrix4.identity();
    transform.translate(0.0, -1.0);
    transform.translate(designSize.width / 2, designSize.height / 2);
    transform.scale(1.4);
    transform.translate(-designSize.width / 2, -designSize.height / 2);

    return pPath.transform(transform.storage);
  }
}
