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

NSArray *rests;
CLLocation *loc;

+(void) load:(CLLocation*) userLocation
{
    debug();
    if (!dataDict_) {
        dataDict_ = [[NSMutableDictionary alloc] init];
        for (NSObject* object in [DataManager restaurantsByLocation:userLocation]) {
            NSDictionary *restaurantData = (NSDictionary*)object;
            NSString *restaurantId = [NSString stringWithFormat:@"%@", [restaurantData objectForKey:@"id"]];
            [dataDict_ setObject:restaurantData forKey:restaurantId];
        }
    }
}

+(NSArray*) nearbyRestaurants
{
    [DataManager load];
    return [dataDict_ allValues];
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
    NSLog(@"%@", response);
    return[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
}

+(NSArray*) restaurantsByLocation:(CLLocation*)location
{
    debug();
    loc = location;
    NSString *url = [NSString stringWithFormat:@"%@%@/find?longitude=%f&latitude=%f",
                            SERVER, URL, location.coordinate.longitude, location.coordinate.latitude];
    NSString *data = [self requestData:url];
    NSLog(@"%@", data);
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *result = [[parser objectWithString:data] objectForKey:@"restaurant"];
    rests = result;
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


+(NSDictionary*) restaurantById:(NSInteger)restaurantId
{
    debug();
    if (!dataDict_) {
        [DataManager load];
    }
    NSLog(@"rest_id=%d", restaurantId);
    NSLog(@"%@", dataDict_);
    NSDictionary *rest = [dataDict_ objectForKey:[NSString stringWithFormat:@"%d", restaurantId]];
    NSLog(@"Rest = %@", rest);
    return rest;
}

+(CLLocation*) restaurantLocation:(NSInteger) restaurantId
{
    debug();
    NSDictionary *restaurant = [DataManager restaurantById:restaurantId];
    NSLog(@"%@", restaurant);
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
    NSLog(@"Dish categories for cuisine %d: %@", cuisineId, result);
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
