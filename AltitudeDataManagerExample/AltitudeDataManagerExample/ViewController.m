//
//  ViewController.m
//  AltitudeDataManagerExample
//
//  Created by Pau on 01/04/2015.
//  Copyright (c) 2015 PabloAlejandro. All rights reserved.
//

#import "ViewController.h"
#import "AltitudeDataManager.h"

@interface ViewController () <AltitudeDataManagerDelegate>

@property IBOutlet UILabel *pressureLabel;
@property IBOutlet UILabel *rAltitudeLabel;
@property IBOutlet UILabel *singlePressureLabel;

@end

@implementation ViewController {
    AltitudeDataManager *altitudeDataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    altitudeDataManager = [[AltitudeDataManager alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods

- (IBAction)getSingleReading:(id)sender
{
    [AltitudeDataManager getSingleRelativeAltitudeUpdate:^(CMAltitudeData *altitudeData, NSError *error){
        if(!error) {
            // Note: relative altitude will be always 0, as it takes just 1 reading
            self.singlePressureLabel.text = [NSString stringWithFormat:@"%.2f kPa", [altitudeData.pressure floatValue]];
        }
        else {
            NSLog(@"%s: %@", __func__, error);
        }
    }];
}

- (IBAction)start:(id)sender
{
    
}

- (IBAction)stop:(id)sender
{
    
}

#pragma mark - <AltitudeDataManagerDelegate>

- (void)relativeAltitudeUpdate:(CMAltitudeData *)altitudeData error:(NSError *)error
{
    if(!error) {
        self.pressureLabel.text = [NSString stringWithFormat:@"%.2f kPa", [altitudeData.pressure floatValue]];
        self.rAltitudeLabel.text = [NSString stringWithFormat:@"%.2f m", [altitudeData.relativeAltitude floatValue]];
    }
    else {
        NSLog(@"%s: %@", __func__, error);
    }
}

- (void)deviceDoesNotSupportPressureSensor:(NSError *)error
{
    NSLog(@"%s: %@", __func__, error);
}

@end
