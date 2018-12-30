//
//  AERBSMBuilder.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 21/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERBSMBuilder.h"
#include <stdlib.h>

@implementation AERBSMBuilder




-(id)initWithPaxNameAndFlightDetails:(NSString *) name
surname:(NSString *) surname
numberOfBags:(NSNumber *)numberOfBags
flightNumber:(NSString *)flightNumber
destination:(NSString *) destination
icao:(NSString *)icao{


    _name = name;
    _surname = surname;
    _numberOfBags = numberOfBags;
    _flightNumber = flightNumber;
    _destination = destination;
    _icao = icao;
   
    
    long licence_number = labs(arc4random() % 9999999999);
    
     _licence = [[NSNumber numberWithLong:licence_number] stringValue];
    
    _bsm = BSM_SMI;
    
    //version section
    _bsm = [_bsm stringByAppendingString:VERSION];
    
    //flight section
    _bsm = [_bsm stringByAppendingString:FLIGHT_DETAILS];
    _bsm = [_bsm stringByAppendingString:self.flightNumber];
    _bsm = [_bsm stringByAppendingString:SEPARATOR];
    _bsm = [_bsm stringByAppendingString:[numberOfBags stringValue]];
    _bsm = [_bsm stringByAppendingString:SEPARATOR];
    _bsm = [_bsm stringByAppendingString:BAGGAGE_TAG_DETAILS];
    _bsm = [_bsm stringByAppendingString:self.licence];
    _bsm = [_bsm stringByAppendingString:PASSENGER_NAME];
    _bsm = [_bsm stringByAppendingString:self.name];
    _bsm = [_bsm stringByAppendingString:self.surname];
    _bsm = [_bsm stringByAppendingString:BSM_END];
    
    return self;
}

-(NSString *) getBSM{
    
    return self.bsm;
}


@end
