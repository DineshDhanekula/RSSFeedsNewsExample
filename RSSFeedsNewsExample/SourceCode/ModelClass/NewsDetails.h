//
//  NewsDetails.h
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetails : NSObject

@property(nonatomic,strong) NSString *newsTitle;
@property(nonatomic,strong) NSString *newsDescription;
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *newsWebLink;
@property(nonatomic,strong) NSString *publishDate;
@property(nonatomic,strong) NSString *guidLink;



@end
