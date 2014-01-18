//
//  NZAppDelegate.m
//  NZPlayer
//
//  Created by oxnz on 14-1-14.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import "NZAppDelegate.h"
#import "NZMusicLibrary.h"

@implementation NZAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    userDefaults = [NSUserDefaults standardUserDefaults];
    // Insert code here to initialize your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return NO;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    if (![musicLibrary sync]) {
        return NSTerminateLater;
    } else
        return NSTerminateNow;
    //NSLog(@"should terminate");
    if (![musicLibrary sync]) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Music Library Sync Failed"
                                         defaultButton:@"OK"
                                       alternateButton:@"Retry"
                                           otherButton:nil
                             informativeTextWithFormat:@"There was an error occured while sync the music library file"];
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert beginSheetModalForWindow:_window completionHandler:^(NSModalResponse returnCode) {
            if (NSAlertDefaultReturn == returnCode) {
                [NSApp replyToApplicationShouldTerminate:YES];
            } else if (NSAlertAlternateReturn == returnCode) {
                [NSApp replyToApplicationShouldTerminate:[musicLibrary sync]];
            } else {
                NSLog(@"Error in %s", __FUNCTION__);
                [NSApp replyToApplicationShouldTerminate:YES];
            }
        }];
        return NSTerminateLater;
    } else
        return NSTerminateNow;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    //NSLog(@"will terminate");
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender
{
    //NSLog(@"ask for dock menu");
    return dockMenu;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    if (flag) {
        return NO;
    } else {
        [_window makeKeyAndOrderFront:self];
        return YES;
    }
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    NSLog(@"active");
    [musicLibrary loadLibrary];
}

- (void)awakeFromNib
{
    //NSLog(@"awake from nib");
}

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
    NSLog(@"opening: %@", filename);
    return YES;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames
{
    NSLog(@"opening files: %@", filenames);
}

@end
