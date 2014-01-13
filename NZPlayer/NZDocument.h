//
//  NZDocument.h
//  player-Z
//
//  Created by oxnz on 14-1-13.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>

@interface NZDocument : NSPersistentDocument
{
    IBOutlet NSTableView *tableView;
    NSDictionary *iTunesLibrary;
    NSDictionary *tracks;
    NSArray *tracksKeys;
    IBOutlet NSToolbar *toolbar;
    AVAudioPlayer *avplayer;
    IBOutlet NSButton *playButton;
    IBOutlet NSSlider *volumeSlider;
}

- (IBAction)play:(id)sender;
- (IBAction)setVolume:(id)sender;

@end
