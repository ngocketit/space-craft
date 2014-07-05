//
//  ReusableObject.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "ReusableObject.h"

@implementation ReusableObject

- (id)init {
    if (self = [super init]) {
        self.isFree = YES;
        self.visible = YES;
    }
    
    return self;
}

- (id)initWithSpriteNamed:(NSString *)spriteName {
    if (self = [super init]) {
        self.sprite = [[CCSprite alloc] initWithImageNamed:spriteName];
        [self addChild:self.sprite];
        
        self.isFree = YES;
        self.contentSize = self.sprite.contentSize;
    }
    
    return self;
}

- (void)reset {
    self.isFree = YES;
    self.visible = NO;
    [self stopAllActions];
}

@end
