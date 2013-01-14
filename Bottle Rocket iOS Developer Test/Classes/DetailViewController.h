//
//  DetailViewController.h
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/13/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailViewController : UITableViewController < MKMapViewDelegate >

@property (nonatomic , retain) NSDictionary * selectedObject;
@end
