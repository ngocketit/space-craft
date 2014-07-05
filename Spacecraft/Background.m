//
//  Background.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright 2014 Phi Van Ngoc. All rights reserved.
//

#import "Background.h"


@implementation Background

- (id) init {
    if (self = [super init]) {

        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f]];
        [self addChild:background];
    }
    
    return self;
}

@end
