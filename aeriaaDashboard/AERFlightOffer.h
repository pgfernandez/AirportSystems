//
//  AERFlightOffer.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 21/09/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERFlightOffer : NSObject


@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSString *destination;
@property (strong, nonatomic) NSString *cabin;
@property (strong, nonatomic) NSString *journeyType;
@property (strong, nonatomic) NSString *range;



// designated
-(id) initWithOrigin: (NSString *) origin
               destination: (NSString *) destination
                     cabin:(NSString *) cabin
               journeyType:(NSString *) journeyType
                     range:(NSString *) range;

@end
