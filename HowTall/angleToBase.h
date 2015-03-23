//
//  angleToBase.h
//  HowTall
//
//  Created by Kyle on 3/23/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface angleToBase : NSObject

+(angleToBase*)sharedInstance;

@property (nonatomic, assign) NSNumber* value;

@end
