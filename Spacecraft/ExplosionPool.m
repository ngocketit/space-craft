//
//  ExplosionPool.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "ExplosionPool.h"
#import "Explosion.h"

@implementation ExplosionPool

- (id)init {
    self.maxCapacity = 5;
    
    if (self = [super init]) {
        // Cache sprite frames, don't need to do this with individual explosion
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"explosion.plist"];
    }
    
    return self;
}

- (ReusableObject *)spawnObject {
    return [[Explosion alloc] init];
}

@end
