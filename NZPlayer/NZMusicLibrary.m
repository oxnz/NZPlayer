//
//  NZMusicLibrary.m
//  NZPlayer
//
//  Created by oxnz on 14-1-14.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import "NZMusicLibrary.h"
#import "NZTrack.h"
#import "NZPlaylist.h"

@implementation NZMusicLibrary

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        libraryName = @"NZPlayer Music Library.xml"; // FIXME: xml -> nml
        libraryPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Music"];
        libraryDict = [[NSMutableDictionary alloc] init];
        tracksDict = [[NSMutableDictionary alloc] init];
        playlistArray = [[NSMutableArray alloc] init];
        needSync = NO;
        return self;
    } else
        return nil;
}

- (NSString *)libraryFilePath
{
    return [libraryPath stringByAppendingPathComponent:libraryName];
}

- (BOOL)createLibrary
{
    NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    NSLog(@"create library: %@, version = %@", [self libraryFilePath], version);
    [libraryDict setValue:version forKey:@"Application Version"];
    [libraryDict setValue:[NSDate date] forKey:@"Date"];
    [libraryDict setObject:tracksDict forKey:@"Tracks"];
    [libraryDict setObject:playlistArray forKey:@"Playlists"];
    [self setContent:libraryDict];
    return YES;
}

- (BOOL)loadLibrary
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"Music Library"
                                     defaultButton:@"Create"
                                   alternateButton:@"Quit"
                                       otherButton:@"Import"
                         informativeTextWithFormat:@"NZPlayer did not find a music library, do you want to create one or import from the iTunes or existed library instead ?"];
    [alert setAlertStyle:NSWarningAlertStyle];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self libraryFilePath] isDirectory:NO]) {
        [alert beginSheetModalForWindow:[NSApp mainWindow]
                      completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertDefaultReturn) {
                NSLog(@"Create");
                [self createLibrary];
            } else if (returnCode == NSAlertAlternateReturn) {
                NSLog(@"you choose to Quit");
                [NSApp terminate:nil];
            } else {
                NSLog(@"import");
                [self importLibrary];
            }
        }];
    } else {
        NSLog(@"initing with file: %@", [self libraryFilePath]);
    }

    return YES;
}

- (BOOL)importLibrary
{
    NSAlert *alert;
    NSString *prompt = @"Import From iTunes Library";
    NSString *defaultiTunesLibraryFile =
        [libraryPath stringByAppendingPathComponent:@"iTunes/iTunes Music Library.xml"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:defaultiTunesLibraryFile isDirectory:NO]) {
        alert = [NSAlert alertWithMessageText:@"Import From iTunes Music Library"
                                defaultButton:@"Import"
                              alternateButton:@"Cancel"
                                  otherButton:@"Other"
                    informativeTextWithFormat:@"import from: %@", defaultiTunesLibraryFile];
        [alert beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertDefaultReturn) {
                [self createLibrary];
                NSLog(@"import from: %@", defaultiTunesLibraryFile);
                NSDictionary *iTunesLibraryDict = [NSDictionary dictionaryWithContentsOfFile:defaultiTunesLibraryFile];
                NSDictionary *iTunesTracksDict = iTunesLibraryDict[@"Tracks"];
                NSArray *iTunesTracksArray = [iTunesTracksDict allValues];
                for (NSDictionary *iTunesTrack in iTunesTracksArray) {
                    NZTrack *track = [[NZTrack alloc] initWithDictionary:iTunesTrack];
                    [tracksDict setObject:track forKey:[[track ID] stringValue]];
                }
                needSync = YES;
                
                [playlistArray addObject:[[NZPlaylist alloc] init]];
                [playlistArray addObject:[[NZPlaylist alloc] init]];
                [playlistArray addObject:[[NZPlaylist alloc] init]];
                [tableView reloadData];
            } else if (returnCode == NSAlertAlternateReturn) {
                NSLog(@"Cancel");
                [self loadLibrary];
            } else {
                NSLog(@"import from other");
                NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
                [openPanel setCanChooseDirectories:NO];
                [openPanel setCanChooseFiles:YES];
                [openPanel setAllowsMultipleSelection:NO];
                [openPanel setAllowedFileTypes:[NSArray arrayWithObjects:@"xml", @"nml", nil]];
                [openPanel beginWithCompletionHandler:^(NSInteger result) {
                    if (result == NSFileHandlingPanelOKButton) {
                        NSLog(@"you selected: %@", [[openPanel URL] absoluteString]);
                    } else {
                        NSLog(@"you canceled");
                        [self loadLibrary];
                    }
                }];

            }
        }];
    } else {
        alert = [NSAlert alertWithMessageText:prompt
                                defaultButton:@"Select"
                              alternateButton:@"Cancel"
                                  otherButton:@"Create"
                    informativeTextWithFormat:@"iTunes Music Library File: %@ not exist, please click select to choose", defaultiTunesLibraryFile];
    }
    [alert setAlertStyle:NSWarningAlertStyle];
    

    return YES;
}

- (BOOL)dumpLibrary
{
    NSLog(@"write to %@", [self libraryFilePath]);
    static int i = 0;
    [libraryDict writeToFile:[self libraryFilePath] atomically:YES];
    if (i++ > 3)
        return YES;
    else
        return NO;
}

- (BOOL)sync
{
    NSLog(@"syncing ...");
    if (needSync && ![self dumpLibrary]) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Music Library Sync Failed"
                                         defaultButton:@"OK"
                                       alternateButton:@"Retry"
                                           otherButton:@"Cancel"
                             informativeTextWithFormat:@"There was an error occured while sync the music library"];
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse returnCode) {
            if (NSAlertDefaultReturn == returnCode) { // ok
                [NSApp replyToApplicationShouldTerminate:YES];
            } else if (NSAlertAlternateReturn == returnCode) { // retry
                NSLog(@"retry sync");
                [NSApp replyToApplicationShouldTerminate:NO];
                [self sync];
            } else { // cancel
                [NSApp replyToApplicationShouldTerminate:NO];
            }
        }];
        return NO;
    } else {
        needSync = NO;
        return YES;
    }
}

#pragma mark dataSource
/*
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSLog(@"ask for row count");
    return [tracksDict count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSDictionary *track = [tracksDict objectForKey:[tracksDict allKeys][row]];
    return [track objectForKey:[tableColumn identifier]];
}
*/
@end
