//
//  ListViewController.m
//  AFNetworkigTest
//
//  Created by Mac on 9/2/15.
//  Copyright (c) 2015 Mac. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "RequestHandler.h"
#import "DetailViewController.h"


//Custom cell
static NSString * const reuseIdentifier = @"listCell";


@interface ListViewController ()  <UITableViewDataSource, UITableViewDelegate>

@end


@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set the title and buttons in navigation bar
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Table view
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    self.view.frame.size.width,
                                                                    self.view.frame.size.height-50)
                                                   style:UITableViewStyleGrouped];
    
    [tv registerClass:[ListTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    tv.dataSource = self;
    tv.delegate   = self;
    [self.view addSubview:tv];
    
    
    //Set Tool bar
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                                self.view.frame.size.height - 55,
                                                                self.view.frame.size.width,
                                                                55)];
    tb.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *jsonButton = [[UIBarButtonItem alloc] initWithTitle:@"JSON" style:UIBarButtonItemStylePlain target:self action:@selector(useJSON)];

    UIBarButtonItem *xmlButton  = [[UIBarButtonItem alloc] initWithTitle:@"XML" style:UIBarButtonItemStylePlain target:self action:@selector(useXML)];
    
    UIBarButtonItem *plistButton= [[UIBarButtonItem alloc] initWithTitle:@"PLIST" style:UIBarButtonItemStylePlain target:self action:@selector(usePLIST)];
    
    NSArray *buttonsArray = [NSArray arrayWithObjects:jsonButton, xmlButton, plistButton, nil];
    [tb setItems:buttonsArray];
    [self.view addSubview:tb];

}

#pragma mark - Button Actions
-(void)useJSON
{
    
}

-(void)useXML
{
    
}

-(void)usePLIST
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
         cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
     cell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.row + 1];
    
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
