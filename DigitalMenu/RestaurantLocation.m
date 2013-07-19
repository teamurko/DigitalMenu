//
//  RestaurantPosition.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "Debug.h"
#import "RestaurantLocation.h"

@implementation RestaurantLocation
@synthesize name = _name;
@synthesize position = _position;

- (id) initWithPosition:(CLLocationCoordinate2D)position andName :(NSString *)name
{
    self = [super init];
    if (self) {
        self.position = position;
        self.name = name;
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate
{
    return self.position;
}

- (NSString*) title
{
    return self.name;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
