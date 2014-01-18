//
//  NZAppDelegate.h
//  NZPlayer
//
//  Created by oxnz on 14-1-14.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class NZMusicLibrary;


@interface NZAppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSMenu *dockMenu;
    NSUserDefaults *userDefaults;
    
    IBOutlet NZMusicLibrary *musicLibrary;
    IBOutlet NSTableView *tableView;
}

@property (assign) IBOutlet NSWindow *window;

@end
