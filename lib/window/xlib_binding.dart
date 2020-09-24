import 'dart:ffi';

DynamicLibrary _dylib = DynamicLibrary.open("libX11.so.6");

const int XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY = 524288;
const int XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT = 1048576;

class XDisplay extends Struct {}

class Screen extends Struct {
  Pointer<XExtData> ext_data;

  Pointer<XDisplay> display;

  @Uint64()
  int root;

  @Int32()
  int width;

  @Int32()
  int height;

  @Int32()
  int mwidth;

  @Int32()
  int mheight;

  @Int32()
  int ndepths;

  Pointer<Depth> depths;

  @Int32()
  int root_depth;

  Pointer<Visual> root_visual;

  Pointer<_XGC> default_gc;

  @Uint64()
  int cmap;

  @Uint64()
  int white_pixel;

  @Uint64()
  int black_pixel;

  @Int32()
  int max_maps;

  @Int32()
  int min_maps;

  @Int32()
  int backing_store;

  @Int32()
  int save_unders;

  @Int64()
  int root_input_mask;
}

class Depth extends Struct {
  @Int32()
  int depth;

  @Int32()
  int nvisuals;

  Pointer<Visual> visuals;
}

class XExtData extends Struct {
  @Int32()
  int number;

  Pointer<XExtData> next;

  Pointer<NativeFunction<_typedefC_1>> free_private;

  Pointer<Int8> private_data;
}

class Visual extends Struct {
  Pointer<XExtData> ext_data;

  @Uint64()
  int visualid;

  @Int32()
  int class_1;

  @Uint64()
  int red_mask;

  @Uint64()
  int green_mask;

  @Uint64()
  int blue_mask;

  @Int32()
  int bits_per_rgb;

  @Int32()
  int map_entries;
}

class XErrorEvent extends Struct {
  @Int32()
  int type;

  Pointer<XDisplay> display;

  @Uint64()
  int resourceid;

  @Uint64()
  int serial;

  @Uint8()
  int error_code;

  @Uint8()
  int request_code;

  @Uint8()
  int minor_code;
}

class _XGC extends Struct {}

typedef _typedefC_1 = Int32 Function(
    Pointer<XExtData>,
    );

typedef _c_XOpenDisplay = Pointer<XDisplay> Function(
    Pointer<Int8> arg0,
    );

typedef _dart_XOpenDisplay = Pointer<XDisplay> Function(
    Pointer<Int8> arg0,
    );

typedef _c_XScreenCount = Int32 Function(
    Pointer<XDisplay> arg0,
    );

typedef _dart_XScreenCount = int Function(
    Pointer<XDisplay> arg0,
    );

typedef _c_XDisplayHeight = Int32 Function(
    Pointer<XDisplay> arg0,
    Int32 arg1,
    );

typedef _dart_XDisplayHeight = int Function(
    Pointer<XDisplay> arg0,
    int arg1,
    );

typedef _c_XDisplayWidth = Int32 Function(
    Pointer<XDisplay> arg0,
    Int32 arg1,
    );

typedef _dart_XDisplayWidth = int Function(
    Pointer<XDisplay> arg0,
    int arg1,
    );

typedef _c_XScreenOfDisplay = Pointer<Screen> Function(
    Pointer<XDisplay> arg0,
    Int32 arg1,
    );

typedef _dart_XScreenOfDisplay = Pointer<Screen> Function(
    Pointer<XDisplay> arg0,
    int arg1,
    );

typedef _c_XDefaultRootWindow = Uint64 Function(
    Pointer<XDisplay> arg0,
    );

typedef _dart_XDefaultRootWindow = int Function(
    Pointer<XDisplay> arg0,
    );

typedef _c_XSetErrorHandler = Pointer<NativeFunction<XErrorHandler>>
Function(
    Pointer<NativeFunction<XErrorHandler>> arg0,
    );

typedef _dart_XSetErrorHandler = Pointer<NativeFunction<XErrorHandler>>
Function(
    Pointer<NativeFunction<XErrorHandler>> arg0,
    );

typedef XErrorHandler = Pointer<Int32> Function(
    Pointer<XDisplay>,
    Pointer<XErrorEvent>,
    );

typedef _c_XSelectInput = Int32 Function(
    Pointer<XDisplay> arg0,
    Uint64 arg1,
    Int64 arg2,
    );

typedef _dart_XSelectInput = int Function(
    Pointer<XDisplay> arg0,
    int arg1,
    int arg2,
    );

typedef _c_XSync = Int32 Function(
    Pointer<XDisplay> arg0,
    Int32 arg1,
    );

typedef _dart_XSync = int Function(
    Pointer<XDisplay> arg0,
    int arg1,
    );

