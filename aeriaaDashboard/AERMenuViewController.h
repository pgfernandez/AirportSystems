//
//  AGTUniverseViewController.h
//  StarWars
//
//  Created by Fernando Rodríguez Romero on 10/05/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AERMenu.h"


@class AERMenuViewController;

@protocol AERMenuViewControllerDelegate <NSObject>

- (void) didSelectMenuItem:(NSString*)menuItem;


@end

@interface AERMenuViewController : UITableViewController

@property (weak, nonatomic) id<AERMenuViewControllerDelegate>delegate;
//@property (strong, nonatomic) AERMenu *menu;

-(id) initWithModel:(AERMenu *) model
              style:(UITableViewStyle) style;

@end






