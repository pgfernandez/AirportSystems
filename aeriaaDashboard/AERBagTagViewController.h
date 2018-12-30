//
//  AERBagTagViewController.h
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 23/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AERBSMBuilder.h"

@interface AERBagTagViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *topLicenceData;
@property (nonatomic, weak) IBOutlet UILabel *bottomLicenceData;
@property (nonatomic, weak) IBOutlet UILabel *topFlightData;
@property (nonatomic, weak) IBOutlet UILabel *toFlightData;
@property (nonatomic, weak) IBOutlet UILabel *bottomFlightData;
@property (nonatomic, weak) IBOutlet UILabel *icaoData;

@property (strong, nonatomic) AERBSMBuilder *bsm;

-(id) initWithModel:(AERBSMBuilder *)bsm;

@end
