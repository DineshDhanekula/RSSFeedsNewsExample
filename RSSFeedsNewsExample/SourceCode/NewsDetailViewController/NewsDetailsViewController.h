//
//  NewsDetailsViewController.h
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "NewsDetails.h"
@interface NewsDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *newDetailsTableView;
    IBOutlet EGOImageView *headerImageView;
    CGRect initialFrame;
}

@property(nonatomic,assign) NewsDetails *newsDetailsObj;

@end
