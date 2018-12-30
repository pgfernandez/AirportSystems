//
//  AERBoardingCardViewController.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 23/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AERBSMBuilder.h"
#import "AERBoardingCard.h"

@interface AERBoardingCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *qr;
@property (weak, nonatomic) IBOutlet UILabel *origin;
@property (weak, nonatomic) IBOutlet UILabel *destination;
@property (weak, nonatomic) IBOutlet UILabel *icaoOrigin;
@property (weak, nonatomic) IBOutlet UILabel *icaoDestination;
@property (weak, nonatomic) IBOutlet UILabel *gate;
@property (weak, nonatomic) IBOutlet UILabel *boardingTime;
@property (weak, nonatomic) IBOutlet UILabel *group;
@property (weak, nonatomic) IBOutlet UILabel *flightNumber;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *seat;
@property (weak, nonatomic) IBOutlet UILabel *qrDate;
@property (weak, nonatomic) IBOutlet UILabel *qrFlight;
@property (weak, nonatomic) IBOutlet UILabel *qrSeat;


@property (strong, nonatomic) AERBoardingCard *boardingCard;

-(id) initWithModel:(AERBoardingCard *) boardingCard;

@end
