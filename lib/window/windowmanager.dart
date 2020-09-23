import 'dart:ffi';
import 'package:Pangolin/window/xlib_binding.dart';

void initWindowManager() {
  Pointer<XDisplay> display = XOpenDisplay(Pointer.fromAddress(0));
  print("Display Information: ");
  print(" * Size: "+XDisplayWidth(display, 0).toString()+"x"+XDisplayHeight(display, 0).toString());
  int screens = XScreenCount(display);
  print(" * Total Screens: "+screens.toString());
  while(screens > 0) {
    Screen screen = XScreenOfDisplay(display, screens-1).ref;
    print("Screen #"+screens.toString()+":");
    print(" * Size: "+screen.width.toString()+"x"+screen.height.toString());
    screens--;
  }
}

class WindowManager {

}