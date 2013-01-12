//
//  Tab1TableViewController.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/11/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "Tab1TableViewController.h"

#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

#import "CustomTableViewCell.h"

@interface Tab1TableViewController ()
@property (nonatomic ,retain) NSArray * collections;

@end

@implementation Tab1TableViewController
@synthesize collections = _collections;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSURL * url = [NSURL URLWithString:@"http://strong-earth-32.heroku.com/stores.aspx"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
     {
         if ([data length] >0 && error == nil)
         {
             id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             if (error == nil)
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.collections = [[NSMutableArray alloc]initWithArray:[result objectForKey:@"stores"]];
                 [self.tableView reloadData];
             });
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
     }];

}

- (void) dealloc
{
    [self.collections release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (UIImage *) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return [self.collections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = (CustomTableViewCell*)[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.phoneLabel.text = [[self.collections objectAtIndex:indexPath.row] objectForKey:@"phone"];
    cell.addressLabel.text = [[self.collections objectAtIndex:indexPath.row] objectForKey:@"address"];
    NSURL * url = [NSURL URLWithString:[[self.collections objectAtIndex:indexPath.row] objectForKey:@"storeLogoURL"]];
    if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
    {
        [cell.logoImageView setImageWithURL:url
                              placeholderImage:nil];
        UIImage * resizedImage = [self imageWithImage:cell.logoImageView.image scaledToSize:CGSizeMake(80.0f, 48.0f)];
        [cell.logoImageView setImage:resizedImage];
        [cell.logoImageView setNeedsDisplay];
    }
    else {
        [cell.logoImageView setImageWithURL:url
                              placeholderImage:nil
                                       options:SDWebImageLazyLoad];
        UIImage * resizedImage = [self imageWithImage:nil scaledToSize:CGSizeMake(80.0f, 48.0f)];
        [cell.logoImageView setImage:resizedImage];
        [cell.logoImageView setNeedsDisplay];
    }
    
    return cell;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark Table cell image support

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.collections count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            CustomTableViewCell *cell = (CustomTableViewCell*) [[self tableView] cellForRowAtIndexPath:indexPath];
            [cell.logoImageView startDownloadWithOptions:SDWebImageLazyLoad];
            
            UIImage * resizedImage = [self imageWithImage:cell.logoImageView.image scaledToSize:CGSizeMake(80.0f, 48.0f)];
            [cell.logoImageView setImage:resizedImage];
            [cell.logoImageView setNeedsDisplay];
            
        }
    }
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


@end
