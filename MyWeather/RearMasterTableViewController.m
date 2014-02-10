//
//  RearMasterTableViewController.m
//  RevealControllerProject3
//
//  Created by Joan on 30/12/12.
//
//

#import "RearMasterTableViewController.h"

#import "SWRevealViewController.h"

//#import "FrontViewControllerImage.h"
//#import "FrontViewControllerLabel.h"
#import "FrontTableViewController.h"
#import "RearTableViewController.h"
#import "WXManager.h"
#import "City.h"
#import "Province.h"


@implementation RearMasterTableViewController
{
    NSInteger _previouslySelectedRow;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    self.provinces = [[WXManager sharedManager] getProvinces];
    //NSLog(@"cities = %@",self.cities);
}

- (void)viewWillAppear:(BOOL)animated
{
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    _previouslySelectedRow = -1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 6;
    return [self.provinces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Province *province = (Province *)[self.provinces objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    
    cell.textLabel.text = province.provinceName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = self.tableView.backgroundColor;

}

#pragma mark - Table view delegate





- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    SWRevealViewController *revealController = self.revealViewController;
    
    NSInteger row = indexPath.row;
    
    if ( row == _previouslySelectedRow )
    {
        [revealController revealToggleAnimated:YES];
        return;
    }
    
    _previouslySelectedRow = row;
    

    UIViewController *frontController = nil;

    RearTableViewController *rearViewController = [[RearTableViewController alloc] init];
    FrontTableViewController *frontViewController = [[FrontTableViewController alloc] init];
    //[frontViewController setImage:[UIImage imageNamed:@"bg_flowers.jpg"]];
    Province *province = [self.provinces objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    rearViewController.cities = province.cities;
    
    //NSLog(@"province.cities = %@", province.cities);
            
    SWRevealViewController *childRevealController =
    [[SWRevealViewController alloc] initWithRearViewController:rearViewController frontViewController:frontViewController];
            
            
    childRevealController.rearViewRevealWidth = 100;
    childRevealController.rearViewRevealDisplacement = 0;
    [childRevealController setFrontViewPosition:FrontViewPositionRight animated:YES];
    frontController = childRevealController;
    
 
    
    //if ( row != 5 )
    //{
        //[revealController setFrontViewController:frontController animated:NO];
        //[revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
    //}
    //else
    //{
        [revealController setFrontViewController:frontController animated:NO];
        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
    //}

}

@end
