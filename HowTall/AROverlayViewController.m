// Project taken from tutorial at
// http://www.musicalgeometry.com/?p=1273

#import "AROverlayViewController.h"

@implementation AROverlayViewController

@synthesize captureManager;
@synthesize scanningLabel;
@synthesize motionManager;
@synthesize currentAngle;

#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

- (void)viewDidLoad {
    
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
  
  UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlaygraphic.png"]];
  [overlayImageView setFrame:CGRectMake(30, 100, 260, 200)];
  [[self view] addSubview:overlayImageView];
  
  UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [overlayButton setImage:[UIImage imageNamed:@"scanbutton.png"] forState:UIControlStateNormal];
  [overlayButton setFrame:CGRectMake(130, 320, 60, 30)];
  [overlayButton addTarget:self action:@selector(scanButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [[self view] addSubview:overlayButton];
  
  UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 120, 30)];
  [self setScanningLabel:tempLabel];
	[scanningLabel setBackgroundColor:[UIColor clearColor]];
	[scanningLabel setFont:[UIFont fontWithName:@"Courier" size: 18.0]];
	[scanningLabel setTextColor:[UIColor redColor]]; 
	[scanningLabel setText:@"Scanning..."];
  [scanningLabel setHidden:YES];
	[[self view] addSubview:scanningLabel];	
  
	[[captureManager captureSession] startRunning];
}

- (void) scanButtonPressed {
	[[self scanningLabel] setHidden:NO];
	[self performSelector:@selector(hideLabel:) withObject:[self scanningLabel] afterDelay:2];
}

- (void)hideLabel:(UILabel *)label {
	[label setHidden:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

-(void) updateAngle:(CMAcceleration)acceleration {
    
    self.currentAngle = radiansToDegrees(atanf(acceleration.z/-acceleration.y)) + 90;
    
    // NSLog(@"%@", [NSString stringWithFormat:@"%.2f°", self.currentAngle]);
    
}


@end

