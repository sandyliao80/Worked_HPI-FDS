//
//  ChooseView.m
//  Hpi-FDS
//
//  Created by zcx on 12-3-30.
//  Copyright (c) 2012年 Landscape. All rights reserved.
//  

#import "ChooseView.h"
#import "MapViewController.h"
#import "PubInfo.h"
@implementation ChooseView
@synthesize tableView,iDArray,popover;
@synthesize parentMapView,type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [tableView release];
    [iDArray release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableView.allowsSelection=YES;  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - tableView
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.iDArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MapViewController *mapView=(MapViewController*) self.parentMapView;
    if(self.type==kPORT)
    {
        mapView.choosePort=[self.iDArray objectAtIndex:[indexPath row]];
    }
    else if(self.type==kFACTORY)
    {
        mapView.chooseFactory=[self.iDArray objectAtIndex:[indexPath row]];
    }
    else
    {
        mapView.chooseShip=[self.iDArray objectAtIndex:[indexPath row]];
    }
    [mapView chooseUpdateView];
    [self.popover dismissPopoverAnimated:YES];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text=[iDArray objectAtIndex:[indexPath row]];
    cell.textLabel.textColor =[UIColor colorWithRed:255.0/255.0 green:203.0/255.0 blue:5.0/255.0 alpha:1];
    return cell;
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { 
    return 44.0;
} 


@end
