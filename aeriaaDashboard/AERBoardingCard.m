//
//  AERBoardingCard.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 28/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERBoardingCard.h"

@implementation AERBoardingCard

-(id) initWithPaxNameAndFlightDetails:(NSString *) name
                              surname:(NSString *) surname
                         flightNumber:(NSString *) flightNumber
                          destination:(NSString *) destination
                               origin:(NSString *) origin
                      icaoDestination:(NSString *) icaoDestination
                           icaoOrigin:(NSString *) icaoOrigin
                                 gate:(NSString *) gate
                                 date:(NSString *) date
                                 seat:(NSString *)seat{
    
    
    
    _name = name;
    _surname = surname;
    _flightNumber = flightNumber;
    _destination = destination;
    _origin = origin;
    _icaoOrigin = icaoOrigin;
    _icaoDestination = icaoDestination;
    _gate = gate;
    _date = date;
    _seat = seat;
    
    
    
    return self;
}

@end
