//
//  BulletLauncher.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/11/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "BulletLauncher.h"

static BulletLauncher *launcher;

@implementation BulletLauncher

+ (id)bulletLauncherWithBulletPool:(BulletPool *)pool spaceCraft:(Spacecraft *)craft {
    if (launcher == nil) {
        launcher = [[self alloc] initWithBulletPool:pool spaceCraft:craft];
    }
    
    return launcher;
}

- (id) init {
    if (self = [super init]) {
        CGSize viewportSize = [[CCDirector sharedDirector] viewSize];
        
        // Number of pixels per second
        self.bulletSpeed = viewportSize.height;
    }
    
    return self;
}

- (id)initWithBulletPool:(BulletPool *)pool spaceCraft:(Spacecraft *)craft {
    if (self = [self init]) {
        self.bulletPool = pool;
        self.spaceCraft = craft;
    }
    
    return self;
}

- (double)calculateBulletFlyingTime:(CGPoint)bulletPosition targetPosition:(CGPoint)targetPosition {
    float distance = ccpDistance(targetPosition, bulletPosition);
    return distance/self.bulletSpeed;
}

- (void)fireABullet:(Bullet *)bullet targetPosition:(CGPoint)target {
    bullet.isFree = NO;
    double flyingTime = [self calculateBulletFlyingTime:bullet.position targetPosition:target];
    
    [bullet stopAllActions];
    
    // Add bullet to the scene
    if (bullet.parent == nil) {
        [self.spaceCraft.parent addChild:bullet];
    }
    
    CCActionMoveTo *moveToTop = [[CCActionMoveTo alloc] initWithDuration:flyingTime position:target];
    
    CCActionCallBlock *moveDone = [[CCActionCallBlock alloc] initWithBlock:^(void) {
        [bullet reset];
        NSLog(@"Bullet is free");
    }];
    
    CCActionSequence *action = [CCActionSequence actions:moveToTop, moveDone, nil];
    [bullet runAction:action];
}

- (void)fire {
    // Overridden by sub-class
    return;
}

@end
