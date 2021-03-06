//  CaptureSessionManager.h
//  HowTall
//
//  Created by Kyle on 4/1/15.
//  Copyright (c) 2015 USU. All rights reserved.
//
//  Based on tutorial at
//  http://www.musicalgeometry.com/?p=1273
//

#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>


@interface CaptureSessionManager : NSObject {

}

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;

- (void)addVideoPreviewLayer;
- (void)addVideoInput;

@end
