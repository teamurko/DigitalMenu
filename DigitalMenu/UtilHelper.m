//
//  ImageHelper.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 29.08.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "UtilHelper.h"

#import <QuartzCore/QuartzCore.h>

@implementation UtilHelper

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (NSString*)renderedWorkHours:(NSInteger)secondsFrom andTill:(NSInteger) secondsTill
{
    int minutesFrom = secondsFrom / 60;
    int hoursFrom = minutesFrom / 60;
    int minutesTill = secondsTill / 60;
    int hoursTill = minutesTill / 60;
    
    return [NSString stringWithFormat:@"%02d:%02d - %02d:%02d",
            hoursFrom % 24,
            minutesFrom % 60,
            hoursTill % 24,
            minutesTill % 60];
}

+ (UIColor*) mainGreenColor
{
    return [[UIColor alloc] initWithRed:119.0/255 green:178.0/255 blue:43.0/255 alpha:1];
}

+ (NSString*) renderedDistanceKm:(double)meters
{
    return [NSString stringWithFormat:@"%.1f km", meters / 1000.0];
}

//meters
+ (double) approximateDistance:(CLLocation*) from andTo:(CLLocation*) to
{
    double dy = from.coordinate.latitude - to.coordinate.latitude;
    double dx = from.coordinate.longitude - to.coordinate.longitude;
    double dist = sqrt(dy * dy + dx * dx);
    return dist * 10000.0;
}

+ (UIView*) buttonView:(id)object andImage:(UIImage *)image andActImage:(UIImage*)actImage andAction:(SEL)action offsetTop:(CGFloat)top offsetBottom:(CGFloat)bottom offsetRight:(CGFloat)right offsetLeft:(CGFloat)left
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:actImage forState:UIControlStateSelected];
    button.frame= CGRectMake(left, top, image.size.width, image.size.height);
    button.layer.borderWidth = 1;
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, image.size.height, image.size.width, 10)];
//    label.text = @"Order";
//    [label setFont:[UIFont systemFontOfSize:10]];
//    [button addSubview:label];
    
    [button addTarget:object action:action forControlEvents:UIControlEventTouchUpInside];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width + left + right, image.size.height + top + bottom)];
    
    [view addSubview:button];
    
    return view;
}

+ (UIImage*) imageFromColor:(UIColor*)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor*) orangeNormal
{
    return [UIColor colorWithRed:251.0/255 green:199.0/255 blue:43.0/255 alpha:1.0];
}

+ (UIColor*) orangeSelected
{
    return [UIColor colorWithRed:252.0/255 green:172.0/255 blue:0.0/255 alpha:1.0];   
}

@end
