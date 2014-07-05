//
//  SingleBulletLauncher.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/11/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "SingleBulletLauncher.h"
#import "Bullet.h"

@implementation SingleBulletLauncher

- (void) fire {
    Bullet *bullet = (Bullet*)[self.bulletPool requestSingleObject:YES];
    
    if (bullet == nil) {
        NSLog(@"No bullet is available");
        return;
    }
    
    CGSize viewportSize = [[CCDirector sharedDirector] viewSize];
    CGSize bulletSize = [bullet contentSize];
    CGSize craftSize = self.spaceCraft.contentSize;
    
    CGPoint craftPosition = self.spaceCraft.position;
    CGPoint bulletTarget = CGPointMake(craftPosition.x, viewportSize.height + bulletSize.height/2);
    
    bullet.position = CGPointMake(craftPosition.x, craftPosition.y + bulletSize.height/2 + craftSize.height/2);
    
    [self fireABullet:bullet targetPosition:bulletTarget];
 }

@end
