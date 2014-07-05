//
//  GameLevelLoader.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/13/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "GameLevelLoader.h"
#import "GameLevel.h"
#import "BulletLauncher.h"

static GameLevelLoader *loader = nil;

@implementation GameLevelLoader

+ (GameLevelLoader *)sharedGameLevelLoader {
    if (loader == nil) {
        loader = [[self alloc] init];
    }
    
    return loader;
}

- (GameLevel *)defaultLevel {
    return [GameLevel defaultLevel];
}

- (GameLevel *)loadLevelFromFile:(NSString *)levelFile {
    GameLevel *level = nil;
    
    NSURL *levelURL = [[NSBundle mainBundle] URLForResource:levelFile withExtension:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:levelURL];
    
    if (dict != nil) {
        level = [[GameLevel alloc] init];
        
        // Level name
        NSString *name = [dict objectForKey:@"levelName"];
        if (name != nil) {
            level.levelName = name;
        }
        
        // Number of UFOs
        NSNumber *ufoCount = [dict objectForKey:@"numberOfUFOs"];
        if (ufoCount != nil) {
            level.numberOfUFOs = [ufoCount unsignedIntValue];
        }
        
        // Number of lives
        NSNumber *livesCount = [dict objectForKey:@"numberOfLives"];
        if (livesCount != nil) {
            level.numberOfLives = [livesCount unsignedIntValue];
        }
        
        NSArray *objectKeys = @[@"bulletLauncher", @"bombDropper", @"spaceCraft", @"ufoSpawner", @"background"];
        
        for(NSString *key in objectKeys) {
            NSString *value = [dict objectForKey:key];
            
            if (value != nil) {
                NSObject *object = [[NSClassFromString(value) alloc] init];
                if (object != nil) {
                    [level setValue:objectKeys forKey:key];
                }
            }
        }
    }
    
    return level;
}

@end
