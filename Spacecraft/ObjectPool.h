//
//  ObjectPool.h
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReusableObject.h"

@interface ObjectPool : NSObject

@property (nonatomic, assign) int maxCapacity;

+ (id) sharedPool;

- (ObjectPool*) initWithCapacity:(NSInteger)cap lazyObjectInit:(BOOL) lazyInit;
- (ReusableObject*) requestSingleObject:(BOOL)createNew;
- (NSArray*) requestMultipleObjects:(NSInteger)numberOfObjects createNewBulletsIfNeeded:(BOOL)createNew;
- (ReusableObject*) spawnObject;
- (BOOL) isFull;
- (NSArray*) objects;
- (void) stopObjectActions;

@end
