//
//  AERBoardingCardViewController.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 23/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERBoardingCardViewController.h"
#import "AERPassenger.h"
#import "UIImage+MDQRCode.h"

@interface AERBoardingCardViewController ()

@end

@implementation AERBoardingCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id) initWithModel:(AERBoardingCard *) boardingCard{
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
       _boardingCard = boardingCard;
        
        
    }


    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableString *fullNameData = [[NSMutableString alloc]init];
    
    [fullNameData appendString:self.boardingCard.surname];
    [fullNameData appendString:@"/"];
    [fullNameData appendString:self.boardingCard.name];
    
    _origin.text = self.boardingCard.origin;
    _destination.text = self.boardingCard.destination;
    _icaoDestination.text = self.boardingCard.icaoDestination;
    _icaoOrigin.text = self.boardingCard.icaoOrigin;
    _gate.text = self.boardingCard.gate;
    _group.text = @"1";
    _fullName.text = fullNameData;
    _boardingTime.text = @"20:10";
    _flightNumber.text = self.boardingCard.flightNumber;
    _seat.text = self.boardingCard.seat;
    _qrDate.text = @"19JUL";
    _qrFlight.text = self.boardingCard.flightNumber;
    _qrSeat.text = self.boardingCard.seat;
    
    NSMutableString *qrPaxData = [[NSMutableString alloc]init];
    [qrPaxData appendString:fullNameData];
    [qrPaxData appendString:self.boardingCard.flightNumber];
    [qrPaxData appendString:@"19JUL"];
    [qrPaxData appendString:@"GROUP 1"];
    [qrPaxData appendString:self.boardingCard.origin];
    [qrPaxData appendString:self.boardingCard.destination];
    [qrPaxData appendString:self.boardingCard.icaoOrigin];
    [qrPaxData appendString:self.boardingCard.icaoDestination];
    [qrPaxData appendString:self.boardingCard.seat];
    [qrPaxData appendString:@"BSM.V/.F/DLH3293.N/1234567890.P/CARMENRIVASENDBSM"];
    
    
    self.qr.image = [UIImage mdQRCodeForString:qrPaxData size:self.qr.bounds.size.width fillColor:[UIColor blackColor]];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
