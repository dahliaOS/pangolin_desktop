// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
//import 'dart:ui' hide Window;

import 'package:GeneratedApp/applications/filesOLD.dart';
import 'package:GeneratedApp/applications/terminal/main.dart';
import 'package:GeneratedApp/commons/key_ring.dart';
// import 'package:GeneratedApp/commons/functions.dart';
// import 'package:GeneratedApp/launcher_toggle.dart';
// import 'package:GeneratedApp/quick_settings.dart';
// import 'package:GeneratedApp/status_tray.dart';
import 'package:GeneratedApp/widgets/app_launcher.dart';
// import 'package:GeneratedApp/window/window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GeneratedApp/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'mocks.dart';

Future<void> main() async {
  isTesting = true;
  BoxMock box;
  // var settingsInit = () async {
  //   //TestWidgetsFlutterBinding.ensureInitialized();
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   Hive.init(dir.path);
  //   box = await Hive.openBox<String>("settings");
  //   await box.clear(); //start with fresh settings
  // };
  //test('Settings init', settingsInit, skip: "This should be ran with every test instead of on its own.");
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
  //await settingsInit();
  testWidgets('Mock box unit test', (WidgetTester tester) async {
    box = BoxMock<String>();
    box.put("test_mockup", "value");
    assert(box.get("test_mockup") == "value");
    Pangolin.settingsBox = box as BoxMock<String>;
  });
  testWidgets('customBar test', (WidgetTester tester) async {
    print("Launching Pangolin");
    await tester.pumpWidget(Pangolin());
    //print((await tester.pumpAndSettle()).toString() + " frames on load!");
    await tester.pump();
    expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
    print("Opening bar");
    var gest = await tester.startGesture(tester.getCenter(
        find.byWidgetPredicate((widget) =>
            widget is GestureDetector &&
            widget.onTapCancel == () => true == true)));
    await gest.moveBy(Offset(0, -50));
    await gest.up();
    print("Testing Files");
    await tester.tap(find.byWidgetPredicate(
        (element) =>
            (element is AppLauncherPanelButton && element.app is Files),
        description: "Bottom bar app icon that opens the Files app"));
    await tester.pump();
    expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
    //});
    //await settingsInit();
    // testWidgets('Try to open Terminal', (WidgetTester tester) async {
    //   await tester.pumpWidget(Pangolin());
    //   await tester.pump();
    //   expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
    print("Testing Terminal"); // ---
    await tester.tap(find.byWidgetPredicate(
        (element) =>
            (element is AppLauncherPanelButton && element.app is TerminalApp),
        description: "AppLauncherPanelButton that launches Terminal"));
    await tester.pump();
    //print((await tester.pumpAndSettle()).toString() + " frame(s) on animation!");
    expect(find.byType(ErrorWidget), findsNothing); //no error widgets here
    await tester.pump();
    // print("Checkpoint cleanup"); // ---
    // await tester.idle();
    // print("Closing Files"); // ---
    // expect(find.byType(Files), findsOneWidget);
    // await tester.tap(
    //   // zfind.descendant(
    //   //   of: find.byType(FilesBar),
    //   //   matching: find.widgetWithIcon(IconButton, Icons.close))
    //   find.descendant(
    //     of: find.byType(Window),
    //     matching: find.widgetWithIcon(IconButton, Icons.close)
    //   )
    // );
    // await tester.pumpAndSettle();
    // expect(find.byType(Files), findsNothing);
    // print("Closing Terminal"); // ---
    // expect(find.byType(Terminal), findsOneWidget);
    // await tester.tap(
    //   find.descendant(
    //     of: find.byType(Window),
    //     matching: find.widgetWithIcon(IconButton, Icons.close)
    //   )
    // );
    // await tester.pumpAndSettle();
    // expect(find.byType(Terminal), findsNothing);
    print("Cleaning up"); // ---
    await tester.idle();
    //assert(tester.widget(find.byType(TerminalApp)).
    //@bleonard252: wait for Bash to be ready. if it errors, fail
    // I'll probably make more specific Terminal tests,
    // first that it opens, then how it reacts to different platforms
  }, skip: true); /* }); */
}
