//
//  AERScheduledFlights.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 08/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AERFlight.h"

@interface AERScheduledFlights : NSObject


@property (nonatomic, readonly) NSUInteger flightsCount;

-(AERFlight *) flightAtIndex: (NSUInteger) index;
-(id) initWithScheduledDate:(NSDate *) date;


@end
