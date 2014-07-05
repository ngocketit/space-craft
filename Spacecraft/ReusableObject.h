//
//  ReusableObject.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ReusableObject : CCNode

@property (nonatomic) CCSprite *sprite;
@property (nonatomic, assign) BOOL isFree;

- (id) initWithSpriteNamed:(NSString*) spriteName;
- (void) reset;



@end
