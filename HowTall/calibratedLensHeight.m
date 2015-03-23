//
//  calibratedLensHeight.m
//  HowTall
//
//  Created by Kyle on 3/23/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import "calibratedLensHeight.h"

@implementation calibratedLensHeight

+(calibratedLensHeight*)sharedInstance
{
    static calibratedLensHeight *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        instance.value = 66.0;
    });
    
    return instance;
}

@end
