//
//  AERPassenger.h
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 12/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERBooking : NSObject

@property (strong, nonatomic) NSString *reservationNumber;
@property (strong, nonatomic) NSString *flightNumber;
@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSString *destination;
@property (strong, nonatomic) NSDate *scheduledTime;
@property (strong, nonatomic) NSString *assignedGate;
@property (strong, nonatomic) NSString *assignedSeat;
@property (strong, nonatomic) NSArray *passengers;
@property (strong, nonatomic) NSArray *bagTags;
@property (nonatomic) int bagsChecked;
@property (nonatomic) BOOL checked;

@end
