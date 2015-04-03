//  AROverlayViewControllerDist.m
//  HowTall
//
//  Created by Kyle on 4/1/15.
//  Copyright (c) 2015 USU. All rights reserved.
//
//  Based on tutorial at
//  http://www.musicalgeometry.com/?p=1273
//

#import "AROverlayViewControllerDist.h"
#import "angleToBase.h"
#import "ResultsViewControllerDist.h"

@implementation AROverlayViewControllerDist

@synthesize captureManager;
@synthesize scanningLabel;
@synthesize motionManager;
@synthesize currentAngle;
@synthesize instructionLabel;
@synthesize gotBase;

#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

- (void)viewDidLoad {
    
    self.gotBase = false;
    
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 0.2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 [self updateAngle:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];

  
	[self setCaptureManager:[[CaptureSessionManager alloc] init]];
  
	[[self captureManager] addVideoInput];
  
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = [[[self view] layer] bounds];
	[[[self captureManager] previewLayer] setBounds:layerRect];
	[[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
  
  UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red-crosshair"]];
  [overlayImageView setFrame:CGRectMake(self.view.center.x-60, self.view.center.y-90, 120, 120)];
  [[self view] addSubview:overlayImageView];
  
  UIButton *overlayButton = [UIButton new];
  [overlayButton setFrame:CGRectMake(self.view.center.x-60, self.view.center.y+120, 120, 60)];
  [overlayButton addTarget:self action:@selector(markButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [overlayButton setTitle:@"Mark" forState:UIControlStateNormal];
    [overlayButton setBackgroundColor:[UIColor blueColor]];
  [[self view] addSubview:overlayButton];
    
    UIButton *quitButton = [UIButton new];
    [quitButton setFrame:CGRectMake(30, 30, 60, 30)];
    [quitButton addTarget:self action:@selector(quitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [quitButton setBackgroundColor:[UIColor redColor]];
    [[self view] addSubview:quitButton];
  
  self.instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, overlayButton.center.y-110, 280, 60)];
    self.instructionLabel.text = @"Place crosshair at BASE of object and press Mark";
    self.instructionLabel.numberOfLines = 0;
	[self.instructionLabel setBackgroundColor:[UIColor clearColor]];
	[self.instructionLabel setFont:[UIFont fontWithName:@"Courier" size: 18.0]];
	[self.instructionLabel setTextColor:[UIColor blueColor]];
	[[self view] addSubview:self.instructionLabel];	
  
	[[captureManager captureSession] startRunning];
}

- (void) markButtonPressed {
    
    if (!self.gotBase)
    {
        [angleToBase sharedInstance].value = self.currentAngle;
        self.gotBase = true;
        
        ResultsViewControllerDist *results = [[ResultsViewControllerDist alloc] init];
        [self.navigationController pushViewController:results animated:YES];
    }
    
}

-(void) quitButtonPressed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

-(void) updateAngle:(CMAcceleration)acceleration {
    
    self.currentAngle = radiansToDegrees(atanf(acceleration.z/-acceleration.y)) + 90;
    
    //NSLog(@"%@", [NSString stringWithFormat:@"%.2f°", self.currentAngle]);
    
}



@end

