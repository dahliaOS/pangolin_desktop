/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'dart:async';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:dahlia_shared/dahlia_shared.dart';
import 'package:flutter/rendering.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_account_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_language_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_network_page.dart';
import 'package:pangolin/components/overlays/quick_settings/pages/qs_theme_page.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_shortcut_button.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_slider.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_toggle_button.dart';
import 'package:pangolin/components/overlays/quick_settings/widgets/qs_tray_item.dart';
import 'package:pangolin/services/date_time.dart';
import 'package:pangolin/services/power.dart';
import 'package:pangolin/services/shell.dart';
import 'package:pangolin/services/tray.dart';
import 'package:pangolin/services/wm.dart';
import 'package:pangolin/utils/action_manager/action_manager.dart';
import 'package:pangolin/utils/data/globals.dart';
import 'package:pangolin/widgets/battery_indicator.dart';
import 'package:pangolin/widgets/quick_button.dart';
import 'package:pangolin/widgets/surface/surface_layer.dart';
import 'package:provider/provider.dart';
import 'package:yatl_flutter/yatl_flutter.dart';
import 'package:zenit_ui/zenit_ui.dart';

class QuickSettingsOverlay extends ShellOverlay {
  static const String overlayId = 'quicksettings';

  QuickSettingsOverlay({super.key}) : super(id: overlayId);

  @override
  _QuickSettingsOverlayState createState() => _QuickSettingsOverlayState();
}

enum _TransitionDirection {
  forward(false),
  reverse(true);

  final bool value;

  const _TransitionDirection(this.value);
}

