//
//  NewsListTableViewCell.m
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import "NewsListTableViewCell.h"

@implementation NewsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellWithNewsObject:(NewsDetails *)obj{
    
    
    titleLbl.text = obj.newsTitle;
    dateLbl.text = obj.publishDate;
    descriptionLbl.text = obj.newsDescription;
    [_linkButton setTitle:obj.newsWebLink forState:UIControlStateNormal];
    [newsImageView setImageURL:[NSURL URLWithString:obj.imageUrl]];
}

@end
