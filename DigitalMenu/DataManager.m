//
//  DataManager.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 20.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DataManager.h"
#import "Json/SBJsonParser.h"
#import "Debug.h"

static NSMutableDictionary* dataDict_ = nil;

@implementation DataManager

const NSString *SERVER = @"http://ec2-54-229-72-121.eu-west-1.compute.amazonaws.com:8080";
const NSString *URL = @"/serverServices";

+(void) load
{
    debug();
    return;
    if (dataDict_) {
        return;
    }
    NSString *string_url = [NSString stringWithFormat:@"%@/serverServices/restaurants/all", SERVER];
    NSURL *url = [[NSURL alloc] initWithString:string_url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *rests = [[parser objectWithString:data] objectForKey:@"restaurant"];
    NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];

    for (NSDictionary *rest in rests) {
        NSString *key = [rest objectForKey:@"id"];
        [tempData setValue:rest forKey:key];
    }
    dataDict_ = tempData;
}

+(NSString*) requestData:(NSString*) url
{
    debug();
    NSLog(@"%@", url);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:url]
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:5];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    return[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}

+(NSArray*) restaurantsByLocation:(CLLocation*)location
{
    debug();
    NSString *url = [NSString stringWithFormat:@"%@%@/find?longitude=%f&latitude=%f",
                            SERVER, URL, location.coordinate.longitude, location.coordinate.latitude];
    NSString *data = [self requestData:url];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *result = [[parser objectWithString:data] objectForKey:@"restaurant"];
    return result;
}

+(NSArray*) cuisinesByRestaurantId:(NSInteger)restaurantId
{
    debug();
    NSString *url = [NSString stringWithFormat:@"%@%@/restaurants/%d/", SERVER, URL, restaurantId];
    NSString *data = [self requestData:url];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *result = [parser objectWithString:data];
    return [result objectForKey:@"cuisine"];
}

+(NSArray*) restaurants
{
    debug();
    NSString *url = [NSString stringWithFormat:@"%@%@/restaurants/all", SERVER, URL];
    NSString *data = [self requestData:url];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *result = [parser objectWithString:data];
    return [result objectForKey:@"restaurant"];
}

+(NSDictionary*) restaurantById:(NSInteger)restaurantId
{
    debug();
    for (NSDictionary *dict in [DataManager restaurants]) {
        if ([[dict objectForKey:@"id"] intValue] == restaurantId) {
            return dict;
        }
    }
    return nil;
}

+(CLLocation*) restaurantLocation:(NSInteger) restaurantId
{
    debug();
    NSDictionary *restaurant = [DataManager restaurantById:restaurantId];
    double lat = [[restaurant objectForKey:@"latitude"] doubleValue];
    double lon = [[restaurant objectForKey:@"longitude"] doubleValue];
    NSLog(@"%f %f", lon, lat);
    return [[CLLocation alloc] initWithLatitude:lat longitude:lon];
}

+(NSArray*) dishCategoriesByCuisineId:(NSInteger)cuisineId
{
    debug();
    NSString *url = [NSString stringWithFormat:@"%@%@/cuisines/%d", SERVER, URL, cuisineId];
    NSString *data = [self requestData:url];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *result = [parser objectWithString:data];
    return [result objectForKey:@"dish_type"];
}

+(NSArray*) dishesByCategoryId:(NSInteger)categoryId
{
    debug();
    NSString *url = [NSString stringWithFormat:@"%@%@/dishTypes/%d", SERVER, URL, categoryId];
    NSString *data = [self requestData:url];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *result = [parser objectWithString:data];
    return [result objectForKey:@"dish"];
}

+(NSDictionary*) dishById:(NSInteger)dishId
{
    debug();
    NSString *url = [NSString stringWithFormat:@"%@%@/dishes/%d", SERVER, URL, dishId];
    NSString *data = [self requestData:url];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *result = [parser objectWithString:data];
    return [result objectForKey:@"dish"];
}

@end