class _QuickSettingsOverlayState
    extends ShellOverlayState<QuickSettingsOverlay> {
  static const Map<String, Widget> routes = {
    '/': QsMain(),
    '/pages/account': QsAccountPage(),
    '/pages/network': QsNetworkPage(),
    '/pages/theme': QsThemePage(),
    '/pages/language': QsLanguagePage(),
  };

  late final QsControllerState qsController = QsControllerState._(this);

  @override
  Future<void> requestShow(Map<String, dynamic> args) async {
    routeStack = ['/'];
    controller.showing = true;
    await animationController.forward();
  }

  @override
  Future<void> requestDismiss(Map<String, dynamic> args) async {
    controller.showing = false;
    await animationController.reverse();
  }

  void pushRoute(String name) {
    direction = _TransitionDirection.forward;
    routeStack.add(name);
    setState(() {});
    qsController._notify();
  }

  void popRoute() {
    if (!canPop()) return;
    direction = _TransitionDirection.reverse;
    routeStack.removeLast();
    setState(() {});
    qsController._notify();
  }

  bool canPop() {
    return routeStack.length > 1;
  }

  List<String> routeStack = ['/'];
  _TransitionDirection direction = _TransitionDirection.forward;

  @override
  Widget build(BuildContext context) {
    if (shouldHide) return const SizedBox();

    return Positioned(
      bottom: WindowManagerService.current.controller.wmInsets.bottom + 8.0,
      right: WindowManagerService.current.controller.wmInsets.right + 8,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          alignment: const FractionalOffset(0.8, 1.0),
          child: SurfaceLayer(
            shape: Constants.bigShape,
            width: 524,
            dropShadow: true,
            outline: true,
            child: AnimatedSize(
              duration: Constants.animationDuration,
              curve: Constants.animationCurve,
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              child: ChangeNotifierProvider<QsControllerState>.value(
                value: qsController,
                child: PageTransitionSwitcher(
                  reverse: direction.value,
                  transitionBuilder: (child, primary, secondary) {
                    return SharedAxisTransition(
                      animation: primary,
                      secondaryAnimation: secondary,
                      transitionType: SharedAxisTransitionType.horizontal,
                      fillColor: Colors.transparent,
                      child: Material(
                        type: MaterialType.transparency,
                        child: child,
                      ),
                    );
                  },
                  layoutBuilder: (entries) {
                    return _FixedSizeTransitionStack(
                      reverseDirection: direction.value,
                      fallbackSize: const Size(524, 460),
                      children: entries,
                    );
                  },
                  child: Padding(
                    key: ValueKey(routeStack.last),
                    padding: const EdgeInsets.all(16.0),
                    child: routes[routeStack.last],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QsMain extends StatefulWidget {
  const QsMain({super.key});

  @override
  State<QsMain> createState() => _QsMainState();
}

class _QsMainState extends State<QsMain>
    with StateServiceListener<CustomizationService, QsMain> {
  bool showTray = false;

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    // Action Button Bar
    final List<Widget> qsActionButton = [
      QuickActionButton(
        leading: const FlutterLogo(
          size: 18,
        ),
        title: username,
        onPressed: () => QsController.pushRoute(context, "/pages/account"),
        margin: EdgeInsets.zero,
        textStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).foregroundColor,
        ),
      ),
      const Spacer(),
      QuickActionButton(
        leading: const Icon(Icons.settings),
        onPressed: () => ActionManager.openSettings(context),
      ),
    ];

    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: qsActionButton,
            ),
            _qsTitle(strings.quicksettingsOverlay.quickControls),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QsToggleButton(
                      //TODO change title to "Network"
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay.quickControlsNetworkTitle,
                      ),
                      icon: const ToggleProperty(
                        base: Icons.wifi_off_rounded,
                        active: Icons.wifi_rounded,
                      ),
                      //TODO Capitalise
                      subtitle: ToggleProperty(
                        base: null,
                        active: strings.quicksettingsOverlay
                            .quickControlsNetworkSubtitleConnected,
                      ),
                      enabled:
                          service.enableWifi && !service.enableAirplaneMode,
                      onPressed: (value) => service.enableWifi = value,
                      onMenuPressed: () {
                        QsController.pushRoute(context, "/pages/network");
                      },
                    ),
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings
                            .quicksettingsOverlay.quickControlsBluetoothTitle,
                      ),
                      subtitle: ToggleProperty(
                        base: strings.global.off,
                        active: strings.global.on,
                      ),
                      icon: const ToggleProperty(
                        base: Icons.bluetooth_disabled_rounded,
                        active: Icons.bluetooth_connected_rounded,
                      ),
                      enabled: service.enableBluetooth &&
                          !service.enableAirplaneMode,
                      onPressed: (value) => service.enableBluetooth = value,
                    ),
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay
                            .quickControlsAirplaneModeTitle,
                      ),
                      icon: const ToggleProperty(
                        base: Icons.airplanemode_off_rounded,
                        active: Icons.airplanemode_active_rounded,
                      ),
                      enabled: service.enableAirplaneMode,
                      onPressed: (value) => service.enableAirplaneMode = value,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay.quickControlsLanguageTitle,
                      ),
                      //TODO Fix this
                      subtitle: ToggleProperty.singleState(
                        context.locale.toLanguageTag(),
                      ),
                      icon: const ToggleProperty.singleState(
                        Icons.language_rounded,
                      ),
                      enabled: true,
                      onPressed: (_) {
                        final int index =
                            context.supportedLocales.indexOf(context.locale);
                        if (index + 1 < locales.supportedLocales.length) {
                          context.locale = context.supportedLocales[index + 1];
                        } else {
                          context.locale = context.supportedLocales[0];
                        }
                      },
                      onMenuPressed: () {
                        QsController.pushRoute(context, "/pages/language");
                      },
                    ),
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay.quickControlsThemeTitle,
                      ),
                      icon: const ToggleProperty.singleState(
                        Icons.palette_outlined,
                      ),
                      enabled: true,
                      onPressed: (_) => service.darkMode = !service.darkMode,
                      onMenuPressed: () =>
                          QsController.pushRoute(context, "/pages/theme"),
                    ),
                    QsToggleButton(
                      title: ToggleProperty.singleState(
                        strings.quicksettingsOverlay
                            .quickControlsDonotdisturbTitle,
                      ),
                      icon: const ToggleProperty.singleState(
                        Icons.do_not_disturb_off_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ListenableServiceBuilder<TrayService>(
              builder: (context, _) {
                final items = TrayService.current.items;

                if (items.isEmpty) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _qsTitle("Tray icons"),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: items
                          .map(
                            (e) => QsTrayMenuItem(item: e),
                          )
                          .toList(),
                    ),
                  ],
                );
              },
            ),
            _qsTitle(strings.quicksettingsOverlay.shortcutsTitle),
            Row(
              children: [
                QsShortcutButton(
                  title: strings.quicksettingsOverlay.shortcutsNewEvent,
                  icon: Icons.calendar_today_rounded,
                ),
                QsShortcutButton(
                  title: strings.quicksettingsOverlay.shortcutsAlphaBuild,
                  icon: Icons.info_outline_rounded,
                ),
                const QsShortcutButton(
                  title: "dahliaos.io",
                  icon: Icons.language_rounded,
                ),
                const QsShortcutButton(),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                QsSlider(
                  icon: service.muteVolume
                      ? Icons.volume_off_rounded
                      : Icons.volume_up_rounded,
                  onChanged: (val) {
                    service.volume = val;
                    service.muteVolume = val == 0;
                  },
                  value: !service.muteVolume ? service.volume : 0,
                  steps: 20,
                  onIconTap: () => service.muteVolume = !service.muteVolume,
                ),
                QsSlider(
                  icon: service.autoBrightness
                      ? Icons.brightness_auto_rounded
                      : Icons.brightness_5_rounded,
                  onChanged: (val) => service.brightness = val,
                  value: service.brightness,
                  steps: 10,
                  onIconTap: () =>
                      service.autoBrightness = !service.autoBrightness,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListenableServiceBuilder<DateTimeService>(
                  builder: (BuildContext context, _) {
                    final String date = DateTimeService.current.formattedDate;
                    final String time = DateTimeService.current.formattedTime;

                    return QuickActionButton(
                      leading: const Icon(Icons.calendar_today),
                      title: "$date - $time",
                      margin: EdgeInsets.zero,
                    );
                  },
                ),
                if (PowerService.current.hasBattery)
                  PowerServiceBuilder(
                    builder:
                        (context, child, percentage, charging, powerSaver) {
                      return QuickActionButton(
                        leading: BatteryIndicator(
                          percentage: percentage,
                          charging: charging,
                          powerSaving: powerSaver,
                        ),
                        title: "$percentage %",
                        margin: EdgeInsets.zero,
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _qsTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 12.0, 0.0, 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

final class QsController {
  const QsController._();

  static void pushRoute(
    BuildContext context,
    String name, {
    bool listen = false,
  }) {
    final controller = QsController.of(context, listen: listen);
    controller.pushRoute(name);
  }

  static void popRoute(BuildContext context, {bool listen = false}) {
    final controller = QsController.of(context, listen: listen);
    controller.popRoute();
  }

  static bool canPop(BuildContext context, {bool listen = false}) {
    final controller = QsController.of(context, listen: listen);
    return controller.canPop();
  }

  static QsControllerState of(BuildContext context, {bool listen = true}) {
    return Provider.of<QsControllerState>(context, listen: listen);
  }
}

class QsControllerState with ChangeNotifier {
  final _QuickSettingsOverlayState _state;

  QsControllerState._(this._state);

  void pushRoute(String name) => _state.pushRoute(name);
  void popRoute() => _state.popRoute();
  bool canPop() => _state.canPop();

  void _notify() => notifyListeners();
}

class _FixedSizeTransitionStack extends MultiChildRenderObjectWidget {
  final bool reverseDirection;
  final Size fallbackSize;

  const _FixedSizeTransitionStack({
    required super.children,
    this.reverseDirection = false,
    required this.fallbackSize,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderFixedSizeTransitionStack(
      alignment: Alignment.bottomCenter,
      textDirection: Directionality.of(context),
      reverseDirection: reverseDirection,
      fallbackSize: fallbackSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderFixedSizeTransitionStack renderObject,
  ) {
    renderObject
      ..alignment = Alignment.bottomCenter
      ..textDirection = Directionality.of(context)
      ..reverseDirection = reverseDirection
      ..fallbackSize = fallbackSize;
  }
}

class _RenderFixedSizeTransitionStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, StackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, StackParentData> {
  _RenderFixedSizeTransitionStack({
    List<RenderBox>? children,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    bool reverseDirection = false,
    Size fallbackSize = Size.zero,
  })  : _alignment = alignment,
        _textDirection = textDirection,
        _reverseDirection = reverseDirection,
        _fallbackSize = fallbackSize {
    addAll(children);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! StackParentData) {
      child.parentData = StackParentData();
    }
  }

  AlignmentGeometry get alignment => _alignment;
  AlignmentGeometry _alignment;
  set alignment(AlignmentGeometry value) {
    if (_alignment == value) {
      return;
    }
    _alignment = value;
    _markNeedResolution();
  }

  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;
  set textDirection(TextDirection? value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    _markNeedResolution();
  }

  bool get reverseDirection => _reverseDirection;
  bool _reverseDirection;
  set reverseDirection(bool value) {
    if (_reverseDirection == value) {
      return;
    }
    _reverseDirection = value;
    markNeedsLayout();
  }

  Size get fallbackSize => _fallbackSize;
  Size _fallbackSize;
  set fallbackSize(Size value) {
    if (_fallbackSize == value) {
      return;
    }
    _fallbackSize = value;
    markNeedsLayout();
  }

  void _markNeedResolution() {
    _resolvedAlignment = null;
    markNeedsLayout();
  }

  Alignment? _resolvedAlignment;

  void _resolve() {
    if (_resolvedAlignment != null) {
      return;
    }
    _resolvedAlignment = alignment.resolve(textDirection);
  }

  RenderBox? get startChild => reverseDirection ? firstChild : lastChild;

  static double getIntrinsicDimension(
    RenderBox? childToMeasure,
    double Function(RenderBox child) mainChildSizeGetter,
  ) {
    double extent = 0.0;
    final child = childToMeasure;
    if (child != null) {
      final StackParentData childParentData =
          child.parentData! as StackParentData;
      extent = mainChildSizeGetter(child);
      assert(child.parentData == childParentData);
    }
    return extent;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return getIntrinsicDimension(
      startChild,
      (RenderBox child) => child.getMinIntrinsicWidth(height),
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return getIntrinsicDimension(
      startChild,
      (RenderBox child) => child.getMaxIntrinsicWidth(height),
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return getIntrinsicDimension(
      startChild,
      (RenderBox child) => child.getMinIntrinsicHeight(width),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return getIntrinsicDimension(
      startChild,
      (RenderBox child) => child.getMaxIntrinsicHeight(width),
    );
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  Size _computeSize({
    required BoxConstraints constraints,
    required ChildLayouter layoutChild,
  }) {
    _resolve();
    assert(_resolvedAlignment != null);
    if (childCount == 0) {
      return (constraints.biggest.isFinite)
          ? constraints.biggest
          : constraints.smallest;
    }

    double width = constraints.minWidth;
    double height = constraints.minHeight;

    final BoxConstraints nonPositionedConstraints = constraints.loosen();

    RenderBox? child = startChild;
    int i = 0;
    while (child != null) {
      final StackParentData childParentData =
          child.parentData! as StackParentData;

      if (!childParentData.isPositioned) {
        final Size childSize = layoutChild(child, nonPositionedConstraints);

        if (i == 0) {
          width = max(width, childSize.width);
          height = max(height, childSize.height);
        }
      }

      child = reverseDirection
          ? childParentData.nextSibling
          : childParentData.previousSibling;
      i++;
    }

    final Size size = Size(width, height);
    assert(size.width == constraints.constrainWidth(width));
    assert(size.height == constraints.constrainHeight(height));

    assert(size.isFinite);

    return size;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;

    size = _computeSize(
      constraints: constraints,
      layoutChild: (box, constraints) {
        final size = box.getDryLayout(constraints);

        final unboundedWidth = size.width == double.infinity &&
            constraints.maxWidth == double.infinity;
        final unboundedHeight = size.height == double.infinity &&
            constraints.maxHeight == double.infinity;

        final BoxConstraints newConstraints;
        if (unboundedWidth || unboundedHeight) {
          newConstraints = BoxConstraints(
            minWidth: constraints.minWidth,
            maxWidth:
                unboundedWidth ? fallbackSize.width : constraints.maxWidth,
            minHeight: constraints.minHeight,
            maxHeight:
                unboundedHeight ? fallbackSize.height : constraints.maxHeight,
          );
        } else {
          newConstraints = constraints;
        }
        box.layout(newConstraints, parentUsesSize: true);

        return box.size;
      },
    );

    assert(_resolvedAlignment != null);
    RenderBox? child = firstChild;
    while (child != null) {
      final StackParentData childParentData =
          child.parentData! as StackParentData;

      if (!childParentData.isPositioned) {
        childParentData.offset =
            _resolvedAlignment!.alongOffset(size - child.size as Offset);
      } else {
        layoutPositionedChild(
          child,
          childParentData,
          size,
          _resolvedAlignment!,
        );
      }

      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
  }

  static bool layoutPositionedChild(
    RenderBox child,
    StackParentData childParentData,
    Size size,
    Alignment alignment,
  ) {
    assert(childParentData.isPositioned);
    assert(child.parentData == childParentData);

    bool hasVisualOverflow = false;
    BoxConstraints childConstraints = const BoxConstraints();

    if (childParentData.left != null && childParentData.right != null) {
      childConstraints = childConstraints.tighten(
        width: size.width - childParentData.right! - childParentData.left!,
      );
    } else if (childParentData.width != null) {
      childConstraints = childConstraints.tighten(width: childParentData.width);
    }

    if (childParentData.top != null && childParentData.bottom != null) {
      childConstraints = childConstraints.tighten(
        height: size.height - childParentData.bottom! - childParentData.top!,
      );
    } else if (childParentData.height != null) {
      childConstraints =
          childConstraints.tighten(height: childParentData.height);
    }

    child.layout(childConstraints, parentUsesSize: true);

    final double x;
    if (childParentData.left != null) {
      x = childParentData.left!;
    } else if (childParentData.right != null) {
      x = size.width - childParentData.right! - child.size.width;
    } else {
      x = alignment.alongOffset(size - child.size as Offset).dx;
    }

    if (x < 0.0 || x + child.size.width > size.width) {
      hasVisualOverflow = true;
    }

    final double y;
    if (childParentData.top != null) {
      y = childParentData.top!;
    } else if (childParentData.bottom != null) {
      y = size.height - childParentData.bottom! - child.size.height;
    } else {
      y = alignment.alongOffset(size - child.size as Offset).dy;
    }

    if (y < 0.0 || y + child.size.height > size.height) {
      hasVisualOverflow = true;
    }

    childParentData.offset = Offset(x, y);

    return hasVisualOverflow;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
