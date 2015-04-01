//
//  AltitudeDataManager.h
//  AltitudeDataManager
//
//  Created by Pablo Alejandro on 01/04/2015.
//  Copyright (c) 2015 PabloAlejandro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

/*
 *  AltitudeDataManagerDelegate
 *
 * Discussion:
 *   Class delegate methods.
 */
@protocol AltitudeDataManagerDelegate

- (void)relativeAltitudeUpdate:(CMAltitudeData *)altitudeData error:(NSError *)error;

@optional

- (void)deviceDoesNotSupportPressureSensor:(NSError *)error;

@end

/*
 *  AltitudeDataManager
 *
 * Discussion:
 *   This class provides a simple way to get barometer notifications by means of a delegate.
 */
@interface AltitudeDataManager : NSObject

/*
 * initWithDelegate:
 *
 * @param delegate Class delegate
 *
 * Discussion:
 *   Main init method
 */
- (id)initWithDelegate:(id)delegate;

/*
 * stopUpdatingRelativeAltitude
 *
 * Discussion:
 *   Stops updating
 */
- (void)stopUpdatingRelativeAltitude;

/*
 * restartUpdatingRelativeAltitude
 *
 * Discussion:
 *   Restarts updating
 */
- (void)restartUpdatingRelativeAltitude;

/*
 * getSingleRelativeAltitudeUpdate:
 *
 * @param data Data containing barometer reading
 * @param error Possible error
 *
 * Discussion:
 *   Gives a single barometer pressure
 */
+ (void)getSingleRelativeAltitudeUpdate:(void(^)(CMAltitudeData *data, NSError *error))completion;

/*
 * deviceSupportsPressureSensor
 *
 * @return Whatever supports or not barometer
 *
 * Discussion:
 *   Used to know if device supports barometer readings
 */
+ (BOOL)deviceSupportsPressureSensor;

/*
 * isRelativeAltitudeAvailable
 *
 * @return Whatever reading is available
 *
 */
+ (BOOL)isRelativeAltitudeAvailable;

/*
 *  delegate
 *
 *  Discussion:
 *    Sets the delegate class
 *
 */
@property (nonatomic, strong) id <AltitudeDataManagerDelegate> delegate;

@end
