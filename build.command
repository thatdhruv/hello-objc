#!/bin/bash

cd "$(dirname "$0")"

if [[ ! -d "Hello.app" ]]; then
    mkdir -p Hello.app/Contents/{MacOS,Resources}
fi

cc -Wall -o Hello hello.m -framework Cocoa
mv Hello Hello.app/Contents/MacOS/Hello

cat <<INFOPLIST >> Hello.app/Contents/Info.plist
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>Hello</string>
    <key>CFBundleIdentifier</key>
    <string>com.dt.hello</string>
    <key>CFBundleName</key>
    <string>Hello</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>NSPrincipalClass</key>
    <string>Hello</string>
</dict>
</plist>
INFOPLIST

cat <<STRINGS >> Hello.app/Contents/Resources/InfoPlist.strings
NSHumanReadableCopyright = "Designed by Dhruv Trivedi";
STRINGS

cat <<PKGINFO >> Hello.app/Contents/PkgInfo
APPL????
PKGINFO
