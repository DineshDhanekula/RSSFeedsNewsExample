//
//  NewsDetailsViewController.m
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "NewsListTableViewCell.h"
@interface NewsDetailsViewController ()

@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [headerImageView setImageURL:[NSURL URLWithString:_newsDetailsObj.imageUrl]];
    self.title = @"News Detail";
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListTableViewCell *cell
    = [tableView dequeueReusableCellWithIdentifier:@"NewsListTableViewCell"
                                      forIndexPath:indexPath];
    
   
    [cell fillCellWithNewsObject:_newsDetailsObj];
    [cell.linkButton addTarget:self action:@selector(moveToWebView) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


-(void)moveToWebView{
    
    NSString* escapedUrlString =
    [_newsDetailsObj.newsWebLink stringByAddingPercentEscapesUsingEncoding:
     NSUTF8StringEncoding];    NSURL *url = [NSURL URLWithString:escapedUrlString];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    newDetailsTableView.estimatedRowHeight = 65.0;
    newDetailsTableView.rowHeight = UITableViewAutomaticDimension;
    initialFrame = headerImageView.frame;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
