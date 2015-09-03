//
//  Weather.h
//  AFNetworkigTest
//
//  Created by Mac on 9/2/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject



@property (nonatomic,strong) NSNumber *cloudCover;
@property (nonatomic,strong) NSNumber *humidity;
@property (nonatomic,strong) NSDate   *observationTime;
@property (nonatomic,strong) NSNumber *precipMM;
@property (nonatomic,strong) NSNumber *pressure;
@property (nonatomic,strong) NSNumber *tempC;
@property (nonatomic,strong) NSNumber *tempF;
@property (nonatomic,strong) NSNumber *visibility;
@property (nonatomic,strong) NSNumber *weatherCode;
@property (nonatomic,strong) NSString *windDir16Point;
@property (nonatomic,strong) NSNumber *windDirDegree;
@property (nonatomic,strong) NSNumber *windSpeedKmph;
@property (nonatomic,strong) NSNumber *windSpeedMiles;
@property (nonatomic,strong) NSString *weatherDescription;
@property (nonatomic,strong) NSString *weatherIconURL;
@property (nonatomic,strong) NSDate   *date;
@property (nonatomic,strong) NSNumber *tempMaxC;
@property (nonatomic,strong) NSNumber *tempMaxF;
@property (nonatomic,strong) NSNumber *tempMinC;
@property (nonatomic,strong) NSNumber *tempMinF;



@end
