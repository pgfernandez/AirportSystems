//
//  AERPassenger.m
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 12/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERPassenger.h"

@implementation AERPassenger


-(id) initWithPaxNameAndFlightDetails:(NSString *) passengerName
                              surname:(NSString *) passengerSurname
                         boardingTime:(NSString *) boardingTime
                         flightNumber:(NSString *) flightNumber
                          destination:(NSString *) destination
                               origin:(NSString *) origin
                      icaoDestination:(NSString *) icaoDestination
                           icaoOrigin:(NSString *) icaoOrigin
                                 gate:(NSString*) gate
                                 reservationNumber:(NSString *)reservationNumber{
    
    _passengerName = passengerName;
    _passengerSurname = passengerSurname;
    _boardingTime = boardingTime;
    _flightNumber = flightNumber;
    _destination = destination;
    _origin = origin;
    _icaoDestination = icaoDestination;
    _icaoOrigin = icaoOrigin;
    _gate = gate;
    _reservationNumber = reservationNumber;
    
    
    return self;
}


@end
