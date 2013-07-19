//
//  RestaurantPosition.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface RestaurantLocation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D position;
    NSString *name;
}

@property (nonatomic) CLLocationCoordinate2D position;
@property (strong, nonatomic) NSString *name;

- (id) initWithPosition:(CLLocationCoordinate2D)position andName:(NSString*)name;

@end
