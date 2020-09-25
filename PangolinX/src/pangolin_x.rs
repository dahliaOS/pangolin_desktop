use std::ptr::{null};
use x11::xlib::*;
use std::thread;

#[no_mangle]
pub unsafe extern "C" fn init_window_manager() {
    thread::spawn(|| {
        let display: *mut Display = XOpenDisplay(null());
        if display.is_null() {
            println!("PangolinX: Unable to open the default X display!");
            return;
        }
        println!("Display Information:");
        let mut display_size: String = " * Size: ".to_owned();
        display_size.push_str(XDisplayWidth(display, 0).to_string().as_ref());
        display_size.push_str("x");
        display_size.push_str(XDisplayHeight(display, 0).to_string().as_ref());
        println!("{}", display_size);
        let mut screens: i32 = XScreenCount(display);
        let mut total_screens: String = " * Total Screens: ".to_owned();
        total_screens.push_str(screens.to_string().as_ref());
        println!("{}",total_screens);
        while screens > 0 {
            let screen: *mut Screen = XScreenOfDisplay(display, screens-1);
            let mut screen_title: String = "Screen #".to_owned();
            screen_title.push_str(screens.to_string().as_ref());
            screen_title.push_str(":");
            println!("{}",screen_title);
            let mut screen_size: String = " * Size: ".to_owned();
            screen_size.push_str((*screen).width.to_string().as_ref());
            screen_size.push_str("x");
            screen_size.push_str((*screen).height.to_string().as_ref());
            println!("{}",screen_size);
            screens=screens-1;
        }

        window_manager::init(display);
    });
}

pub mod window_manager {
    use x11::xlib::*;
    use std::os::raw::c_int;
    use std::borrow::{BorrowMut};
    use std::ptr::{null_mut};

    static clients: [Window; 0] = [];

    #[no_mangle]
    pub unsafe extern "C" fn init(display:*mut Display) {
        println!("PangolinX: Beginning Window Manager Registration");
        XGrabServer(display);
        XSetErrorHandler(Some(on_wm_detected));
        XSelectInput(display, XDefaultRootWindow(display), SubstructureRedirectMask | SubstructureNotifyMask);
        XSync(display, 0);



        loop {
            let mut x_event: XEvent = XEvent{ pad: [0; 24]};
            XNextEvent(display, &mut x_event);
            match x_event.type_ {
                CreateNotify => {
                    let mut created: String = "PangolinX: Window was created: #".to_owned();
                    created.push_str(x_event.create_window.window.to_string().as_ref());
                    println!("{}",created);
                    on_window_create(display, x_event.create_window);
                },
                ConfigureRequest => {
                    let mut configured: String = "PangolinX: Window re-configured: #".to_owned();
                    configured.push_str(x_event.configure_request.window.to_string().as_ref());
                    println!("{}",configured);
                    on_window_config(display, x_event.configure_request);
                },
                MapRequest => {
                    let mut mapped: String = "PangolinX: Window mapped: #".to_owned();
                    mapped.push_str(x_event.map_request.window.to_string().as_ref());
                    println!("{}",mapped);
                    on_window_map(display, x_event.map_request);
                },
                DestroyNotify => {
                    let mut destroyed: String = "PangolinX: Window destroyed: #".to_owned();
                    destroyed.push_str(x_event.destroy_window.window.to_string().as_ref());
                    println!("{}",destroyed);
                },
                _ => {
                    let mut un_managed: String = "PangolinX: Un-managed event id#".to_owned();
                    un_managed.push_str(x_event.type_.to_string().as_ref());
                    println!("{}",un_managed);
                }
            }
        }
    }

    //extern "C" fn on_x_error() -> i32 { return 0; }

    unsafe extern "C" fn on_wm_detected(_display:*mut Display, error:*mut XErrorEvent) -> c_int {
        if (*error).error_code == BadAccess {
            println!("PangolinX: Another window manager is already running.")
        }
        return 0;
    }

    unsafe extern "C" fn on_window_create(display:*mut Display, event:XCreateWindowEvent) {
        let mut x_window_changes: *mut XWindowChanges = XWindowChanges {
            x: 0,
            y: 0,
            width: 0,
            height: 0,
            border_width: 0,
            sibling: 0,
            stack_mode: 0
        }.borrow_mut();
        (*x_window_changes).x = event.x;
        (*x_window_changes).y = event.y;
        (*x_window_changes).width = event.width;
        (*x_window_changes).height = event.height;
        (*x_window_changes).border_width = 0;
        (*x_window_changes).sibling = 0;
        (*x_window_changes).stack_mode = 1;
        XConfigureWindow(display, event.window, 64, x_window_changes);
    }

    unsafe extern "C" fn on_window_config(display:*mut Display, event:XConfigureRequestEvent) {
        let mut x_window_changes: *mut XWindowChanges = XWindowChanges {
            x: 0,
            y: 0,
            width: 0,
            height: 0,
            border_width: 0,
            sibling: 0,
            stack_mode: 0
        }.borrow_mut();
        (*x_window_changes).x = event.x;
        (*x_window_changes).y = event.y;
        (*x_window_changes).width = event.width;
        (*x_window_changes).height = event.height;
        (*x_window_changes).border_width = 0;
        (*x_window_changes).sibling = event.parent;
        (*x_window_changes).stack_mode = event.type_;
        XConfigureWindow(display, event.window, 64, x_window_changes);
    }

    unsafe extern "C" fn on_window_map(display:*mut Display, mut event:XMapRequestEvent) {
        frame(display, event.window.borrow_mut());
        XMapWindow(display, event.window);
    }

    unsafe extern "C" fn frame(display:*mut Display, window:&mut Window) {
        let mut x_window_attributes: *mut XWindowAttributes = XWindowAttributes {
            x: 0,
            y: 0,
            width: 0,
            height: 0,
            border_width: 0,
            depth: 0,
            visual: null_mut(),
            root: 0,
            class: 0,
            bit_gravity: 0,
            win_gravity: 0,
            backing_store: 0,
            backing_planes: 0,
            backing_pixel: 0,
            save_under: 0,
            colormap: 0,
            map_installed: 0,
            map_state: 0,
            all_event_masks: 0,
            your_event_mask: 0,
            do_not_propagate_mask: 0,
            override_redirect: 0,
            screen: null_mut()
        }.borrow_mut();
        XGetWindowAttributes(display, *window, x_window_attributes);
        let frame: Window = XCreateSimpleWindow(
            display,
            XDefaultRootWindow(display),
            (*x_window_attributes).x,
            (*x_window_attributes).y,
            (*x_window_attributes).width as u32,
            (*x_window_attributes).height as u32,
            3,
            0xff0000,
            0x0000ff
        );
        XSelectInput(display, frame, SubstructureRedirectMask | SubstructureNotifyMask);
        XAddToSaveSet(display, *window);
        XReparentWindow(display, *window, frame, 0, 0);
        XMapWindow(display, frame);
        clients[window.to_owned()] = frame;
    }
}