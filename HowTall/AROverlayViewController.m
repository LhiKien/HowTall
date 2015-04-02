// Project taken from tutorial at
// http://www.musicalgeometry.com/?p=1273

#import "AROverlayViewController.h"
#import "angleToBase.h"
#import "angleToTop.h"
#import "ResultsViewController.h"

@implementation AROverlayViewController

@synthesize captureManager;
@synthesize scanningLabel;
@synthesize motionManager;
@synthesize currentAngle;
@synthesize instructionLabel;
@synthesize gotBase;
@synthesize gotTop;

#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

- (void)viewDidLoad {
    
    self.gotBase = false;
    self.gotTop = false;
    
    
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
  [overlayImageView setFrame:CGRectMake(self.view.center.x-60, self.view.center.y-60, 120, 120)];
  [[self view] addSubview:overlayImageView];
  
  UIButton *overlayButton = [UIButton new];
  [overlayButton setFrame:CGRectMake(self.view.center.x-60, self.view.center.y+120, 120, 60)];
  [overlayButton addTarget:self action:@selector(markButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [overlayButton setTitle:@"Mark" forState:UIControlStateNormal];
    [overlayButton setBackgroundColor:[UIColor blueColor]];
  [[self view] addSubview:overlayButton];
  
  self.instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, 50, 280, 60)];
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
        self.instructionLabel.text = @"Place crosshair at TOP  of object and press Mark";
        self.gotBase = true;
        
    } else if (!self.gotTop)
    {
        [angleToTop sharedInstance].value = self.currentAngle;
        
        ResultsViewController *results = [[ResultsViewController alloc] init];
        [self.navigationController pushViewController:results animated:YES];
    }
    
}

- (void)hideLabel:(UILabel *)label {
	[label setHidden:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

-(void) updateAngle:(CMAcceleration)acceleration {
    
    self.currentAngle = radiansToDegrees(atanf(acceleration.z/-acceleration.y)) + 90;
    
    //NSLog(@"%@", [NSString stringWithFormat:@"%.2f°", self.currentAngle]);
    
}



@end

