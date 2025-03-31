#import <Cocoa/Cocoa.h>

#pragma mark - Interfaces
@interface HelloView : NSView
@end

@interface HelloDelegate : NSObject
{
    NSString *m_applicationName;
}

- (NSString *)applicationName;
@end

@interface HelloMenu : NSObject
+ (void)populateMainMenu;
+ (void)populateApplicationMenu:(NSMenu *)menu;
+ (void)populateWindowMenu:(NSMenu *)menu;
@end

@interface HelloBundle : NSBundle
@end

@interface Hello : NSApplication
@end

#pragma mark - Implementations
@implementation HelloView
- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        NSButton *clickMe = [[NSButton alloc] initWithFrame:NSMakeRect(50, 25, 100, 30)];
        [clickMe setTitle:@"Click Me"];
        [clickMe setTarget:self];
        [clickMe setAction:@selector(showSheet:)];
        [clickMe setKeyEquivalent:@"\r"];
        [clickMe setBezelStyle:NSRoundedBezelStyle];

        [self addSubview:clickMe];
    }
    return self;
}

- (IBAction)showSheet:(id)sender
{
    NSBeginAlertSheet(@"Hello", @"Yeah", nil, nil, [NSApp keyWindow], self, nil, nil, nil, @"You clicked the button!");
}
@end

@implementation HelloDelegate
- (id)init
{
    if ((self = [super init])) {
        m_applicationName = [@"Hello" retain];
    }
    return self;
}

- (void)dealloc
{
    [m_applicationName release];
    m_applicationName = nil;
    [super dealloc];
}

- (void)setupWindow
{
    NSWindow *myWindow;
    NSView *myView;
    NSRect myRect = NSMakeRect(100, 350, 200, 80);

    myWindow = [[NSWindow alloc] initWithContentRect:myRect styleMask:(NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask) backing:NSBackingStoreBuffered defer:NO];
    [myWindow setTitle:@"Hello"];

    myView = [[HelloView alloc] initWithFrame:myRect];
    [myWindow setContentView:myView];

    [myWindow setDelegate:self];
    [myWindow makeKeyAndOrderFront:nil];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [NSApp terminate:self];
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [HelloMenu populateMainMenu];
    [self setupWindow];
    [pool release];
}

- (NSString *)applicationName
{
    return [[m_applicationName retain] autorelease];
}
@end

@implementation HelloMenu
+ (void)populateMainMenu
{
    NSMenu *mainMenu = [[[NSMenu alloc] initWithTitle:@"MainMenu"] autorelease];

    NSMenuItem *item;
    NSMenu *submenu;

    item = [mainMenu addItemWithTitle:@"Apple" action:NULL keyEquivalent:@""];
    submenu = [[[NSMenu alloc] initWithTitle:@"Apple"] autorelease];
    [NSApp performSelector:@selector(setAppleMenu:) withObject:submenu];
    [self populateApplicationMenu:submenu];
    [mainMenu setSubmenu:submenu forItem:item];

    item = [mainMenu addItemWithTitle:@"Window" action:NULL keyEquivalent:@""];
    submenu = [[[NSMenu alloc] initWithTitle:@"Window"] autorelease];
    [self populateWindowMenu:submenu];
    [mainMenu setSubmenu:submenu forItem:item];
    [NSApp setWindowsMenu:submenu];

    [NSApp setMainMenu:mainMenu];
}

+ (void)populateApplicationMenu:(NSMenu *)menu
{
    NSString *applicationName = [[NSApp delegate] applicationName];
    NSMenuItem *item;

    item = [menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"About", applicationName] action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@""];
    [item setTarget:NSApp];

    [menu addItem:[NSMenuItem separatorItem]];

    item = [menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"Hide", applicationName] action:@selector(hide:) keyEquivalent:@"h"];
    [item setTarget:NSApp];

    item = [menu addItemWithTitle:@"Hide Others" action:@selector(hideOtherApplications:) keyEquivalent:@"h"];
    [item setKeyEquivalentModifierMask:(NSCommandKeyMask | NSAlternateKeyMask)];
    [item setTarget:NSApp];

    item = [menu addItemWithTitle:@"Show All" action:@selector(unhideAllApplications:) keyEquivalent:@""];
    [item setTarget:NSApp];

    [menu addItem:[NSMenuItem separatorItem]];

    item = [menu addItemWithTitle:[NSString stringWithFormat:@"%@ %@", @"Quit", applicationName] action:@selector(terminate:) keyEquivalent:@"q"];
    [item setTarget:NSApp];
}

+ (void)populateWindowMenu:(NSMenu *)menu
{
    NSMenuItem *item;

    item = [menu addItemWithTitle:@"Minimize" action:@selector(miniaturize:) keyEquivalent:@"m"];
}
@end

@implementation HelloBundle
+ (BOOL)loadNibNamed:(NSString *)aNibNamed owner:(id)owner
{
    if (!aNibNamed && owner == NSApp) {
        return YES;
    } else {
        return [super loadNibNamed:aNibNamed owner:owner];
    }
}
@end

@implementation Hello
- (id)init
{
    if ((self = [super init])) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        [self setDelegate:[[HelloDelegate alloc] init]];
        [pool release];
    }
    return self;
}

- (void)dealloc
{
    id delegate = [self delegate];
    if (delegate) {
        [self setDelegate:nil];
        [delegate release];
    }
    [super dealloc];
}
@end

#pragma mark - Entry Point
int main(int argc, char *argv[])
{
    [[HelloBundle class] poseAsClass:[NSBundle class]];
    return NSApplicationMain(argc, (const char **)argv);
}
