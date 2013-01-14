//
//  Annotation.h
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/13/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D  annotationCoordinate;
    NSString                *annotationTitle;
    NSString                *annotationSubtitle;
}

- (id)initWithLocation:(CLLocationCoordinate2D)location
                 title:(NSString *)title
           andSubtitle:(NSString *)subtitle;

@property (nonatomic, copy) NSString *annotationTitle;
@property (nonatomic, copy) NSString *annotationSubtitle;

@end
