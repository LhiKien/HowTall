//
//  ViewController.m
//  HowTall
//
//  Created by Kyle on 3/4/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import "ViewController.h"
#import "calibratedLensHeight.h"
#import "angleToBase.h"
#import "angleToTop.h"
#import "calibrateView.h"
#import "AROverlayViewController.h"
#import "AROverlayViewControllerDist.h"

@interface ViewController ()

@end

@implementation ViewController

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        // create GUI
        [self createMainGUI];
        
        
    }
    
    return self;
    
}

/*
 Allocates the three main buttons and title image for the main screen and sets constraints for their positioning and adds them to the view
 */

-(void)createMainGUI {
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
   
    // Allocate buttons and title
    UIButton *calibrateButton = [UIButton new];
    UIButton *getDistanceButton = [UIButton new];
    UIButton *getHeightButton = [UIButton new];
    
    UIImageView *mainTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howTall"]];
    [[self view] addSubview:mainTitle];
    
    [calibrateButton setTitle:@"Don't forget to Calibrate first!" forState:UIControlStateNormal];
    calibrateButton.backgroundColor = [UIColor redColor];
    
    [getDistanceButton setTitle:@"Get distance to object" forState:UIControlStateNormal] ;
    getDistanceButton.backgroundColor = [UIColor blueColor];
    
    [getHeightButton setTitle:@"Get height of object" forState:UIControlStateNormal];
    getHeightButton.backgroundColor = [UIColor blueColor];
    
    // set targets for buttons
    [calibrateButton addTarget:self action:@selector(pushCalibrateView) forControlEvents:UIControlEventTouchUpInside];
    [getDistanceButton addTarget:self action:@selector(getDistanceWithCamera) forControlEvents:UIControlEventTouchUpInside];
    [getHeightButton addTarget:self action:@selector(getHeightWithCamera) forControlEvents:UIControlEventTouchUpInside];
    
    // Add buttons and title to view
    [self.view addSubview:calibrateButton];
    [self.view addSubview:getDistanceButton];
    [self.view addSubview:getHeightButton];
    
    [self.view addSubview:mainTitle];
    
    // Create contraints for view
    calibrateButton.translatesAutoresizingMaskIntoConstraints = NO;
    getDistanceButton.translatesAutoresizingMaskIntoConstraints = NO;
    getHeightButton.translatesAutoresizingMaskIntoConstraints = NO;
    mainTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[title(100.0)]-30-[calibrate(50.0)]-80-[height(50.0)]-30-[distance(50.0)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"calibrate" : calibrateButton,
                                                                                @"distance" :getDistanceButton,
                                                                                @"height" : getHeightButton,
                                                                                @"title" : mainTitle
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[calibrate]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"calibrate" : calibrateButton,
                                                                                    }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[distance]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"distance" :getDistanceButton,
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[height]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"height" : getHeightButton                                                                          }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[title]-60-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"title" : mainTitle                                                                          }]];
    
    
    
}


/* Pushes on the calbrate screen view controller */

-(void)pushCalibrateView {
    
    calibrateView *calibrateScreen = [calibrateView new];
    
    [self.navigationController pushViewController:calibrateScreen animated:YES];
    
}

-(void)getHeightWithCamera {
    
    AROverlayViewController *cameraOverlayView = [AROverlayViewController new];
    
    [self.navigationController pushViewController:cameraOverlayView animated:YES];
}

-(void)getDistanceWithCamera {
    
    AROverlayViewControllerDist *cameraOverlayView = [AROverlayViewControllerDist new];
    
    [self.navigationController pushViewController:cameraOverlayView animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
