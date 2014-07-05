//
//  BombPool.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "BombPool.h"
#import "Bomb.h"

@implementation BombPool

-(id)init {
    self.maxCapacity = 50;
    
    if (self = [super init]) {
        // What else?
    }
    
    return self;
}

-(ReusableObject *)spawnObject {
    return [[Bomb alloc] init];
}

@end
