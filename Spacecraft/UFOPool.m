//
//  UFOPool.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "UFOPool.h"
#import "UFO.h"

@implementation UFOPool

- (id)init {
    self.maxCapacity = 10;
    
    return [super init];
}

- (ReusableObject *)spawnObject {
    return [[UFO alloc] init];
}

@end
