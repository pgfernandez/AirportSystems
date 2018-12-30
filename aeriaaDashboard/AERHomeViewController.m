//
//  AERHomeViewController.m
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 12/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERHomeViewController.h"
#import "AERFligthsViewController.h"
#import "AERCheckViewController.h"
#import "AERPreCheckViewController.h"
#import "AERScheduledFlights.h"


@interface AERHomeViewController ()

@end

@implementation AERHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

#pragma mark - Split

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    
    NSLog(@"willHideViewController");
    
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    
    NSLog(@"willShowViewController");
    
}

-(void) didSelectMenuItem:(NSString *) menuItem{
    
    NSLog(@"He pulsado sobre el menu la opción %@", [menuItem description]);
    
    if ([menuItem.description  isEqual: @"LIST FLIGHTS"]){
    
   /* NSDate *now = [NSDate date];
    AERScheduledFlights *flights = [[AERScheduledFlights alloc]initWithScheduledDate:now];*/
    
    AERFligthsViewController *flightsView = [[AERFligthsViewController alloc]init];

//WithModel:flights style:UITableViewStylePlain];
    
    // Hacer el push
    [self.navigationController pushViewController:flightsView
                                         animated:YES];
        
    }else if([menuItem.description  isEqual: @"CHECK PAX"]){
     
        AERCheckViewController *checkView = [[AERCheckViewController alloc]initWithNibName:nil bundle:nil];
        
        // Hacer el push
        [self.navigationController pushViewController:checkView
                                             animated:YES];
        
    }else if([menuItem.description  isEqual: @"PRECHECK PAX"]){
        
        AERPreCheckViewController  *preCheckView = [[AERPreCheckViewController alloc]initWithNibName:nil bundle:nil];
        
        // Hacer el push
        [self.navigationController pushViewController:preCheckView
                                             animated:YES];
    }
    
    //ya haremos algo
}


@end
