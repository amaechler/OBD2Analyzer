//
//  FirstViewController.m
//  obd2-analyzer
//
//  Created by Andreas Maechler on 19/01/16.
//  Copyright © 2016 amaechler. All rights reserved.
//

#import "FirstViewController.h"

#import "ELM327.h"
#import "FLECUSensor.h"


@interface FirstViewController ()

@property (nonatomic, strong) ELM327 *scanTool;

@property (weak, nonatomic) IBOutlet UITextField *hostIpAddress;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (weak, nonatomic) IBOutlet UILabel* statusLabel;
@property (weak, nonatomic) IBOutlet UILabel* scanToolNameLabel;

@property (weak, nonatomic) IBOutlet UILabel* rpmLabel;
@property (weak, nonatomic) IBOutlet UILabel* speedLabel;
@property (weak, nonatomic) IBOutlet UILabel* tempLabel;

@end


@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Set a default IP address
    self.hostIpAddress.text = @"192.168.1.66";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (IBAction)scanButtonClicked:(id)sender
{
    if ([self.scanButton.currentTitle isEqual: @"Start"]) {
        [self.scanButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self startScan];
    } else {
        [self stopScan];
        [self.scanButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)startScan
{
    self.statusLabel.text = @"Initializing...";
    
    ELM327 *scanTool = [ELM327 scanToolWithHost:self.hostIpAddress.text andPort:35000];
    [scanTool setUseLocation:YES];
    [scanTool setDelegate:self];
    [scanTool startScanWithSensors:^NSArray *{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statusLabel.text = @"Scanning...";
            self.scanToolNameLabel.text = scanTool.scanToolName;
        });
        
        NSArray *sensors = @[@(OBD2SensorEngineRPM),
                             @(OBD2SensorVehicleSpeed),
                             @(OBD2SensorOxygenSensorsPresent)];
        
        return sensors;
    }];
    
    [self setScanTool:scanTool];
}

- (void)stopScan
{
    ELM327 *scanTool = self.scanTool;
    [scanTool cancelScan];
    [scanTool setSensorScanTargets:nil];
    [scanTool setDelegate:nil];
}


#pragma mark - FLScanToolDelegate

- (void)scanTool:(FLScanTool *)scanTool didUpdateSensor:(FLECUSensor *)sensor
{
    UILabel *sensorLabel = nil;
    
    switch (sensor.pid) {
        case OBD2SensorEngineRPM:
            sensorLabel = self.rpmLabel;
            break;
        case OBD2SensorVehicleSpeed:
            sensorLabel = self.speedLabel;
            break;
        default:
            sensorLabel = self.tempLabel;
            break;
    }
    
    [self showSensorValue:sensor onLabel:sensorLabel];
}

- (void)showSensorValue:(FLECUSensor *)sensor onLabel:(UILabel *)label
{
    NSString *sensorValue = [NSString stringWithFormat:@"%@ %@",
                             [sensor valueStringForMeasurement1:NO],
                             [sensor imperialUnitString]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [label setText:sensorValue];
    });
}

@end
