//
//  AERCheckViewController.m
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 13/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERCheckViewController.h"
#import "AERBagTagViewController.h"
#import "AERBoardingCardViewController.h"
#import "AERBoardingCard.h"
#import "AERBSMBuilder.h"
#import "Settings.h"

@interface AERCheckViewController (){

    // Define keys
    NSString *flightCode;
    NSString *destination;
    NSString *icao;
    NSString *std;
    NSString *name;
    NSString *surname;
    NSString *licence;
    
}

@end

@implementation AERCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                self.title = @"Check Pax";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
-(IBAction)searchPaxReservationCode:(id)sender{
    
    NSLog(@"Buscando la reserva: %@", self.reservationCode.text);
    
    flightCode = @"Flight";
    name = @"Name";
    surname =@"Surname";
    destination = @"Destination";
    std = @"STD";
    icao = @"ICAO";
    
  
    NSMutableString *url = [[NSMutableString alloc] initWithString: @"http://"];
    [url appendString:@LOCAL_IP];
    [url appendString:@":8183/dcs/CheckPax/"];
    [url appendString:self.reservationCode.text];

    
 // NSString *url = [[NSString alloc]initWithFormat:@"http://192.168.1.33:8183/dcs/CheckPax/%@", self.reservationCode.text ];
    
  NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:url]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        
        flightCode = [dataDict objectForKey:@"Flight"];
        name = [dataDict objectForKey:@"Name"];
        surname = [dataDict objectForKey:@"Surname"];
        destination = [dataDict objectForKey:@"Destination"];
        std = [dataDict objectForKey:@"STD"];
        icao = [dataDict objectForKey:@"ICAO"];
        
        
    }
    
    [self.paxLabelData setHidden:NO];
    [self.flightLabel setHidden:NO];
    [self.nameLabel setHidden:NO];
    [self.surnameLabel setHidden:NO];
    [self.destinationLabel setHidden:NO];
    [self.stdLabel setHidden:NO];
    [self.seatTittleLabel setHidden:NO];
    [self.seatLabel setHidden:NO];
    [self.seatData setHidden:NO];
    [self.boardingButton setHidden:NO];
    [self.bagTittleLabel setHidden:NO];
    [self.bagLabel setHidden:NO];
    [self.bagData setHidden:NO];
    [self.bagTagButton setHidden:NO];
    
    
    //self.responseData.text = self.reservationCode.text;
    self.fligthData.text = flightCode;
    self.nameData.text = name;
    self.surnameData.text = surname;
    self.destinationData.text = destination;
    self.icaoData.text = icao;
    self.stdData.text = std;
    
    //[self.responseData setHidden:NO];
    [self.fligthData setHidden:NO];
    [self.nameData setHidden:NO];
    [self.surnameData setHidden:NO];
    [self.destinationData setHidden:NO];
    [self.icaoData setHidden:NO];
    [self.stdData setHidden:NO];
    

    
}

-(IBAction)issuePaxBoardingCard:(id)sender{
    
    AERBoardingCard *boardingCard = [[AERBoardingCard alloc]initWithPaxNameAndFlightDetails:name
                                                                                    surname:surname
                                                                               flightNumber:flightCode
                                                                                destination:destination
                                                                                     origin:@"AER"
                                                                            icaoDestination:icao
                                                                                 icaoOrigin:@"AER"
                                                                                       gate:@"B07"
                                                                                       date:@"19JUL"
                                                                                       seat:self.seatData.text];
    
    AERBoardingCardViewController *boardingCardVC = [[AERBoardingCardViewController alloc]initWithModel:boardingCard];
    
    [self.navigationController pushViewController:boardingCardVC animated:YES];
    
    
}

-(IBAction)issuePaxBagTags:(id)sender{
    
    

    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * numberOfBags = [f numberFromString:self.bagData.text];
    
    
    
    AERBSMBuilder *paxBsm = [[AERBSMBuilder alloc]initWithPaxNameAndFlightDetails:name
                                                                          surname:surname
                                                                     numberOfBags:numberOfBags
                                                                     flightNumber:flightCode destination:destination
                                                                             icao:icao];
    

    
    //codifica los / del BSM para poder meterlos en la petición
    NSString *paxBSMEncoded = [[paxBsm getBSM] stringByReplacingOccurrencesOfString: @"/" withString:@"%2f"];

    NSLog(@"BSM encoded: %@", paxBSMEncoded);
    
    NSString *url = [[NSString alloc]initWithFormat:@"http://127.0.0.1:8183/dcs/CheckPax/BSM/%@", paxBSMEncoded];
    
    
    NSLog(@"Peticion de envío de BSM: %@", url);
    
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:url]];
    
  /*  id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];*/
    
    jsonSource = nil;
    
                            
    AERBagTagViewController *bagTagVC = [[AERBagTagViewController alloc]initWithModel:paxBsm];
    
    [self.navigationController pushViewController:bagTagVC animated:YES];
    
    
}




@end
