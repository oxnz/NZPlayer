//
//  NZTrack.h
//  NZPlayer
//
//  Created by oxnz on 14-1-15.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NZTrack : NSObject
{
    NSNumber *ID;
    NSString *name;
    NSString *artist;
    NSString *album;
    NSString *albumArtist;
    NSString *genre;
    NSString *kind;
    NSNumber *size;
    NSNumber *time;
    NSNumber *number; // track number
    NSNumber *year;
    NSDate *dateAdded;
    NSDate *dateModified;
    NSNumber *bitRate;
    NSNumber *sampleRate;
    NSNumber *playCount;
    NSString *comments;
    NSString *type; // track type
    NSString *location;
    NSNumber *rank;
}

@property (readonly) NSNumber *ID;
@property (readwrite,copy) NSString *name;
@property (readwrite,copy) NSString *artist;
@property (readwrite,copy) NSString *album;
@property (readwrite,copy) NSString *albumArtist;
@property (readwrite,copy) NSString *genre;
@property (readwrite,copy) NSString *kind;
@property (readonly) NSNumber *size;
@property (readwrite,copy) NSNumber *time;
@property (readwrite,copy) NSNumber *number;
@property (readwrite,copy) NSNumber *year;
@property (readwrite,copy) NSDate *dateAdded;
@property (readwrite,copy) NSDate *dateModified;
@property (readonly) NSNumber *bitRate;
@property (readonly) NSNumber *sampleRate;
@property (readwrite,copy) NSNumber *playCount;
@property (readwrite,copy) NSString *comments;
@property (readonly) NSString *type;
@property (readonly) NSString *location;
@property (readwrite,copy) NSNumber *rank;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end
