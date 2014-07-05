//
//  Spacecraft.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/9/14.
//  Copyright 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Bullet;
@class BulletLauncher;

@interface Spacecraft : CCNode {
    CCSprite *sprite;
}

@property (nonatomic, assign) unsigned int numberOfBulletsFired;
@property (nonatomic) BulletLauncher *bulletLauncher;

+ (Spacecraft*) spacecraftWithParent:(CCNode*) parent;
- (Spacecraft*) initWithParentNode:(CCNode*) parent;

- (void) fire;
- (void) destroy;


@end
