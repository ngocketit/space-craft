//
//  GameLevel.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright 2014 Phi Van Ngoc. All rights reserved.
//

#import "GameLevel.h"
#import "IntroScene.h"
#import "Spacecraft.h"
#import "SingleBulletLauncher.h"
#import "BombDropper.h"
#import "BombPool.h"
#import "BulletPool.h"
#import "Background.h"
#import "Bomb.h"
#import "UFO.h"
#import "UFOPool.h"
#import "UFOSpawner.h"


@implementation GameLevel {
    unsigned int numberOfDestroyedUFOs;
    unsigned int numberOfSpawnedUFOs;
}

+ (GameLevel *)defaultLevel {
    GameLevel *level = [[self alloc] init];
    
    if (level) {
        // Init default values
        level.levelName = @"Level 1";
        
        level.isGameOver = NO;
        level.isCompleted = NO;
        
        level.numberOfUFOs = 10;
        level.numberOfBullets = 100;
        level.numberOfLives = 1;
        level.scores = 0;
        
        // Init game objects
        level.spaceCraft = [Spacecraft spacecraftWithParent:level];
        level.spaceCraft.position  = ccp(level.contentSize.width/2, level.spaceCraft.contentSize.height/2);
        
        level.bombDropper = [[BombDropper alloc] initWithBombPool:[BombPool sharedPool]];
        level.ufoSpawner = [[UFOSpawner alloc] initWithUFOPool:[UFOPool sharedPool]];
        
        level.background = [[Background alloc] init];
        [level addChild:level.background z:-1];
    }
    
    return level;
}

- (id)init {
    if (self = [super init]) {
        // Enable touch handling on scene node
        self.userInteractionEnabled = YES;
        
        numberOfDestroyedUFOs = 0;
        numberOfSpawnedUFOs = 0;
        
        // Create a back button
        CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
        backButton.positionType = CCPositionTypeNormalized;
        backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
        [backButton setTarget:self selector:@selector(backToIntroScene:)];
        [self addChild:backButton];
        
        // Schedule for UFO spawning
        [self schedule:@selector(spawnUFO) interval:1];
    }
    
    return self;
}

- (void)displayHUD {
    
}

- (void)spawnUFO {
    if (numberOfSpawnedUFOs >= self.numberOfUFOs) {
        return [self unschedule:@selector(spawnUFO)];
    }
    
    UFO *ufo = [self.ufoSpawner spawnUFO];
    
    if (ufo != nil && ufo.parent == nil) {
        ufo.bombDropper = self.bombDropper;
        
        numberOfSpawnedUFOs++;
        [self addChild:ufo];
        NSLog(@"UFO spawned");
    }
}

- (void)update:(CCTime)delta {
    if ([self isGameActive]) {
        [self checkCollisions];
        [self checkGameOver];
        [self checkLevelCompleted];
    }
}

- (BOOL) isGameActive {
    return !self.isGameOver && !self.isCompleted;
}

- (void)checkCollisions {
    BulletPool *bulletPool = self.spaceCraft.bulletLauncher.bulletPool;
    UFOPool *ufoPool = self.ufoSpawner.ufoPool;
    
    NSAssert((bulletPool != nil), @"Bullet pool is nil");
    NSAssert((ufoPool != nil), @"UFO pool is nil");
    
    for (Bullet *bullet in [bulletPool objects]) {
        // Skip inactive bullet
        if (bullet.isFree) continue;

        for (UFO *ufo in [ufoPool objects]) {
            // Skip out-of-battle UFOs
            if (ufo.isFree) continue;
            
            if (CGRectIntersectsRect(bullet.boundingBox, ufo.boundingBox)) {
                self.scores++;
                [ufo destroy];
                [bullet reset];
                numberOfDestroyedUFOs++;
            }
        }
    }
}

- (void)checkGameOver {
    BOOL over = NO;
    
    BombPool *bombPool = self.bombDropper.bombPool;
    NSAssert(bombPool != nil, @"Bomb pool is nil");
    
    for (Bomb *bomb in [bombPool objects]) {
        // Skip inactive bomb
        if (bomb.isFree) continue;
        
        if (CGRectIntersectsRect(bomb.boundingBox, self.spaceCraft.boundingBox)) {
            [self.spaceCraft destroy];
            [bomb reset];
            over = YES;
        }
    }
    
    if (!over) {
        BOOL outOfBullet = self.spaceCraft.numberOfBulletsFired > self.numberOfBullets;
        over = outOfBullet && numberOfDestroyedUFOs < self.numberOfUFOs;
    }
    
    if (over) {
        self.isGameOver = YES;
        [self gameOver];
    }
}

- (void)checkLevelCompleted {
    BOOL completed = !self.isGameOver && numberOfDestroyedUFOs == self.numberOfUFOs;
    
    if (completed) {
        self.isCompleted = completed;
        [self complete];
    }
}

- (void)backToIntroScene:(id)sender
{
    // Back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.isGameOver || self.isCompleted) return;
    
    [self.spaceCraft fire];
}

- (void)gameOver {
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Chalkduster" fontSize:30.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    
    CCActionBlink *blink = [CCActionBlink actionWithDuration:2.0f blinks:2];
    CCActionRepeatForever *repeater = [CCActionRepeatForever actionWithAction:blink];
    
    [label runAction:repeater];
    [self addChild:label];
    
    // Stop all actions
    [self.spaceCraft.bulletLauncher.bulletPool stopObjectActions];
    [self.ufoSpawner.ufoPool stopObjectActions];
    [self.bombDropper.bombPool stopObjectActions];
}

- (void)reset {
    
}

- (void)complete {
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Well done!" fontName:@"Chalkduster" fontSize:30.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor greenColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    
    [self addChild:label];
}

@end
