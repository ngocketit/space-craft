//
//  BombDropper.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BombPool;
@class UFO;
@class Bomb;

@interface BombDropper : NSObject

@property (nonatomic, weak) BombPool *bombPool;
@property (nonatomic, assign) double bombSpeed;

- (id) initWithBombPool:(BombPool*) pool;
- (void) drop:(UFO*) ufo;
- (void) dropABomb:(Bomb*) bomb fromUFO:(UFO*) ufo;

@end
