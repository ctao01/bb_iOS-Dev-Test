//
//  DetailViewController.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/13/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImage+Additons.h"
#import "Annotation.h"

#import <QuartzCore/QuartzCore.h>

@interface DetailViewController ()
{
    MKMapView * mapView;
}
-(UILabel*) makeLabelTextWithRow:(NSInteger)row;

@property (nonatomic , retain) UIImageView * headerImageView;
@end

@implementation DetailViewController
@synthesize selectedObject = _selectedObject;
@synthesize headerImageView;

- (void) setSelectedObject:(NSDictionary *)newObject
{
    if (_selectedObject == newObject) return;
    [_selectedObject release];
    _selectedObject = [newObject retain];
    
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_selectedObject objectForKey:@"storeLogoURL"]]]];
    UIImage * editedImag = [image imageByScalingProportionallyToSize:self.headerImageView.frame.size];
    [self.headerImageView setImage:editedImag];
    [self updateMap];
    
    [self.tableView reloadData];
}

- (void) updateMap
{
    CLLocationCoordinate2D pinCenter;
    pinCenter.latitude = [[self.selectedObject objectForKey:@"latitude"] doubleValue];
    pinCenter.longitude = [[self.selectedObject objectForKey:@"longitude"] doubleValue];
    
    MKCoordinateSpan mapSpan;
    mapSpan.latitudeDelta = 0.005;
    mapSpan.longitudeDelta = 0.005;
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = pinCenter;
    mapRegion.span = mapSpan;
    
    [mapView setRegion:mapRegion];
    [mapView regionThatFits:mapRegion];
    
    Annotation * annotation = [[Annotation alloc]initWithLocation:pinCenter title:[self.selectedObject objectForKey:@"name"] andSubtitle:[self.selectedObject objectForKey:@"phone"]];
    
    [mapView addAnnotation:annotation];
    [annotation release];
}
-(UILabel*) makeLabelTextWithRow:(NSInteger)row
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, 0.0f, 200.0f, 80.0f)];
    label.center = CGPointMake(label.center.x, 20.0f);
    label.backgroundColor = [UIColor clearColor];
    
    switch (row) {
        case 0:
            label.text = [self.selectedObject objectForKey:@"address"];
            break;
        case 1:
            label.text = [self.selectedObject objectForKey:@"city"];
            break;
        case 2:
            label.text = [self.selectedObject objectForKey:@"state"];
            break;
        case 3:
            label.text = [self.selectedObject objectForKey:@"zipcode"];
            break;
        case 4:
            label.text = [self.selectedObject objectForKey:@"phone"];
            break;
        case 5:
            label.text = [self.selectedObject objectForKey:@"storeID"];
            break;
        default:
            break;
    }
    return label;
    
    [label release];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 120.0f)];

        self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, headerView.frame.size.height)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.headerImageView.center = headerView.center;
        
        [headerView addSubview:self.headerImageView];
        self.tableView.tableHeaderView = headerView;
    
        UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 240.0f)];
        mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 240.0f, 240.0f)];
        mapView.delegate = self;
        mapView.zoomEnabled = YES;
        mapView.scrollEnabled = NO;
        mapView.mapType = MKMapTypeStandard;
        mapView.center = footerView.center;
        
        // Custom MapView
        
        mapView.layer.borderWidth = 5.0f;
        mapView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        mapView.layer.shadowColor = [[UIColor grayColor] CGColor];
        mapView.layer.shadowRadius = 6.0f;
        mapView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
        mapView.layer.shadowOpacity = 0.6f;

        [footerView addSubview:mapView];
        
        self.tableView.tableFooterView = footerView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 44.0f, 0.0f);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    self.headerImageView = nil; [self.headerImageView release];
}

- (void) dealloc
{
    self.selectedObject = nil; [self.selectedObject release];
    
    [mapView release];
    [super dealloc];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    UILabel * label = nil;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Address";

            break;
        case 1:
            cell.textLabel.text = @"City";

            break;
        case 2:
            cell.textLabel.text = @"State";

            break;
        case 3:
            cell.textLabel.text = @"ZipCode";

            break;
        case 4:
            cell.textLabel.text = @"Phone";

            break;
        case 5:
            cell.textLabel.text = @"StoreID";
        
            break;
        default:
            break;
    }
    label = [self makeLabelTextWithRow:indexPath.row];
    [cell addSubview:label];
    [label release];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - MKMapDelegate Method

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    MKPinAnnotationView * annotationView = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil]autorelease];
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    
    return annotationView;
    
}

@end
