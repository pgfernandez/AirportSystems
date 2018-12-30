

#import "AERMenuViewController.h"
#import "AERMenu.h"


@interface AERMenuViewController ()
@property (nonatomic, strong) AERMenu *model;
@end

@implementation AERMenuViewController

-(id) initWithModel:(AERMenu *) model
              style:(UITableViewStyle) style{
    
    if (self = [super initWithStyle:style]) {
        _model = model;
        self.title = @"Departure Control System";
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.82 green:0.88 blue:0.89 alpha:1.0];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    NSLog(@"entro en numero de secciones %i", 1);
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
        NSLog(@"entro en numero de filas %i", 1);
    
    return self.model.menuItemsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"En CREANDO CELDAS");
    
    // Averiguo qué personaej es
    NSString *item;
    
    item = [self.model menuItemAtIndex:indexPath.row];
    
    // Creo una celda
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    

    
    if (cell == nil) {
        // La tengo que crear yo
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];

//        cell.backgroundColor = [UIColor grayColor];

        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font =[UIFont boldSystemFontOfSize:20.0];
        cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.0];


        
    }
    // la configuro: sincronizo vista y modelo
//    cell.imageView.image = character.photo;
    cell.textLabel.text = [item description];
//    cell.detailTextLabel.text = [item description];
    
    
    // la devuelvo
    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *item = nil;
    
        item =[self.model menuItemAtIndex:indexPath.row];
    
    
    
    if ([self.delegate conformsToProtocol:@protocol(AERMenuViewControllerDelegate)]) {
        [self.delegate didSelectMenuItem:item];
    }
    
  
    
}

-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _model.menuItemsCount - 1;
    float val = ((float)index / (float)itemCount) * 0.40;
   
   // return [UIColor colorWithRed:0.00 green:0.443 blue:0.55 alpha:0.7];
    return [UIColor colorWithRed:0.0035 green:val blue:0.60 alpha:1.0];

}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}


@end
