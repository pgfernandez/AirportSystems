//
//  AERFlight.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 08/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERFlight.h"

@implementation AERFlight



-(id) initWithFlightNumber: (NSString *) flightNumber
                    origin:(NSString *) origin
               destination: (NSString *) destination
             scheduledTime: (NSDate *) scheduledTime
             estimatedTime:(NSDate *) estimatedTime
              assignedGate:(NSString *) assignedGate
                  aircraft:(NSString *) aircraft
                  terminal:(NSString *) terminal{
//                      logo:(UIImage *) logo{
    
    
    
    if (self == [super init]){
    
    _flightNumber = flightNumber;
        _origin = origin;
        _destination = destination;
        _scheduledTime = scheduledTime;
        _estimatedTime = estimatedTime;
        _assignedGate = assignedGate;
        _aircraft = aircraft;
        _terminal = terminal;
      //  _logo = logo;
    
    
    }
    return self;
    
}


@end
