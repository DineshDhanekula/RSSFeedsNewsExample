//
//  CommonUtility.m
//  RSSFeedsNewsExample
//
//  Created by Dinesh Dhanekula on 6/10/16.
//  Copyright © 2016 Dinesh Dhanekula. All rights reserved.
//

#import "CommonUtility.h"

@implementation CommonUtility

+(id)checkForNull:(NSString *)string
{
    if (!string)
        return @"";
    else if([string isEqual:[NSNull null]])
        return @"";
    else if ([string isKindOfClass:[NSString class]])
        return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    else
        return string;
}
@end
