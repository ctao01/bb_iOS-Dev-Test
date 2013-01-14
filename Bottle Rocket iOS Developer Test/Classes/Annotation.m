//
//  Annotation.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/13/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate;
@synthesize annotationTitle;
@synthesize annotationSubtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)location
                 title:(NSString *)title
           andSubtitle:(NSString *)subtitle {
    
    self = [super init];
    
    if (self) {
        
        annotationCoordinate = location;
        
        [self setAnnotationTitle:title];
        [self setAnnotationSubtitle:subtitle];
        
    }
    
    return self;
}

- (NSString *)subtitle{
    return annotationSubtitle;
}

- (NSString *)title{
    return annotationTitle;
}

- (CLLocationCoordinate2D)coordinate{
    return annotationCoordinate;
    
}
- (void)dealloc {
    
    [annotationTitle release];
    [annotationSubtitle release];
    [super dealloc];
}
@end
