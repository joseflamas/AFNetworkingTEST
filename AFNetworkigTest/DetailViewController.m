//
//  DetailViewController.m
//  AFNetworkigTest
//
//  Created by Mac on 9/2/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "DetailViewController.h"
#import "AFNetworking.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *title    = self.dayWeather.weatherDescription;
    NSNumber *tempMaxF = self.dayWeather.tempMaxF;
    NSNumber *tempMinF = self.dayWeather.tempMinF;
    NSString *tempRange= [NSString stringWithFormat:@"min:%d / max:%d",[tempMinF intValue],[tempMaxF intValue]];
    self.title = title;
    
    //Update Background
    UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithTitle:@"GET IMAGE" style:UIBarButtonItemStylePlain target:self action:@selector(updateBackground)];
    self.navigationItem.rightBarButtonItem = updateButton;
    
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.backgroundImageView.image = [UIImage imageNamed:@"back"];
    [self.view addSubview:self.backgroundImageView];
    
    
    //Label
    UILabel *rangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    rangeLabel.text = tempRange;
    [rangeLabel setTextAlignment:NSTextAlignmentCenter];
    [rangeLabel setBackgroundColor:[UIColor colorWithHue:255 saturation:255 brightness:255 alpha:0]];
    [rangeLabel setAdjustsFontSizeToFitWidth:YES];
    [rangeLabel setTextColor:[UIColor blackColor]];
    [rangeLabel setFont:[UIFont fontWithName:@"helvetica" size:100]];
    rangeLabel.layer.shadowColor =[[UIColor whiteColor ]CGColor ];
    rangeLabel.layer.shadowOffset=(CGSizeMake(0, 0));
    rangeLabel.layer.shadowOpacity=.5;
    rangeLabel.layer.shadowRadius=5.0;
    rangeLabel.layer.masksToBounds=NO;
    rangeLabel.shadowColor=[UIColor darkGrayColor];
    rangeLabel.shadowOffset=CGSizeMake(5, 5);
    [self.view addSubview:rangeLabel];
    
    
    //Set Tool bar
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                self.view.frame.size.height - 55,
                                                                self.view.frame.size.width,
                                                                55)];
    tb.backgroundColor = [UIColor blackColor];

    //Clear Background
    UIBarButtonItem *clearButton  = [[UIBarButtonItem alloc] initWithTitle:@"CLEAR" style:UIBarButtonItemStylePlain target:self action:@selector(clearBackground)];
    NSArray *buttonsArray = [NSArray arrayWithObjects:clearButton, nil];
    
    [tb setItems:buttonsArray];
    [self.view addSubview:tb];
    

}



-(void)updateBackground
{
    NSURL *url = [NSURL URLWithString:@"http://i.imwx.com/images/maps/current/acttemp_600x405.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.backgroundImageView.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
    
}

-(void)clearBackground
{
 self.backgroundImageView.image = nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
