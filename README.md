# Pangolin Desktop
Our pride and joy of the dahliaOS project... our desktop is made to be
simple and easy to use. Pangolin-Desktop is still in development and can't be used
for everyday tasks (yet).

## Build Pangolin Desktop

Check The Wiki:

[/wiki/Build-Pangolin-Desktop](https://github.com/dahlia-os/pangolin-desktop/wiki/Build-Pangolin-Desktop)

Get the dahlia environment:

[Dahlia Environment Installer](https://github.com/dahlia-os/dahlia-environment)

## What Is Pangolin?
Pangolin is named after a animal with a shell (kinda like a armadillo) Pangolin is based on the deprecated Capybara shell, however is far more complete, with a custom window management system built from the ground up.

![Capybara UI Apk](https://github.com/dahlia-os/Icons/blob/master/UI-Screenshots/ScreenShot-Term.png)
Pangolin Desktop

## What will happen to Pangolin once the kernel is ready?
As soon as the kernel is ready to handle Pangolin, support for running Pangolin on any other system than Fuchsia and Dahlia Linux will be removed due to the deep integration the shell has with the underlying system. We will ensure that it will remain somewhat compatible with other systems, but we cannot ensure permanent compatibility with Android, IOS, Linux, Web, and Mac OS.


## Important Style guide!
All dahlia applications MUST have a central theme color, that is not #ff5722, or material-deeporange or similar, as that is reserved for the system. Uploaders must upload a theme.txt in the root of their application, that contains the theme color, in preferably hexadecimal, but RGBA is acceptable as well. Uncompliant applications will have their theme colors set to a random color.
