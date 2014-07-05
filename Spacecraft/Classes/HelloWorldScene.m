//
//  HelloWorldScene.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/9/14.
//  Copyright Phi Van Ngoc 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import "Spacecraft.h"
#import "Bullet.h"
#import "Bomb.h"
#import "UFO.h"
#import "BombPool.h"
#import "BombDropper.h"
#import "Explosion.h"
#import "ExplosionPool.h"
#import "BulletPool.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    CCSprite *_sprite;
    Spacecraft *craft;
    BombDropper *bombDropper;
    UFO *ufo;
    ExplosionPool *explosionPool;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    craft = [Spacecraft spacecraftWithParent:self];
    craft.position  = ccp(self.contentSize.width/2, craft.contentSize.height/2);
    
    BombPool *bombPool = [BombPool sharedPool];
    bombDropper = [[BombDropper alloc] initWithBombPool:bombPool];
    
    ufo = [[UFO alloc] initWithBombDropper:bombDropper];
    ufo.position = ccp(self.contentSize.width/2, self.contentSize.height - 40);
    [self addChild:ufo];
    
    // done
	return self;
}


- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    CCLOG(@"Touch location: @ %@",NSStringFromCGPoint(touchLoc));
    
    [ufo dropBomb];
    
    [craft fire];
    
    
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