typedef _c_XDisplayString = Pointer<Int8> Function(
    Pointer<XDisplay> arg0,
    );

typedef _dart_XDisplayString = Pointer<Int8> Function(
    Pointer<XDisplay> arg0,
    );

typedef _c_XNextEvent = Int32 Function(
    Pointer<Int32> dpy,
    Pointer<Int32> event,
    );

typedef _dart_XNextEvent = int Function(
    Pointer<Int32> dpy,
    Pointer<Int32> event,
    );

_dart_XOpenDisplay _XOpenDisplay;
Pointer<XDisplay> XOpenDisplay(
    Pointer<Int8> arg0,
    ) {
  _XOpenDisplay ??= _dylib
      .lookupFunction<_c_XOpenDisplay, _dart_XOpenDisplay>('XOpenDisplay');
  return _XOpenDisplay(
    arg0,
  );
}

_dart_XScreenCount _XScreenCount;
int XScreenCount(
    Pointer<XDisplay> arg0,
    ) {
  _XScreenCount ??= _dylib
      .lookupFunction<_c_XScreenCount, _dart_XScreenCount>('XScreenCount');
  return _XScreenCount(
    arg0,
  );
}

_dart_XDisplayWidth _XDisplayWidth;
int XDisplayWidth(
    Pointer<XDisplay> arg0,
    int arg1,
    ) {
  _XDisplayWidth ??= _dylib
      .lookupFunction<_c_XDisplayWidth, _dart_XDisplayWidth>('XDisplayWidth');
  return _XDisplayWidth(
    arg0,
    arg1,
  );
}

_dart_XDisplayHeight _XDisplayHeight;
int XDisplayHeight(
    Pointer<XDisplay> arg0,
    int arg1,
    ) {
  _XDisplayHeight ??= _dylib
      .lookupFunction<_c_XDisplayHeight, _dart_XDisplayWidth>('XDisplayHeight');
  return _XDisplayHeight(
    arg0,
    arg1,
  );
}

_dart_XScreenOfDisplay _XScreenOfDisplay;
Pointer<Screen> XScreenOfDisplay(
    Pointer<XDisplay> arg0,
    int arg1,
    ) {
  _XScreenOfDisplay ??=
      _dylib.lookupFunction<_c_XScreenOfDisplay, _dart_XScreenOfDisplay>(
          'XScreenOfDisplay');
  return _XScreenOfDisplay(
    arg0,
    arg1,
  );
}

_dart_XDefaultRootWindow _XDefaultRootWindow;
int XDefaultRootWindow(
    Pointer<XDisplay> arg0,
    ) {
  _XDefaultRootWindow ??=
      _dylib.lookupFunction<_c_XDefaultRootWindow, _dart_XDefaultRootWindow>(
          'XDefaultRootWindow');
  return _XDefaultRootWindow(
    arg0,
  );
}

_dart_XSetErrorHandler _XSetErrorHandler;
Pointer<NativeFunction<XErrorHandler>> XSetErrorHandler(
    arg0,
    ) {
  _XSetErrorHandler ??=
      _dylib.lookupFunction<_c_XSetErrorHandler, _dart_XSetErrorHandler>(
          'XSetErrorHandler');
  return _XSetErrorHandler(
    arg0,
  );
}

_dart_XSelectInput _XSelectInput;
int XSelectInput(
    Pointer<XDisplay> arg0,
    int arg1,
    int arg2,
    ) {
  _XSelectInput ??= _dylib
      .lookupFunction<_c_XSelectInput, _dart_XSelectInput>('XSelectInput');
  return _XSelectInput(
    arg0,
    arg1,
    arg2,
  );
}

_dart_XSync _XSync;
int XSync(
    Pointer<XDisplay> arg0,
    int arg1,
    ) {
  _XSync ??= _dylib.lookupFunction<_c_XSync, _dart_XSync>('XSync');
  return _XSync(
    arg0,
    arg1,
  );
}

_dart_XDisplayString _XDisplayString;
Pointer<Int8> XDisplayString(
    Pointer<XDisplay> arg0,
    ) {
  _XDisplayString ??=
      _dylib.lookupFunction<_c_XDisplayString, _dart_XDisplayString>(
          'XDisplayString');
  return _XDisplayString(
    arg0,
  );
}

_dart_XNextEvent _XNextEvent;
int XNextEvent(
    Pointer<Int32> dpy,
    Pointer<Int32> event,
    ) {
  _XNextEvent ??=
      _dylib.lookupFunction<_c_XNextEvent, _dart_XNextEvent>('XNextEvent');
  return _XNextEvent(
    dpy,
    event,
  );
}
