//
//  NZMusicLibrary.h
//  NZPlayer
//
//  Created by oxnz on 14-1-14.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NZMusicLibrary : NSDictionaryController <NSTableViewDataSource>
{
    NSString *libraryPath;
    NSString *libraryName;
    NSMutableDictionary *libraryDict;
    NSMutableDictionary *tracksDict;
    NSMutableArray *playlistArray;
    BOOL needSync;
    IBOutlet NSTableView *tableView;
}


- (NSString *)libraryFilePath;
- (BOOL)createLibrary;
- (BOOL)importLibrary;
- (BOOL)loadLibrary;
- (BOOL)dumpLibrary;
- (BOOL)sync;

@end
