#[no_mangle]
use std::ptr::{null};
use x11::xlib::{
    Display,
    Screen,
    XOpenDisplay,
    XDisplayWidth,
    XDisplayHeight,
    XScreenCount,
    XScreenOfDisplay
};

pub unsafe extern fn init_window_manager() {
    let display: *mut Display = XOpenDisplay(null());
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
        let screen: *mut Screen = XScreenOfDisplay(display, screens);
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
}