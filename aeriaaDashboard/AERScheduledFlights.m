//
//  AERScheduledFlights.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 08/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERScheduledFlights.h"

@interface AERScheduledFlights()
@property (nonatomic, strong) NSArray *flights;
@end

@implementation AERScheduledFlights

#pragma mark - Properties

-(NSUInteger) flightsCount{
    
    return [self.flights count];
}

#pragma mark - Init

-(id) initWithScheduledDate:(NSDate *)date{
    
    if (self = [super init]){
        
        
        // Cremos los vuelos, aquí deberían ir lo que recoja por el web service
        
        AERFlight *f1 = [[AERFlight alloc] initWithFlightNumber:@"IB3825"
                                                         origin:@"AER"
                                                    destination:@"MAD"
                                                  scheduledTime:date
                                                  estimatedTime:date
                                                   assignedGate:@"A19"
                                                       aircraft:@"A320"
                                                       terminal:@"1"];
                                                           //logo:<#(UIImage *)#>
        
        
        AERFlight *f2 = [[AERFlight alloc] initWithFlightNumber:@"IB3930"
                                                         origin:@"AER"
                                                    destination:@"JFK"
                                                  scheduledTime:date
                                                  estimatedTime:date
                                                   assignedGate:@"A15"
                                                       aircraft:@"A330"
                                                       terminal:@"1"];
        
        AERFlight *f3 = [[AERFlight alloc] initWithFlightNumber:@"IB2528"
                                                         origin:@"AER"
                                                    destination:@"FRA"
                                                  scheduledTime:date
                                                  estimatedTime:date
                                                   assignedGate:@"A12"
                                                       aircraft:@"A321"
                                                       terminal:@"1"];
        
        AERFlight *f4 = [[AERFlight alloc] initWithFlightNumber:@"IBS3012"
                                                         origin:@"AER"
                                                    destination:@"CDG"
                                                  scheduledTime:date
                                                  estimatedTime:date
                                                   assignedGate:@"A12"
                                                       aircraft:@"A320"
                                                       terminal:@"1"];

        self.flights = @[f1,f2, f3, f4];
        
    }
    
    return self;
}


#pragma mark - Accessors

-(AERFlight *) flightAtIndex:(NSUInteger)index{

    return [self.flights objectAtIndex:index];
    
}

@end
