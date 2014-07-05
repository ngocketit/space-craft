//
//  UFOSpawner.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "UFOSpawner.h"
#import "UFO.h"
#import "UFOPool.h"


@implementation UFOSpawner

- (id)initWithUFOPool:(UFOPool *)pool {
    if (self = [super init]) {
        self.ufoPool = pool;
    }
    
    return self;
}

- (UFO *)spawnUFO {
    UFO *ufo = (UFO*) [self.ufoPool requestSingleObject:YES];
    
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    // Set up the trajectory for the ufo
    CGPoint position = ccp(CCRANDOM_0_1() * (viewSize.width - ufo.contentSize.width/2), viewSize.height - ufo.contentSize.height);
    
    ufo.position = position;
    [ufo stopAllActions];
    
    return ufo;
}

@end
