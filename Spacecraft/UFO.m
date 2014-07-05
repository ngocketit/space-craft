//
//  UFO.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright 2014 Phi Van Ngoc. All rights reserved.
//

#import "UFO.h"
#import "BombDropper.h"
#import "ExplosionPool.h"
#import "Explosion.h"

@implementation UFO

- (id) init {
    if (self = [super initWithSpriteNamed:@"ufo.png"]) {
        [self schedule:@selector(dropBomb) interval:2];
    }
    
    return self;
}

- (id)initWithBombDropper:(BombDropper *)dropper {
    if (self = [self init]) {
        self.bombDropper = dropper;
        
    }
    
    return self;
}

- (void)dropBomb {
    [self.bombDropper drop:self];
}

- (void)destroy {
    Explosion *explosion = (Explosion*)[[ExplosionPool sharedPool] requestSingleObject:YES];
    
    if (explosion.parent == nil) {
        [self.parent addChild:explosion];
    }
    [explosion explode:self.position];
    
    [self reset];
}

@end
