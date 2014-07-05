//
//  Spacecraft.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/9/14.
//  Copyright 2014 Phi Van Ngoc. All rights reserved.
//

#import "Spacecraft.h"
#import "BulletPool.h"
#import "Bullet.h"
#import "SingleBulletLauncher.h"
#import "SprayBulletLauncher.h"
#import "ExplosionPool.h"
#import "Explosion.h"

@implementation Spacecraft

- (id) init {
    if (self = [super init]) {
        self.numberOfBulletsFired = 0;
        
        sprite = [CCSprite spriteWithImageNamed:@"spacecraft.png"];
        [self addChild:sprite];
        
        // NOTE: This is needed in order to support touch per node
        self.contentSize = sprite.contentSize;
        
        self.bulletLauncher = [SprayBulletLauncher bulletLauncherWithBulletPool:[BulletPool sharedPool] spaceCraft:self];
    }
    
    return self;
}

- (Spacecraft *)initWithParentNode:(CCNode *)parent {
    self = [self init];
    [parent addChild:self];
    
    return self;
}

+ (Spacecraft *)spacecraftWithParent:(CCNode *)parent {
    return [[self alloc] initWithParentNode:parent];
}

- (void)fire {
    self.numberOfBulletsFired++;
    [self.bulletLauncher fire];
}

- (void)destroy {
    Explosion *explosion = (Explosion*)[[ExplosionPool sharedPool] requestSingleObject:YES];
    
    if (explosion.parent == nil) {
        [self.parent addChild:explosion];
    }
    
    [explosion explode:self.position];
    self.visible = NO;
}

@end
