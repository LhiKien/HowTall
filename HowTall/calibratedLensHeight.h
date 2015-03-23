//
//  calibratedLensHeight.h
//  HowTall
//
//  Created by Kyle on 3/23/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calibratedLensHeight : NSObject

+(calibratedLensHeight*)sharedInstance;

@property (nonatomic, assign) float value;

@end
