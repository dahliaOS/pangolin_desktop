// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ui';

import 'package:GeneratedApp/applications/terminal.dart';
import 'package:GeneratedApp/launcher_toggle.dart';
import 'package:GeneratedApp/status_tray.dart';
import 'package:GeneratedApp/widgets/app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GeneratedApp/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(Pangolin());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  testWidgets('Try to open Files', (WidgetTester tester) async {
    await tester.pumpWidget(Pangolin());
    await tester.tap(
      find.byWidgetPredicate(
        (element) => (element is AppLauncherPanelButton && element.icon.endsWith("files.png"))
      )
    );
    print((await tester.pumpAndSettle()).toString() + " frames on animation!");
    // assert(tester.firstWidget<BackdropFilter>(
    //   find.ancestor(
    //     of: find.text("Files"), 
    //     matching: find.byElementType(BackdropFilter)))
    //   .filter != null,
    //   "Files app bar should have a blur"
    // ); //don't know why I did that one
  });
  testWidgets('Try to open Terminal', (WidgetTester tester) async {
    await tester.pumpWidget(Pangolin());
    await tester.tap(
      find.byWidgetPredicate(
        (element) => (element is AppLauncherPanelButton && element.icon.endsWith("terminal.png"))
      )
    );
    print((await tester.pumpAndSettle()).toString() + " frames on animation!");
    //assert(tester.widget(find.byType(TerminalApp)).
    //TODO(bleonard252): wait for Bash to be ready. if it errors, fail
  });
  testWidgets('Try to open Quick Settings', (WidgetTester tester) async {
    await tester.pumpWidget(Pangolin());
    await tester.tap(find.byType(StatusTrayWidget));
    print((await tester.pumpAndSettle()).toString() + " frames on animation!");
  });
  testWidgets('Try to open Launcher', (WidgetTester tester) async {
    await tester.pumpWidget(Pangolin());
    await tester.tap(find.byType(LauncherToggleWidget));
    print((await tester.pumpAndSettle()).toString() + " frames on animation!");
  });
}
