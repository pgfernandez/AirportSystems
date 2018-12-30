//
//  AERBoardingCard.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 28/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERBoardingCard : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;
@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSString *destination;
@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSString *icaoDestination;
@property (strong, nonatomic) NSString *icaoOrigin;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *gate;
@property (strong, nonatomic) NSString *seat;


-(id) initWithPaxNameAndFlightDetails:(NSString *) name
                              surname:(NSString *) surname
                         flightNumber:(NSString *) flightNumber
                          destination:(NSString *) destination
                               origin:(NSString *) origin
                      icaoDestination:(NSString *) icaoDestination
                           icaoOrigin:(NSString *) icaoOrigin
                                 gate:(NSString *) gate
                                 date:(NSString *) date
                                 seat:(NSString *) seat;


@end
