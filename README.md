# hello-objc
A minimal macOS app written in Objective-C, with the UI built **entirely programmatically** &mdash; no `.nib` files or Interface Builder required. 

## **Overview**  
`hello-objc` is inspired by Jeff Johnson's [Working Without a NIB](https://lapcatsoftware.com/blog/2007/05/16/working-without-a-nib-part-1/) project, which builds the entire UI programmatically using the Cocoa application framework. Owing to its reliance on Cocoa and the AppKit framework, `hello-objc` can run on every version of Mac OS X / OS X / macOS &mdash; from Mac OS X 10.0 Cheetah (2001), to macOS 15.0 Sequoia (present)!

## Build
The build can be initiated by invoking the `build.command` file from the Terminal:
```sh
chmod +x build.command
./build.command
```
This will compile `hello.m` and assemble a `.app` bundle, ready for execution.

_**NOTE**: The build process will require Xcode command-line tools to be installed on your computer. You can install the tools by running `xcode-select --install` from the Terminal._
