//
//  AltitudeDataManager.m
//  AltitudeDataManager
//
//  Created by Pablo Alejandro on 01/04/2015.
//  Copyright (c) 2015 PabloAlejandro. All rights reserved.
//

#import "AltitudeDataManager.h"

@implementation AltitudeDataManager {
    CMAltimeter *altimeter;
}

#pragma mark - Public class instances

- (id)initWithDelegate:(id)delegate
{
    NSAssert(delegate, @"Delegate can't be null");
    
    if ((self = [super init])) {
        
        self.delegate = delegate;
        
        [self startProcess];
        
    }
    return self;
}

- (void)stopUpdatingRelativeAltitude
{
    [self stopProcess];
}

- (void)restartUpdatingRelativeAltitude
{
    [self startProcess];
}

#pragma mark - Private class instances (-)

- (id)init
{
    if ((self = [super init])) {
        
        [self startProcess];
    }
    return self;
}

- (void)stopProcess
{
    if(altimeter) {
        [altimeter stopRelativeAltitudeUpdates];
        altimeter = nil;
    }
}

- (void)startProcess
{
    BOOL supportsPressureSensor = [CMAltimeter isRelativeAltitudeAvailable];
    
    if(supportsPressureSensor) {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        altimeter = [CMAltimeter new];
        [altimeter startRelativeAltitudeUpdatesToQueue:queue withHandler:^(CMAltitudeData *data, NSError *err){
            dispatch_async(dispatch_get_main_queue(), ^{
                if(self.delegate)
                    [self.delegate relativeAltitudeUpdate:data error:err];
            });
        }];
        
    } else {
        
        NSError *err = [NSError errorWithDomain:@"Device does not hace pressure sensor" code:-1 userInfo:nil];
        [self.delegate deviceDoesNotSupportPressureSensor:err];
    }
}

#pragma mark - Public class methods (+)

+ (void)getSingleRelativeAltitudeUpdate:(void(^)(CMAltitudeData *data, NSError *error))completion
{
    if([CMAltimeter isRelativeAltitudeAvailable]) {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        CMAltimeter *altimeter = [CMAltimeter new];
        
        [altimeter startRelativeAltitudeUpdatesToQueue:queue withHandler:^(CMAltitudeData *data, NSError *err){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(data, err);
            });
            
            [altimeter stopRelativeAltitudeUpdates];
        }];
        
    } else {
        
        NSError *error = [NSError errorWithDomain:@"CMAltimeter not supported" code:-1 userInfo:nil];
        completion(nil, error);
    }
}

+ (BOOL)deviceSupportsPressureSensor
{
    return [CMAltimeter isRelativeAltitudeAvailable];
}

+ (BOOL)isRelativeAltitudeAvailable
{
    return [CMAltimeter isRelativeAltitudeAvailable];
}

@end
