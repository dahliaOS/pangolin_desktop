# Pangolin Desktop
Status: ![](https://github.com/dahlia-os/pangolin-desktop/workflows/CI/badge.svg)

Latest APK: [download from gitlab](https://gitlab.com/dahlia-os/pangolin-desktop/-/jobs/artifacts/master/browse/build/app/outputs/apk/debug/?job=build_android)

Desktop shell for DahliaOS, Written in flutter. Runs on Linux and Zircon.

## Build Pangolin Desktop

Check The Wiki:

[/wiki/Build-Pangolin-Desktop](https://github.com/dahlia-os/pangolin-desktop/wiki/Build-Pangolin-Desktop)


## What Is Pangolin?
Pangolin was named after a shelled animal like the armadillo ([armadillo ui](https://9to5google.com/2018/12/26/fuchsia-armadillo-ui-gone/)). Pangolin-Desktop is based on the deprecated Capybara shell, with a custom window management system built from the ground up.

![Capybara UI Apk](https://github.com/dahlia-os/Icons/blob/master/UI-Screenshots/Pangolin-2020-23_04.png)
Pangolin Desktop

## What will happen to Pangolin once the kernel is ready?
As soon as the kernel is ready to handle Pangolin, support for running Pangolin on any other system than Fuchsia and Dahlia Linux will be removed due to the deep integration the shell has with the underlying system. We will ensure that it will remain somewhat compatible with other systems, but we cannot ensure permanent compatibility with Android, IOS, Linux, Web, and Mac OS.


## Important Style guide!
All dahlia applications MUST have a central theme color, that is not #ff5722, or material-deeporange or similar, as that is reserved for the system. Uploaders must upload a theme.txt in the root of their application, that contains the theme color, in preferably hexadecimal, but RGBA is acceptable as well. Uncompliant applications will have their theme colors set to a random color.
