//
//  ObjectPool.m
//  Spacecraft
//
//  Created by Phi Van Ngoc on 4/12/14.
//  Copyright (c) 2014 Phi Van Ngoc. All rights reserved.
//

#import "ObjectPool.h"

static NSMutableDictionary *sharedInstances = nil;

@implementation ObjectPool {
    NSMutableArray *objects;
}

+ (void)initialize {
    if (sharedInstances == nil) {
        sharedInstances = [NSMutableDictionary dictionary];
    }
}

+ (id)sharedPool {
    NSString *className = NSStringFromClass(self);
    
    id pool = nil;
    
    @synchronized(self) {
        pool = [sharedInstances objectForKey:className];
        
        if (pool == nil) {
            pool = [[self alloc] init];
            [sharedInstances setObject:pool forKey:className];
        }
    }
    
    return pool;
}

- (id)init {
    return [self initWithCapacity:self.maxCapacity lazyObjectInit:YES];
}

- (ObjectPool *)initWithCapacity:(NSInteger)cap lazyObjectInit:(BOOL)lazyInit {
    if (self = [super init]) {
        if (cap > self.maxCapacity) {
            NSLog(@"Number of requested bullets exceeds maximum pool size: %d", self.maxCapacity);
            cap = self.maxCapacity;
        }
        
        if (objects == nil) {
            objects = [[NSMutableArray alloc] initWithCapacity:cap];
        }
        
        if (!lazyInit) {
            for (int i = 0; i < cap; i++) {
                [objects addObject:[self spawnObject]];
            }
        }
    }
    
    return self;
}

- (BOOL) isFull {
    return ([objects count] == self.maxCapacity);
}

- (ReusableObject *)spawnObject {
    ReusableObject *object = [[ReusableObject alloc] init];
    
    return object;
}

- (ReusableObject *)requestSingleObject:(BOOL)createNew {
    for(ReusableObject * object in objects) {
        if (object.isFree) {
            object.isFree = NO;
            // Make object visible
            object.visible = YES;
            return object;
        }
    }
    
    if (createNew && ![self isFull]) {
        ReusableObject *newObject = [self spawnObject];
        [objects addObject:newObject];
        
        newObject.isFree = NO;
        
        return newObject;
    }
    
    return nil;
}

- (NSArray *)requestMultipleObjects:(NSInteger)numberOfObjects createNewBulletsIfNeeded:(BOOL)createNew {
    NSMutableArray *freeObjects = [[NSMutableArray alloc] initWithCapacity:numberOfObjects];
    int count = 0;
    
    for (ReusableObject *object in objects) {
        if (object.isFree && count < numberOfObjects) {
            object.visible = YES;
            object.isFree = NO;
            [freeObjects addObject:object];
            count++;
        }
    }
    
    if (createNew && ![self isFull]) {
        while (count < numberOfObjects) {
            ReusableObject *newObject = [self spawnObject];
            
            newObject.isFree = NO;
            [freeObjects addObject:newObject];
            [objects addObject:newObject];
            count++;
        }
    }
    
    return freeObjects;
}

- (NSArray *)objects {
    return objects;
}

- (void)stopObjectActions {
    for (ReusableObject *object in objects) {
        if (!object.isFree) {
            [object stopAllActions];
            [object unscheduleAllSelectors];
        }
    }
}

@end
