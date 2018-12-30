//
//  AERFlightsBuilder.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 16/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERFlightsBuilder : NSObject

+ (NSArray *)flightsFromJSON:(NSData *)objectNotation error:(NSError **)error;

//realmente devolverá AERScheduledFlights
@end
