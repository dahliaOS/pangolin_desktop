import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'package:Pangolin/window/pangolinx_bindings.dart';


void initWindowManager() {
  if(!Platform.isLinux) return;
  PangolinX pangolinX = PangolinX(DynamicLibrary.open("./lib/libpangolin_x.so"));
  pangolinX.init_window_manager();
}
