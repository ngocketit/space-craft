//
//  BulletPool.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/10/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "BulletPool.h"
#import "Bullet.h"

@implementation BulletPool

-(id)init {
    self.maxCapacity = 50;
    
    if (self = [super init]) {
        
    }
    
    return self;
}

- (ReusableObject *)spawnObject {
    return [[Bullet alloc] init];
}

@end
