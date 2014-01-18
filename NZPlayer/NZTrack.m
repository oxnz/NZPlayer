//
//  NZTrack.m
//  NZPlayer
//
//  Created by oxnz on 14-1-15.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import "NZTrack.h"

@implementation NZTrack
@synthesize ID;
@synthesize name;
@synthesize artist;
@synthesize album;
@synthesize albumArtist;
@synthesize genre;
@synthesize kind;
@synthesize size;
@synthesize time;
@synthesize number;
@synthesize year;
@synthesize dateAdded;
@synthesize dateModified;
@synthesize bitRate;
@synthesize sampleRate;
@synthesize playCount;
@synthesize comments;
@synthesize type;
@synthesize location;
@synthesize rank;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if ([super init]) {
        ID = dictionary[@"Track ID"];
        name = dictionary[@"Name"];
        if (!name)
            name = @"Untitled";
        time = dictionary[@"Total Time"];
        if (!time)
            time = [NSNumber numberWithInt:-1];
        artist = dictionary[@"Artist"];
        albumArtist = dictionary[@"Album Artist"];
        if (!albumArtist && artist)
            albumArtist = [NSString stringWithString:artist];
        kind = dictionary[@"Kind"];
        number = dictionary[@"Track Number"];
        year = dictionary[@"Year"];
        dateAdded = dictionary[@"Date Added"];
        if (!dateAdded)
            dateAdded = [NSDate date];
        dateModified = dictionary[@"Date Modified"];
        if (!dateModified)
            dateModified = dateAdded;
        bitRate = dictionary[@"Bit Rate"];
        sampleRate = dictionary[@"Sample Rate"];
        type = dictionary[@"Track Type"];
        album = dictionary[@"Album"];
        genre = dictionary[@"Genre"];
        size = dictionary[@"Size"];
        if (!size)
            size = [NSNumber numberWithInt:-1];
        playCount = dictionary[@"Play Count"];
        if (!playCount)
            playCount = [NSNumber numberWithInt:0];
        location = dictionary[@"Location"];
        rank = [NSNumber numberWithInt:0];
    }
    return self;
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    
}
- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    return dict;
}

@end
