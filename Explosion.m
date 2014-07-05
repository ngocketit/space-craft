//
//  Explosion.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "Explosion.h"
#import "cocos2d.h"
#import "CCAnimation.h"

@implementation Explosion {
    CCSpriteBatchNode *spriteBatch;
    NSMutableArray *explosionFrames;
}

- (id)init {
    if (self = [super init]) {

        spriteBatch = [CCSpriteBatchNode batchNodeWithFile:@"explosion.png"];
        [self addChild:spriteBatch];
        
        explosionFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 9; i++) {
            [explosionFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"ex_%i.png", i]]];
        }
    }
    
    return self;
}

- (void)explode:(CGPoint)position {
    self.isFree = NO;
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:explosionFrames delay:0.1f];
    CCActionAnimate *action = [CCActionAnimate actionWithAnimation:animation];
    
    self.sprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ex_1.png"]];
    self.position = position;
    
    // CCSpriteBatchNode only accepst CCSprite as its child
    [spriteBatch addChild:self.sprite];
    
    CCActionCallBlock *explosionDone = [[CCActionCallBlock alloc] initWithBlock:^(void) {
        [self reset];
        NSLog(@"Explosion is recycled");
   }];
    
    CCActionSequence *explosionAction = [CCActionSequence actions:action, explosionDone, nil];
    
    // Action can only be run on CCSprite
    [self.sprite runAction:explosionAction];
}

@end
