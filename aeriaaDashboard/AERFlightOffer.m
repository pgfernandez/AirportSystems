//
//  AERFlightOffer.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 21/09/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERFlightOffer.h"

@implementation AERFlightOffer


-(id) initWithOrigin: (NSString *) origin
         destination: (NSString *) destination
               cabin:(NSString *) cabin
         journeyType:(NSString *) journeyType
               range:(NSString *) range{
    
    
    if (self == [super init]){
        
        _origin = origin;
        _destination = destination;
        _journeyType = journeyType;
        _range = range;
        _cabin = cabin;
    }
    
    return self;
}



@end
