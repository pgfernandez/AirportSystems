//
//  AERFlightsBuilder.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 16/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERFlightsBuilder.h"
#import "AERFlight.h"
#import "AERScheduledFlights.h"

@implementation AERFlightsBuilder

+ (NSArray *)flightsFromJSON:(NSData *)objectNotation error:(NSError **)error{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSLog(@"Recibido del WS: %@", objectNotation.description);
   

     
    
    
    //groups
    NSMutableArray *flights = [[NSMutableArray alloc] init];
/*
    NSArray *results = [parsedObject valueForKey:@"results"]; //ver la clave
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *flightsDic in results) {
        AERFlight *flight = [[AERFlight alloc] init];
        
        for (NSString *key in flightsDic) {
            if ([flight respondsToSelector:NSSelectorFromString(key)]) {
                [flight setValue:[flightsDic valueForKey:key] forKey:key];
            }
        }
        
        [flights addObject:flight];
    }
     
     */
    
    return flights;
    
}





@end
