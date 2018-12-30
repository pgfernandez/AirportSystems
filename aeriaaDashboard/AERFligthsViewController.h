//
//  AERFligthsViewController.h
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 12/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AERScheduledFlights.h"



@interface AERFligthsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *flightsTable;
@property (strong, nonatomic) AERScheduledFlights *flights;


/*@class AERFligthsViewController;

@protocol AERFlightsViewControllerDelegate <NSObject>

- (void) didSelectCharacter:(AERFlight*)flight;


@end



@interface AERFligthsViewController : UITableViewController


@property (weak, nonatomic) id<AERFlightsViewControllerDelegate>delegate;

//@property (weak, nonatomic) IBOutlet UITableView *flightsTable;
//@property (strong, nonatomic) AERScheduledFlights *flights;

-(id) initWithModel:(AERScheduledFlights *) flights
style:(UITableViewStyle) style;*/


@end
