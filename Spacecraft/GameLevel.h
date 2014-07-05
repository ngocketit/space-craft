//
//  GameLevel.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@class BombDropper;
@class Background;
@class Spacecraft;
@class UFOSpawner;

@interface GameLevel : CCScene

@property (nonatomic) NSString *levelName;
@property (nonatomic, assign) BOOL isGameOver;
@property (nonatomic, assign) BOOL isCompleted;

@property (nonatomic, assign) unsigned int numberOfUFOs;
@property (nonatomic, assign) unsigned int numberOfBullets;
@property (nonatomic, assign) unsigned int numberOfLives;
@property (nonatomic, assign) unsigned int scores;

@property (nonatomic) BombDropper *bombDropper;
@property (nonatomic) Background *background;
@property (nonatomic) Spacecraft *spaceCraft;
@property (nonatomic) UFOSpawner *ufoSpawner;

+ (GameLevel*) defaultLevel;

- (void) spawnUFO;

- (BOOL) isGameActive;
- (void) checkCollisions;
- (void) checkGameOver;
- (void) checkLevelCompleted;
- (void) displayHUD;

- (void) gameOver;
- (void) complete;
- (void) reset;

@end
