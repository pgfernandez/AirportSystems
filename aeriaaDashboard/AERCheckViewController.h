//
//  AERCheckViewController.h
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 13/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AERCheckViewController : UIViewController


@property (nonatomic, weak) IBOutlet UITextField *reservationCode;
@property (nonatomic, weak) IBOutlet UILabel *responseData;
@property (nonatomic, weak) IBOutlet UILabel *paxLabelData;
@property (nonatomic, weak) IBOutlet UILabel *flightLabel;
@property (nonatomic, weak) IBOutlet UILabel *fligthData;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameData;
@property (nonatomic, weak) IBOutlet UILabel *surnameLabel;
@property (nonatomic, weak) IBOutlet UILabel *surnameData;
@property (nonatomic, weak) IBOutlet UILabel *destinationLabel;
@property (nonatomic, weak) IBOutlet UILabel *icaoData;
@property (nonatomic, weak) IBOutlet UILabel *destinationData;
@property (nonatomic, weak) IBOutlet UILabel *stdLabel;
@property (nonatomic, weak) IBOutlet UILabel *stdData;
@property (nonatomic, weak) IBOutlet UILabel *seatTittleLabel;
@property (nonatomic, weak) IBOutlet UILabel *seatLabel;
@property (nonatomic, weak) IBOutlet UITextField *seatData;
@property (nonatomic, weak) IBOutlet UILabel *bagTittleLabel;
@property (nonatomic, weak) IBOutlet UILabel *bagLabel;
@property (nonatomic, weak) IBOutlet UITextField *bagData;
@property (nonatomic, weak) IBOutlet UIButton *boardingButton;
@property (nonatomic, weak) IBOutlet UIButton *bagTagButton;


@end
