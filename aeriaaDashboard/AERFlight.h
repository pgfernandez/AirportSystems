//
//  AERFlight.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 08/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AERFlight : NSObject

@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSString *destination;
@property (strong, nonatomic) NSDate *scheduledTime;
@property (strong, nonatomic) NSDate *estimatedTime;
@property (strong, nonatomic) NSString *assignedGate;
@property (strong, nonatomic) NSString *aircraft;
@property (strong, nonatomic) NSString *terminal;
@property (strong, nonatomic) NSString *counter;
@property (strong, nonatomic) NSString *carrousel;
@property (weak, nonatomic) UIImage *logo;

// designated
-(id) initWithFlightNumber: (NSString *) flightNumber
                    origin:(NSString *) origin
               destination: (NSString *) destination
             scheduledTime: (NSDate *) scheduledTime
             estimatedTime:(NSDate *) estimatedTime
              assignedGate:(NSString *) assignedGate
                  aircraft:(NSString *) aircraft
                  terminal:(NSString *) terminal;
           //           logo:(UIImage *) logo;

@end
