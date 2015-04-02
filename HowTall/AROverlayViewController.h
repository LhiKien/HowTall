// Project taken from tutorial at
// http://www.musicalgeometry.com/?p=1273

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "CaptureSessionManager.h"

@interface AROverlayViewController : UIViewController {
    
}

@property (retain) CaptureSessionManager *captureManager;
@property (nonatomic, retain) UILabel *scanningLabel;

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) float currentAngle;

@end
