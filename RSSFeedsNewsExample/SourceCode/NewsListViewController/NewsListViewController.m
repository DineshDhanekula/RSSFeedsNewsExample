//
//  NewsListViewController.m
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import "NewsListViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "NewsDetails.h"
#import "NewsListTableViewCell.h"
#import "NewsDetailsViewController.h"

@interface NewsListViewController ()<NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *newsListArray;
    NewsDetails  *newsDetailsObj;
    NSMutableString *currentItemValue;
    IBOutlet UITableView *newsTableView;
}

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    newsListArray = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self fetchNews];
    // Do any additional setup after loading the view.
}

-(IBAction)reloadFeedData{
    
    [self fetchNews];
}

-(void)fetchNews{
    
     [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    manager.responseSerializer = responseSerializer;
    manager.requestSerializer = requestSerializer;
    
    
    [manager GET:@"http://newsrss.bbc.co.uk/rss/sportonline_world_edition/front_page/rss.xml"
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [newsListArray removeAllObjects];
              NSData * data = (NSData *)responseObject;
              [self parseXMLData:data];
               [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
           //   NSLog(@"Response string: %@", [NSString stringWithCString:[data bytes] encoding:NSISOLatin1StringEncoding]);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
               [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
              
               [[[UIAlertView alloc] initWithTitle:nil message:@"Something Went wrong." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil] show];
          }];
    
    
}

-(void)parseXMLData:(NSData *)xmlData{
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:YES];
    [parser setShouldReportNamespacePrefixes:YES];
    [parser setShouldResolveExternalEntities:NO];
    BOOL success = [parser parse];
    
}

#pragma mark - NSXMLParser Delegates

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    if(nil != qualifiedName){
        elementName = qualifiedName;
    }
    if ([elementName isEqualToString:@"item"]) {
        newsDetailsObj = [[NewsDetails alloc]init];
    }else if ([elementName isEqualToString:@"media:thumbnail"]) {
        newsDetailsObj.imageUrl = [attributeDict valueForKey:@"url"];
    } else if([elementName isEqualToString:@"title"] ||
              [elementName isEqualToString:@"description"] ||
              [elementName isEqualToString:@"link"] ||
              [elementName isEqualToString:@"guid"] ||
              [elementName isEqualToString:@"pubDate"]) {
        currentItemValue = [NSMutableString string];
    } else {
        currentItemValue = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if(nil != qName){
        elementName = qName;
    }
    if([elementName isEqualToString:@"title"]){
        newsDetailsObj.newsTitle = currentItemValue;
    }else if([elementName isEqualToString:@"description"]){
        newsDetailsObj.newsDescription = currentItemValue;
    }else if([elementName isEqualToString:@"link"]){
        newsDetailsObj.newsWebLink = currentItemValue;
    }else if([elementName isEqualToString:@"guid"]){
        newsDetailsObj.guidLink = currentItemValue;
    }else if([elementName isEqualToString:@"pubDate"]){
        newsDetailsObj.publishDate = currentItemValue;
    }else if([elementName isEqualToString:@"item"]){
        [newsListArray addObject:newsDetailsObj];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if(currentItemValue!=nil){
        [currentItemValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    //Not needed for now
        NSString *someString = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    if(currentItemValue!=nil){
        [currentItemValue appendString:someString];
    }

    NSLog(@"%@",someString);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    if(parseError.code != NSXMLParserDelegateAbortedParseError) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Something Went Wrong!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil] show];
    }
}



- (void)parserDidEndDocument:(NSXMLParser *)parser {

    [newsTableView reloadData];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListTableViewCell *cell
    = [tableView dequeueReusableCellWithIdentifier:@"NewsListTableViewCell"
                                      forIndexPath:indexPath];
    
    NewsDetails *newsDetailsObject = (NewsDetails *)[newsListArray objectAtIndex:indexPath.row];
    [cell fillCellWithNewsObject:newsDetailsObject];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewsDetailsViewController *vc = [mystoryboard instantiateViewControllerWithIdentifier:@"NewsDetailsViewController"];
    vc.newsDetailsObj = (NewsDetails *)[newsListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    newsTableView.estimatedRowHeight = 65.0;
    newsTableView.rowHeight = UITableViewAutomaticDimension;
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
