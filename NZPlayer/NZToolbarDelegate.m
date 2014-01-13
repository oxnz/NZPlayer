//
//  NZToolbarDelegate.m
//  player-Z
//
//  Created by oxnz on 14-1-13.
//  Copyright (c) 2014年 oxnz. All rights reserved.
//

#import "NZToolbarDelegate.h"

@implementation NZToolbarDelegate

- (void)awakeFromNib
{
    NSLog(@"awakefromnib in %s", __FUNCTION__);
}

- (NSArray *) toolbarAllowedItemIdentifiers: (NSToolbar *) toolbar {
    NSLog(@"allow");
    return [NSArray arrayWithObjects:
            NSToolbarFlexibleSpaceItemIdentifier,
            NSToolbarSpaceItemIdentifier,
            NSToolbarSeparatorItemIdentifier, nil];
}

- (NSArray *) toolbarDefaultItemIdentifiers: (NSToolbar *)toolbar
{
    NSLog(@"HER");
    return [NSArray arrayWithObjects:
            NSToolbarFlexibleSpaceItemIdentifier,
             nil];
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar
     itemForItemIdentifier:(NSString *)itemIdentifier
 willBeInsertedIntoToolbar:(BOOL)flag
{
    NSToolbarItem *toolbarItem = nil;
    NSLog(@"xx");
    
    return toolbarItem;
}

@end
