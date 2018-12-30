//
//  AERPassenger.h
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 12/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERPassenger : NSObject

@property (strong, nonatomic) NSString *passengerName;
@property (strong, nonatomic) NSString *passengerSurname;
@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSString *boardingTime;
@property (strong, nonatomic) NSString *destination;
@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSString *icaoDestination;
@property (strong, nonatomic) NSString *icaoOrigin;
@property (strong, nonatomic) NSString *gate;
@property (strong, nonatomic) NSString *reservationNumber;


-(id) initWithPaxNameAndFlightDetails:(NSString *) passengerName
                           surname:(NSString *) passengerSurname
                      boardingTime:(NSString *) boardingTime
                      flightNumber:(NSString *) flightNumber
                       destination:(NSString *) destination
                            origin:(NSString *) origin
                   icaoDestination:(NSString *) icaoDestination
                        icaoOrigin:(NSString *) icaoOrigin
                              gate:(NSString*) gate
                 reservationNumber:(NSString*) reservationNumber;

@end
