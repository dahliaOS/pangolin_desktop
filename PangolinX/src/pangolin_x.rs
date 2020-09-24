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

    #[no_mangle]
    pub unsafe extern "C" fn init(display:*mut Display) {
        println!("PangolinX: Beginning Window Manager Registration");
        XSetErrorHandler(Some(on_wm_detected));
        XSelectInput(display, XDefaultRootWindow(display), SubstructureRedirectMask | SubstructureNotifyMask);
        XSync(display, 0);

        loop {
            let mut x_event = XEvent { pad: [0; 24] };
            XNextEvent(display, &mut x_event);
            match x_event.type_ {
                CreateNotify => {
                    let mut created: String = "PangolinX: A new window was created: #".to_owned();
                    created.push_str(x_event.create_window.window.to_string().as_ref());
                    println!("{}",created);
                },
                ConfigureRequest => {
                    let mut configured: String = "PangolinX: Window re-configured: #".to_owned();
                    configured.push_str(x_event.configure_request.window.to_string().as_ref());
                    println!("{}",configured);
                },
                _ => {
                    let mut un_managed: String = "PangolinX: Un-managed event id#".to_owned();
                    un_managed.push_str(x_event.type_.to_string().as_ref());
                    println!("{}",un_managed);
                }
            }
        }
    }

    extern "C" fn on_x_error() -> i32 {
        return 0;
    }

    unsafe extern "C" fn on_wm_detected(_display:*mut Display, error:*mut XErrorEvent) -> c_int {
        if (*error).error_code == BadAccess {
            println!("PangolinX: Another window manager is already running.")
        }
        return 0;
    }
}