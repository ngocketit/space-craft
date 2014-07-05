//
//  GameLevelLoader.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameLevel;

@interface GameLevelLoader : NSObject

+ (GameLevelLoader*) sharedGameLevelLoader;
- (GameLevel*) loadLevelFromFile:(NSString*) levelFile;
- (GameLevel*) defaultLevel;

@end
