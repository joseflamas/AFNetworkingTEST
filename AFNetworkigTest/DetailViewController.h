//
//  DetailViewController.h
//  AFNetworkigTest
//
//  Created by Mac on 9/2/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface DetailViewController : UIViewController


@property (nonatomic, strong) Weather *dayWeather;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end
