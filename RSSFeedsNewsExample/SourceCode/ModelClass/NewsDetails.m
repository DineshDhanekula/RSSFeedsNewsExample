//
//  NewsDetails.m
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import "NewsDetails.h"
#import "CommonUtility.h"

@implementation NewsDetails


-(void)dealloc{
    _newsTitle = nil;
    _imageUrl = nil;
    _newsWebLink = nil;
    _guidLink = nil;
    _newsDescription = nil;
    _publishDate = nil;
}


@end
