//
//  AERBagTagViewController.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 23/06/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERBagTagViewController.h"

@interface AERBagTagViewController ()

@end

@implementation AERBagTagViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/



- (id)initWithModel:(AERBSMBuilder *)bsm
{
self = [super initWithNibName:nil bundle:nil];
if (self) {
// Custom initialization
    
    _bsm = bsm;

}
return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.topLicenceData.text = self.bsm.licence;
    self.bottomLicenceData.text = self.bsm.licence;
    self.topFlightData.text = self.bsm.flightNumber;
    self.bottomFlightData.text = self.bsm.flightNumber;
    self.toFlightData.text = self.bsm.flightNumber;
    self.icaoData.text = self.bsm.icao;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
