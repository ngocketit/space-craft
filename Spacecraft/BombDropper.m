//
//  BombDropper.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "BombDropper.h"
#import "cocos2d.h"

#include "Bomb.h"
#include "UFO.h"
#include "BombPool.h"

@implementation BombDropper

-(id)init {
    if (self = [super init]) {
        CGSize viewportSize = [[CCDirector sharedDirector] viewSize];
        
        // Number of pixels per second
        self.bombSpeed = viewportSize.height/2;
    }
    
    return self;
}

-(id)initWithBombPool:(BombPool *)pool {
    if (self = [self init]) {
        self.bombPool = pool;
    }
    
    return self;
}

- (void)dropABomb:(Bomb *)bomb fromUFO:(UFO *)ufo {
    // Target position of always bottom of screen
    CGPoint targetPosition = ccp(bomb.position.x, -bomb.contentSize.height/2);
    
    bomb.isFree = NO;
    double flyingTime = ccpDistance(targetPosition, bomb.position)/self.bombSpeed;
    
    [bomb stopAllActions];
    
    // Add bomb to the scene, check to make sure we don't do this twice
    if (bomb.parent == nil) {
        [ufo.parent addChild:bomb];
    }
    
    CCActionMoveTo *moveToTop = [[CCActionMoveTo alloc] initWithDuration:flyingTime position:targetPosition];
    
    CCActionCallBlock *moveDone = [[CCActionCallBlock alloc] initWithBlock:^(void) {
        [bomb reset];
    }];
    
    CCActionSequence *action = [CCActionSequence actions:moveToTop, moveDone, nil];
    [bomb runAction:action];
}

- (void)drop:(UFO *)ufo {
    NSAssert(self.bombPool != nil, @"Bombpool cant be nil");
    
    Bomb *bomb = (Bomb*) [self.bombPool requestSingleObject:YES];
    
    // Set up initial position of the bomb
    bomb.position = ccp(ufo.position.x, ufo.position.y - ufo.contentSize.height/2 - bomb.contentSize.height/2);
    
    [self dropABomb:bomb fromUFO:ufo];
}

@end
