//
//  AdvancedView.m
//  HowTall
//
//  Created by Kyle on 4/12/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import "AdvancedView.h"
#import "angleToBase.h"

@interface AdvancedView ()

@property (nonatomic, strong) UITextField *userCalibrationBox;

@end

@implementation AdvancedView

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        // create GUI
        [self createAdvancedGUI];
        
        
    }
    
    return self;
    
}

/*
 Allocates the buttons and text box for the calibration screen with instruction labels */

-(void)createAdvancedGUI {
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    // Allocate buttons and text boxes
    UIButton *increaseCalibration = [UIButton new];
    UIButton *decreaseCalibration = [UIButton new];
    UIButton *doneCalibrating = [UIButton new];
    self.userCalibrationBox = [UITextField new];
    self.userCalibrationBox.enabled = NO;
    
    UILabel *userInstructions = [UILabel new];
    UILabel *userHint = [UILabel new];
    
    UIImageView *mainTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howTall"]];
    [[self view] addSubview:mainTitle];
    
    [increaseCalibration setTitle:@">" forState:UIControlStateNormal];
    increaseCalibration.backgroundColor = [UIColor redColor];
    [increaseCalibration addTarget:self action:@selector(increaseValue) forControlEvents:UIControlEventTouchUpInside];
    
    [decreaseCalibration setTitle:@"<" forState:UIControlStateNormal];
    decreaseCalibration.backgroundColor = [UIColor redColor];
    [decreaseCalibration addTarget:self action:@selector(decreaseValue) forControlEvents:UIControlEventTouchUpInside];
    
    [doneCalibrating setTitle:@"Done" forState:UIControlStateNormal];
    doneCalibrating.backgroundColor = [UIColor blueColor];
    [doneCalibrating addTarget:self action:@selector(doneCalibrating) forControlEvents:UIControlEventTouchUpInside];
    
    self.userCalibrationBox.backgroundColor = [UIColor whiteColor];
    self.userCalibrationBox.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.userCalibrationBox.textAlignment = NSTextAlignmentCenter;
    self.userCalibrationBox.text = [NSString stringWithFormat:@"%i" , [angleToBase sharedInstance].calibrationAdjustment];
    
    userInstructions.text = @"Use these buttons to adjust calibration if reported results are too high or too low:";
    userInstructions.numberOfLines = 0;
    
    userHint.text = @"If the reported results are too high set it negative. If they are too low set it positive. Use small values and test for accuracy.";
    userHint.numberOfLines = 0;
    
    // Add buttons and title to view
    [self.view addSubview:increaseCalibration];
    [self.view addSubview:decreaseCalibration];
    [self.view addSubview:self.userCalibrationBox];
    [self.view addSubview:userInstructions];
    [self.view addSubview:userHint];
    [self.view addSubview:mainTitle];
    [self.view addSubview:doneCalibrating];
    
    // Create contraints for view
    increaseCalibration.translatesAutoresizingMaskIntoConstraints = NO;
    decreaseCalibration.translatesAutoresizingMaskIntoConstraints = NO;
    self.userCalibrationBox.translatesAutoresizingMaskIntoConstraints = NO;
    userInstructions.translatesAutoresizingMaskIntoConstraints = NO;
    userHint.translatesAutoresizingMaskIntoConstraints = NO;
    mainTitle.translatesAutoresizingMaskIntoConstraints = NO;
    doneCalibrating.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[title(100.0)]-5-[instructions(60.0)]-10-[input(40.0)]-10-[hint(80.0)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"instructions" : userInstructions,
                                                                                @"input" :self.userCalibrationBox,
                                                                                @"hint" : userHint,
                                                                                @"title" : mainTitle,
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[done(50.0)]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"done" : doneCalibrating}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[instructions]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"instructions" : userInstructions,
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[input]-10-[decrease(50.0)]-10-[increase(50.0)]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"input" : self.userCalibrationBox,
                                                                                @"increase" : increaseCalibration,
                                                                                @"decrease" : decreaseCalibration
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[hint]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"hint" : userHint                                                                          }]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[done]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"done" : doneCalibrating                                                                          }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[title]-60-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"title" : mainTitle                                                                          }]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:increaseCalibration
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.userCalibrationBox
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:increaseCalibration
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.userCalibrationBox
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:decreaseCalibration
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.userCalibrationBox
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:decreaseCalibration
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.userCalibrationBox
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0]];
    
    
    
}

-(void)increaseValue {
    
    if ([self.userCalibrationBox.text integerValue] < 10)
    {
        self.userCalibrationBox.text = [NSString stringWithFormat:@"%i" , [self.userCalibrationBox.text integerValue] + 1];
    }
}


-(void)decreaseValue {
    
    if ([self.userCalibrationBox.text integerValue] > -10)
    {
        self.userCalibrationBox.text = [NSString stringWithFormat:@"%i" , [self.userCalibrationBox.text integerValue] - 1];
    }
}

-(void)doneCalibrating {
    
    [angleToBase sharedInstance].calibrationAdjustment = [self.userCalibrationBox.text integerValue];
    
    [self.navigationController popViewControllerAnimated:YES];
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
