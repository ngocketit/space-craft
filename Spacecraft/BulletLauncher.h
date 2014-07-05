//
//  BulletLauncher.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/11/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BulletPool.h"
#import "Spacecraft.h"
#import "Bullet.h"

@interface BulletLauncher : NSObject

@property (nonatomic, weak) Spacecraft *spaceCraft;
@property (nonatomic, weak) BulletPool *bulletPool;
@property (nonatomic, assign) double bulletSpeed;

+ (id) bulletLauncherWithBulletPool:(BulletPool*)pool spaceCraft:(Spacecraft*)craft;

- (id) initWithBulletPool:(BulletPool*)pool spaceCraft:(Spacecraft*)craft;
- (void) fire;
- (double) calculateBulletFlyingTime:(CGPoint)bulletPosition targetPosition:(CGPoint)targetPosition;
- (void) fireABullet:(Bullet*)bullet targetPosition:(CGPoint)target;

@end
