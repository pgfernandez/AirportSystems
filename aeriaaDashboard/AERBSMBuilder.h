//
//  AERBSMBuilder.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 21/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BSM_SMI @"BSM"
#define MSG_ACK @".A/"
#define FLIGHT_DETAILS @".F/"
#define BAGGAGE_TAG_DETAILS @".N/"
#define PASSENGER_NAME @".P/"
#define VERSION @".V/"
#define BSM_END @".ENDBSM"
#define SEPARATOR @"/"


@interface AERBSMBuilder : NSObject

@property (strong, nonatomic) NSString *bsm;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;
@property (strong, nonatomic) NSNumber *numberOfBags;
@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSString *destination;
@property (strong, nonatomic) NSString *icao;
@property (strong, nonatomic) NSString *licence;


-(id) initWithPaxNameAndFlightDetails:(NSString *) name
                           surname:(NSString *) surname
                      numberOfBags:(NSNumber *) numberOfBags
                      flightNumber:(NSString *)flightNumber
                       destination:(NSString *) destination
                                 icao:(NSString *) icao;



-(NSString *) getBSM;

@end
