//  AROverlayViewController.h
//  HowTall
//
//  Created by Kyle on 4/1/15.
//  Copyright (c) 2015 USU. All rights reserved.
//
//  Based on tutorial at
//  http://www.musicalgeometry.com/?p=1273
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "CaptureSessionManager.h"

@interface AROverlayViewController : UIViewController {
    
}

@property (retain) CaptureSessionManager *captureManager;
@property (nonatomic, retain) UILabel *scanningLabel;

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) float currentAngle;
@property (nonatomic, strong) UILabel *instructionLabel;

@property (nonatomic, assign) BOOL gotBase;
@property (nonatomic, assign) BOOL gotTop;

@end
