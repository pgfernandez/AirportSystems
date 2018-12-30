//
//  AERFligthsViewController.m
//  AirlineDCS
//
//  Created by Pedro Garcia Fernandez on 12/05/14.
//  Copyright (c) 2014 aeriaa. All rights reserved.
//

#import "AERFligthsViewController.h"
#import "AERScheduledFlights.h"
#import "AERFlight.h"
#import "Settings.h"

@interface AERFligthsViewController (){

    NSMutableArray *flightsArray;
    // A dictionary object
    NSDictionary *dictionary;
    // Define keys
    NSString *flightCode;
    NSString *company;
    NSString *destination;
    NSString *std;
    NSString *gate;
}
@end

@implementation AERFligthsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSDate *now = [NSDate date];
        _flights = [[AERScheduledFlights alloc]initWithScheduledDate:now];
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    flightCode = @"Flight";
    company = @"ICAO";
    destination = @"Destination";
    std = @"STD";
    gate = @"Gate";
    
    flightsArray = [[NSMutableArray alloc]init];
    
    
    NSMutableString *url = [[NSMutableString alloc] initWithString: @"http://"];
    [url appendString:@LOCAL_IP];
    [url appendString:@":8181/departures"];
    
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                         [NSURL URLWithString:url]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *flight_data = [dataDict objectForKey:@"Flight"];
        NSString *company_data = [dataDict objectForKey:@"ICAO"];
        NSString *destination_data = [dataDict objectForKey:@"Destination"];
        NSString *std_data = [dataDict objectForKey:@"STD"];
        NSString *gate_data = [dataDict objectForKey:@"Gate"];
        
        
        
        NSLog(@"Flight Data: %@",flight_data);
        NSLog(@"ICAO: %@",company_data);
        NSLog(@"Destination: %@",destination_data);
        NSLog(@"STD: %@",std_data);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      flight_data, flightCode,
                      company_data, company,
                      destination_data,destination,
                      std_data, std,
                      gate_data, gate,
                      nil];
        
        [flightsArray addObject:dictionary];
        
       
        
    }
     self.flightsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    //NSLog(@"entro en numero de secciones %i", 1);
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"entro en numero de filas %i", 1);
    
    return flightsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"En CREANDO CELDAS");
    
    // Averiguo qué vuelo es
  /*  NSString *item;
    
    item = [self.model menuItemAtIndex:indexPath.row];
   */
    
   /* AERFlight *flight;
    
    flight = [self.flights flightAtIndex:indexPath.row];*/
    
    
    
    // Creo una celda
    static NSString *cellId = @"cellId";
    
    NSDictionary *tmpDict = [flightsArray objectAtIndex:indexPath.row];
    
    NSMutableString *flight_tmp;
    flight_tmp = [NSMutableString stringWithFormat:@"%@",
                             [tmpDict objectForKeyedSubscript:flightCode]];
    
    NSMutableString *std_tmp;
    std_tmp = [NSMutableString stringWithFormat:@"%@",
                  [tmpDict objectForKeyedSubscript:std]];
    
    NSMutableString *destination_tmp;
    destination_tmp = [NSMutableString stringWithFormat:@"%@",
                   [tmpDict objectForKeyedSubscript:destination]];
    
    NSMutableString *gate_tmp;
    gate_tmp = [NSMutableString stringWithFormat:@"%@",
                       [tmpDict objectForKeyedSubscript:gate]];

    
    NSRange logoRange = NSMakeRange(0, 3);

    NSString *airlineCode = [flight_tmp substringWithRange:logoRange];
    NSLog(@"Valor del código %@", airlineCode);
    NSMutableString *airlineLogoFile = [[NSMutableString alloc] init];
    
    [airlineLogoFile appendString:airlineCode];
    [airlineLogoFile appendString:@".png"];
    
    UIImage *airlineLogo = [UIImage imageNamed:airlineLogoFile];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellId];        
    }
    
    
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor whiteColor];
    }else {
        cell.backgroundColor = [UIColor colorWithRed:0.788 green:0.863 blue:0.91 alpha:1];
    }
    
    
    
    NSMutableString *flightData = [[NSMutableString alloc]init];
    [flightData appendString:flight_tmp];
    [flightData appendString:@" "];
    [flightData appendString:std_tmp];
    
    NSMutableString *flightDetailData = [[NSMutableString alloc]init];
    [flightDetailData appendString:destination_tmp];
    [flightDetailData appendString:@" "];
    [flightDetailData appendString:gate_tmp];
    

    cell.textLabel.text = flightData;
    cell.detailTextLabel.text = flightDetailData;
    cell.imageView.image = airlineLogo;


    return cell;
    
}




#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 /*
    NSString *item = nil;
    
    item =[self.model menuItemAtIndex:indexPath.row];
    
    if ([self.delegate conformsToProtocol:@protocol(AERMenuViewControllerDelegate)]) {
        [self.delegate didSelectMenuItem:item];
    }*/
    
    
    
}


@end
