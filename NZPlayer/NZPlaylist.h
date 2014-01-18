//
//  NZPlaylist.h
//  NZPlayer
//
//  Created by oxnz on 14-1-15.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NZPlaylist : NSDictionaryController
{
    NSString *name;
    NSNumber *count;
    NSNumber *time;
}

@property (readwrite,copy) NSString *name;
@property (readwrite,copy) NSNumber *count;
@property (readwrite,copy) NSNumber *time;

@end
