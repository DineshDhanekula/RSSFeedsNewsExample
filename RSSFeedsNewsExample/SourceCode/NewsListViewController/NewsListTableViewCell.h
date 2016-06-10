//
//  NewsListTableViewCell.h
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "NewsDetails.h"
@interface NewsListTableViewCell : UITableViewCell
{
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *dateLbl;
    IBOutlet UILabel *descriptionLbl;
    IBOutlet EGOImageView *newsImageView;
   
}
@property(nonatomic,weak)  IBOutlet UIButton *linkButton;
-(void)fillCellWithNewsObject:(NewsDetails *)obj;


@end
