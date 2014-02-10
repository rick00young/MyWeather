//
//  RearTableViewController.m
//  RevealControllerProject3
//
//  Created by Joan on 30/12/12.
//
//

#import "RearTableViewController.h"

#import "SWRevealViewController.h"
#import "FrontTableViewController.h"
#include "City.h"

//#import "FrontViewControllerImage.h"
//#import "FrontViewControllerLabel.h"


@implementation RearTableViewController
{
    NSInteger _previouslySelectedRow;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
        self.clearsSelectionOnViewWillAppear = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWRevealViewController *revealController = self.revealViewController;
    SWRevealViewController *grandParentRevealController = revealController.revealViewController;
    
    [self.view addGestureRecognizer:grandParentRevealController.panGestureRecognizer];
    
    
    
   // self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    
    //[_button addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    NSLog( @"%@: %d", NSStringFromSelector(_cmd), animated);
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//
//    NSLog( @"%@: %d", NSStringFromSelector(_cmd), animated);
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//
//    NSLog( @"%@: %d", NSStringFromSelector(_cmd), animated);
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//
//    NSLog( @"%@: %d", NSStringFromSelector(_cmd), animated);
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    _previouslySelectedRow = -1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 6;
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    

    
    City *city = self.cities[indexPath.row];
   
    cell.textLabel.text = city.cityName;
    return cell;
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
    
    
    FrontTableViewController *frontController = nil;

    frontController =  [[FrontTableViewController alloc] init];
    
    frontController.city = self.cities[indexPath.row];
    
    [revealController setFrontViewController:frontController animated:YES];
}

@end
