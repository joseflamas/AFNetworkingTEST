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


@end
