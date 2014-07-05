//
//  UFO.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ReusableObject.h"

@class BombDropper;

@interface UFO : ReusableObject

@property (nonatomic, weak) BombDropper* bombDropper;

- (id) initWithBombDropper:(BombDropper*) dropper;
- (void) dropBomb;
- (void) destroy;

@end
