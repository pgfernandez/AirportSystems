//
//  AERPreCheckViewController.m
//  aeriaaDashboard
//
//  Created by Pedro Garcia Fernandez on 25/4/15.
//  Copyright (c) 2015 aeriaa. All rights reserved.
//

#import "AERPreCheckViewController.h"
#import "Settings.h"

@interface AERPreCheckViewController (){

NSMutableArray *preCheckPaxs;
NSDictionary *dictionary;

    // Define keys
NSString *flightNumber;
NSString *destination;
NSString *std;
NSString *name;
NSString *surname;
NSString *resNumber;
NSString *paxLocalization;
NSString *dateLocalization;
    
}

@end

@implementation AERPreCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    flightNumber = @"Flight";
    destination = @"Destination";
    std = @"STD";
    name = @"Name";
    surname = @"Surname";
    paxLocalization = @"location";
    resNumber = @"resNumber";
    dateLocalization = @"date";
    
       preCheckPaxs = [[NSMutableArray alloc]init];
   
    NSMutableString *url = [[NSMutableString alloc] initWithString: @"http://"];
    [url appendString:@LOCAL_IP];
    [url appendString:@":8183/dcs/PreCheckPax"];

    

      //  NSString *url = [[NSString alloc]initWithFormat:@"http://192.168.1.35:8183/dcs/PreCheckPax"];
        
        NSLog(@"Antes de llamar al web service");
        
        NSData *jsonSource = [NSData dataWithContentsOfURL:
                              [NSURL URLWithString:url]];
        
        NSLog(@"Después de llamar al web service");
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                          jsonSource options:NSJSONReadingMutableContainers error:nil];
    
        
        for (NSDictionary *dataDict in jsonObjects) {
            
            NSString *flight_Number = [dataDict objectForKey:@"Flight"];
            NSString *pax_name = [dataDict objectForKey:@"Name"];
            NSString *pax_surname = [dataDict objectForKey:@"Surname"];
            NSString *pax_destination = [dataDict objectForKey:@"Destination"];
            NSString *pax_std = [dataDict objectForKey:@"STD"];
            NSString *pax_resNumber = [dataDict objectForKey:@"resNumber"];
            NSString *pax_Localization = [dataDict objectForKey:@"location"];
            NSString *pax_dateLocalization = [dataDict objectForKey:@"date"];
            
            dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                          flight_Number, flightNumber,
                          pax_name, name,
                          pax_surname,surname,
                          pax_resNumber,resNumber,
                          pax_std, std,
                          pax_destination, destination,
                          pax_Localization, paxLocalization,
                          pax_dateLocalization, dateLocalization,
                          nil];
            
            [preCheckPaxs addObject:dictionary];
            
        }
    
            
         self.paxPreCheckedTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
    return preCheckPaxs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    
    // Creo una celda
    static NSString *cellId = @"cellId";
    
    NSDictionary *tmpDict = [preCheckPaxs objectAtIndex:indexPath.row];
    
    NSMutableString *flight_tmp;
    flight_tmp = [NSMutableString stringWithFormat:@"%@",
                  [tmpDict objectForKeyedSubscript:flightNumber]];
    
    NSMutableString *std_tmp;
    std_tmp = [NSMutableString stringWithFormat:@"%@",
               [tmpDict objectForKeyedSubscript:std]];
    
    NSMutableString *destination_tmp;
    destination_tmp = [NSMutableString stringWithFormat:@"%@",
                       [tmpDict objectForKeyedSubscript:destination]];
    
    NSMutableString *name_tmp;
    name_tmp = [NSMutableString stringWithFormat:@"%@",
                [tmpDict objectForKeyedSubscript:name]];
    
    NSMutableString *surname_tmp;
    surname_tmp = [NSMutableString stringWithFormat:@"%@",
                [tmpDict objectForKeyedSubscript:surname]];

    NSMutableString *reservation_tmp;
    reservation_tmp = [NSMutableString stringWithFormat:@"%@",
                   [tmpDict objectForKeyedSubscript:resNumber]];
    
    NSMutableString *location_tmp;
    location_tmp = [NSMutableString stringWithFormat:@"%@",
                       [tmpDict objectForKeyedSubscript:paxLocalization]];
    

    
    
    NSMutableString *datelocation_tmp;
    datelocation_tmp = [NSMutableString stringWithFormat:@"%@",
                    [tmpDict objectForKeyedSubscript:dateLocalization]];
    NSRange dateRange = NSMakeRange(11, 8);
    NSString *hour = [datelocation_tmp substringWithRange:dateRange];
    
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
    [flightData appendString:@" "];
    [flightData appendString:reservation_tmp];
 
    
    NSMutableString *flightDetailData = [[NSMutableString alloc]init];
    [flightDetailData appendString:destination_tmp];
    [flightDetailData appendString:@" "];
    [flightDetailData appendString:surname_tmp];
    [flightDetailData appendString:@"/"];
    [flightDetailData appendString:name_tmp];
    [flightDetailData appendString:@" Pax at:"];
    [flightDetailData appendString:location_tmp];
    [flightDetailData appendString:@" "];
    [flightDetailData appendString:hour];

    cell.textLabel.text = flightData;
    cell.detailTextLabel.text = flightDetailData;
    cell.imageView.image = airlineLogo;
    
    
    return cell;
    
}




#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}



@end
