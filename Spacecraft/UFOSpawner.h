//
//  UFOSpawner.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UFOPool;
@class UFO;

@interface UFOSpawner : NSObject

@property (nonatomic, weak) UFOPool *ufoPool;

- (id) initWithUFOPool:(UFOPool*) pool;
- (UFO*) spawnUFO;

@end
