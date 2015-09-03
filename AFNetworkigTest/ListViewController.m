//
//  ListViewController.m
//  AFNetworkigTest
//
//  Created by Mac on 9/2/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "DetailViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Weather.h"


//Example URL
static NSString * const JSONURLString   = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json";
//static NSString * const XMLURLString    = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=xml";
//static NSString * const PLISTURLString  = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=plist";

//Custom cell
static NSString * const reuseIdentifier = @"listCell";


@interface ListViewController ()  <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tv;
@property (nonatomic, strong) NSDictionary   *weather;
@property (nonatomic, strong) NSMutableArray *weekWeather;

@end


@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationControllerButtons];
    
    [self setTableViewandCustomCell];
    
    [self setCustomToolBar];
    
}

#pragma mark - Set UI
-(void)setNavigationControllerButtons
{

    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearList)];
    self.navigationItem.leftBarButtonItem = clearButton;
    
    
//    UIBarButtonItem *apiButton  = [[UIBarButtonItem alloc] initWithTitle:@"API" style:UIBarButtonItemStylePlain target:self action:@selector(setApi)];
//    self.navigationItem.rightBarButtonItem= apiButton;
    
}

-(void)setTableViewandCustomCell
{
    //Table view
    self.tv = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            self.view.frame.size.width,
                                                            self.view.frame.size.height-50)
                                           style:UITableViewStyleGrouped];
    
    [self.tv registerClass:[ListTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tv.dataSource = self;
    self.tv.delegate   = self;
    [self.view addSubview:self.tv];
}

-(void)setCustomToolBar
{
    //Set Tool bar
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                self.view.frame.size.height - 55,
                                                                self.view.frame.size.width,
                                                                55)];
    tb.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *jsonButton = [[UIBarButtonItem alloc] initWithTitle:@"JSON" style:UIBarButtonItemStylePlain target:self action:@selector(useJSON)];
    
//    UIBarButtonItem *xmlButton  = [[UIBarButtonItem alloc] initWithTitle:@"XML" style:UIBarButtonItemStylePlain target:self action:@selector(useXML)];
//    
//    UIBarButtonItem *plistButton= [[UIBarButtonItem alloc] initWithTitle:@"PLIST" style:UIBarButtonItemStylePlain target:self action:@selector(usePLIST)];
//    
//    UIBarButtonItem *flexSpace  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    
//    UIBarButtonItem *clientButton= [[UIBarButtonItem alloc] initWithTitle:@"Client" style:UIBarButtonItemStylePlain target:self action:@selector(clientMode)];
//    
//    NSArray *buttonsArray = [NSArray arrayWithObjects:jsonButton, xmlButton, plistButton, flexSpace, clientButton, nil];
    
    NSArray *buttonsArray = [NSArray arrayWithObjects:jsonButton, nil];
    
    [tb setItems:buttonsArray];
    [self.view addSubview:tb];
}


#pragma mark - Button Actions
-(void)clearList
{
    self.title = @"";
    self.weekWeather = nil;
    [self.tv reloadData];
}

-(void)setApi
{
    
}

-(void)useJSON
{
    //prepare url
    NSURL *url            = [NSURL URLWithString:JSONURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         self.weather           = (NSDictionary *)responseObject;
         NSDictionary *dataDict = self.weather[@"data"];
         NSArray      *week     = dataDict[@"weather"];
         self.weekWeather       = [NSMutableArray new];
         
         for(NSDictionary *dia in week)
         {
             Weather *wd = [Weather new];
             
             wd.date                = dia[@"date"];
             wd.precipMM            = dia[@"precipMM"];
             wd.tempMaxC            = dia[@"tempMaxC"];
             wd.tempMaxF            = dia[@"tempMaxF"];
             wd.tempMinC            = dia[@"tempMinC"];
             wd.tempMinF            = dia[@"tempMinF"];
             wd.weatherCode         = dia[@"weatherCode"];
             NSArray *dd            = dia[@"weatherDesc"];
             NSDictionary *ddd      = dd[0];
             wd.weatherDescription  = ddd[@"value"];
             NSArray *ii            = dia[@"weatherIconUrl"];
             NSDictionary *iii      = ii[0];
             wd.weatherIconURL      = iii[@"value"];
             wd.windDir16Point      = dia[@"winddir16Point"];
             wd.windDirDegree       = dia[@"winddirDegree"];
             wd.windSpeedKmph       = dia[@"windspeedKmph"];
             wd.windSpeedMiles      = dia[@"windspeedMiles"];
             
             [self.weekWeather addObject:wd];
         }
         
         self.title = @"Week Weather";
         [self.tv reloadData];
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                             message:[error localizedDescription]
                                                            delegate:self
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
         
     }];
    
    [operation start];
}

-(void)useXML
{
    
}

-(void)usePLIST
{
    
}

-(void)clientMode
{
    
}


#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weekWeather count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    Weather *w = [Weather new];
    w = self.weekWeather[indexPath.row];
    
    cell.textLabel.text = w.weatherDescription;
    
    NSURL *url = [NSURL URLWithString:w.weatherIconURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    __weak UITableViewCell *weakCell = cell;
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    
    return cell;
}


#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc]init];
    
    
    [self.navigationController pushViewController:dvc animated:YES];
}


@end
