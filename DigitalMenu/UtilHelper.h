//
//  ImageHelper.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 29.08.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface UtilHelper : NSObject

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (NSString*)renderedWorkHours:(NSInteger)secondsFrom andTill:(NSInteger) secondsTill;
+ (NSString*) renderedDistanceKm:(double)meters;
+ (double) approximateDistance:(CLLocation*) from andTo:(CLLocation*) to;
+ (UIColor*) mainGreenColor;
+ (UIView*) buttonView:(id) object andImage:(UIImage*)image andActImage:(UIImage*)actImage andAction:(SEL)action offsetTop:(CGFloat)top offsetBottom:(CGFloat)bottom offsetRight:(CGFloat)right offsetLeft:(CGFloat)left;
+ (UIImage*) imageFromColor:(UIColor*)color andSize:(CGSize)size;
+ (UIColor*) orangeNormal;
+ (UIColor*) orangeSelected;
@end
