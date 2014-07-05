//
//  SprayBulletLauncher.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/11/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "SprayBulletLauncher.h"
#import "Bullet.h"

@implementation SprayBulletLauncher

- (id) init {
    if (self = [super init]) {
        self.bulletAngle = 15.0;
    }
    
    return self;
}

-(void)fire {
    NSArray *bullets = [self.bulletPool requestMultipleObjects:3 createNewBulletsIfNeeded:YES];
    
    if (bullets == nil || [bullets count] < 3) {
        NSLog(@"Out of bullets");
        return;
    }
    
    CGSize viewportSize = [[CCDirector sharedDirector] viewSize];
    CGSize bulletSize = [bullets[0] contentSize];
    
    CGSize craftSize = self.spaceCraft.contentSize;
    CGPoint craftPosition = self.spaceCraft.position;
    
    Bullet *middleBullet = bullets[0], *leftBullet = bullets[1], *rightBullet = bullets[2];
    
    CGPoint bulletPosition = CGPointMake(craftPosition.x, craftPosition.y + bulletSize.height/2 + craftSize.height/2);
    
    CGPoint middleBulletTarget = CGPointMake(craftPosition.x, viewportSize.height + bulletSize.height/2);
    
    double sideBulletY = bulletPosition.y + (viewportSize.width - bulletPosition.x)/tan(M_PI * self.bulletAngle/180);
    CGPoint leftBulletTarget = CGPointMake(0, sideBulletY);
    CGPoint rightBulletTarget = CGPointMake(viewportSize.width, sideBulletY);
    
    // Middle bullet
    middleBullet.position = bulletPosition;
    [self fireABullet:middleBullet targetPosition:middleBulletTarget];
    
    // Left bullet
    leftBullet.position = bulletPosition;
    leftBullet.rotation = - self.bulletAngle;
    [self fireABullet:leftBullet targetPosition:leftBulletTarget];
    
    // Right bullet
    rightBullet.position = bulletPosition;
    rightBullet.rotation = self.bulletAngle;
    [self fireABullet:rightBullet targetPosition:rightBulletTarget];
}

@end
