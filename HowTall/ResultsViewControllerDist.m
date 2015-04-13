//
//  ResultsViewControllerDist.m
//  HowTall
//
//  Created by Kyle on 4/1/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import "ResultsViewControllerDist.h"
#import "calibratedLensHeight.h"
#import "angleToBase.h"

#define degreesToRadians( degrees ) ( ( degrees / 180.0) * M_PI )

@interface ResultsViewControllerDist ()

@end

@implementation ResultsViewControllerDist

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        // create GUI
        [self createResultsView];
        
        
    }
    
    return self;
    
}

/*
 Allocates the buttons and text box for the calibration screen with instruction labels */

-(void)createResultsView {
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    // Allocate buttons and text boxes
    UIButton *doneButton = [UIButton new];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor blueColor]];
    
    UILabel *distanceToObject = [UILabel new];
    UILabel *distanceToObjectResult = [UILabel new];
    
    UILabel *mainTitle = [UILabel new];
    
    distanceToObject.text = @"Distance to object:";
    
    
    mainTitle.text = @"How Tall?";
    
    [doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    // Add buttons and title to view
    [self.view addSubview:doneButton];
    [self.view addSubview:distanceToObject];
    [self.view addSubview:distanceToObjectResult];
    [self.view addSubview:mainTitle];
    
    // Create contraints for view
    doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    distanceToObject.translatesAutoresizingMaskIntoConstraints = NO;
    distanceToObjectResult.translatesAutoresizingMaskIntoConstraints = NO;
    mainTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[title(60.0)]-30-[distance(30.0)]-10-[distResult(30.0)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"distance" : distanceToObject,
                                                                                @"distResult" : distanceToObjectResult,
                                                                                @"title" : mainTitle
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[done(50.0)]-50-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"done" : doneButton}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[distance]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"distance" : distanceToObject,
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[distResult]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"distResult" : distanceToObjectResult,
                                                                                }]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[done]-60-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"done" : doneButton,
                                                                                }]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[title]-60-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"title" : mainTitle                                                                          }]];
    
    
    /* Magic maths to calculate height and distance */
    
    float bAngle = [angleToBase sharedInstance].value * (1.00 + ([angleToBase sharedInstance].calibrationAdjustment/100.0) - .05);
    
    float lensHeight = [calibratedLensHeight sharedInstance].value;
    
    
    float distance = tanf(degreesToRadians(bAngle)) * lensHeight;
    
    int distFeet = distance / 12;
    int distInch = (int)distance % 12;
    
    distanceToObjectResult.text = [NSString stringWithFormat:@"%i ft, %i inches (%.2f inches)" , distFeet, distInch, distance];
    
}

-(void)doneButtonPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
