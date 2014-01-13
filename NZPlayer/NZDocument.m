//
//  NZDocument.m
//  player-Z
//
//  Created by oxnz on 14-1-13.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import "NZDocument.h"

@implementation NZDocument

- (id)init
{
    self = [super init];
    if (self) {
        //toolbarDelegate = [[NZToolbarDelegate alloc] init];
        //[toolbar setDelegate:toolbarDelegate];
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"NZDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    [volumeSlider setMinValue:0.0];
    [volumeSlider setMaxValue:100.0];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (BOOL)readFromURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError *__autoreleasing *)error
{
    NSString *filename = [absoluteURL path];
    iTunesLibrary = [NSDictionary dictionaryWithContentsOfFile:filename];
    tracks = [iTunesLibrary objectForKey:@"Tracks"];
    tracksKeys = [tracks allKeys];
    return YES;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView*) tableView
{
    return [tracks count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //NSLog(@"%@", [tableColumn identifier]);
    NSDictionary *track = [tracks objectForKey:tracksKeys[row]];
    NSString *identifer = [tableColumn identifier];
    if ([identifer  isEqual: @"Total Time"]) {
        NSInteger t = [[track objectForKey:@"Total Time"] intValue] /1000;
        if (t < 60*60)
            return [NSString stringWithFormat:@"%02lu:%02lu", t/60, t%60];
        else
            return [NSString stringWithFormat:@"%02lu:%02lu:%02lu", t/60/60, t/60%60, t%60];
    } else if ([identifer isEqual: @"Rank"]) {
        return @"*****";
    }
    return [track objectForKey:[tableColumn identifier]];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSLog(@"wanna to set object: %@ for identifer: %@", object, [tableColumn identifier]);
}

- (IBAction)play:(id)sender
{
    long row = [tableView selectedRow];
    if (row < 0 || row > [tracks count])
        return;
    NSDictionary *track = [tracks objectForKey:tracksKeys[row]];
    NSURL *url = [NSURL URLWithString:[track objectForKey:@"Location"]];
    avplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:Nil];
    if ([avplayer isPlaying]) {
        [avplayer pause];
    } else {
        [avplayer play];
    }
}

- (IBAction)setVolume:(id)sender
{
    double val = [volumeSlider doubleValue];
    [avplayer setVolume:val];
}

@end
