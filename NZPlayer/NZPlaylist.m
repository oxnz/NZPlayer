//
//  NZPlaylist.m
//  NZPlayer
//
//  Created by oxnz on 14-1-15.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import "NZPlaylist.h"

@implementation NZPlaylist
@synthesize name;
@synthesize count;
@synthesize time;

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        NSLog(@"init playlist");
        name = @"X";
        count = [NSNumber numberWithInt:10];
        return self;
    } else
        return nil;
}

@end
