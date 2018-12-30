//
//  AERMenu.h
//  StarWars
//
//  Created by Pedro Garcia Fernandez on 13/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AERMenu : NSObject

@property (strong, nonatomic) NSArray *menuOptions;
@property (readonly, nonatomic) NSUInteger menuCount;

-(NSString *) menuItemAtIndex:(NSUInteger) index;
-(NSUInteger) menuItemsCount;

@end
