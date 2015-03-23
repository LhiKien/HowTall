//
//  angleToTop.m
//  HowTall
//
//  Created by Kyle on 3/23/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import "angleToTop.h"

@implementation angleToTop

+(angleToTop*)sharedInstance
{
    static angleToTop *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        instance.value = @(-1.0);
    });
    
    return instance;
}

@end
