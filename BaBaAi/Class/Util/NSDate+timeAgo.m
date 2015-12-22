//
//  NSDate+timeAgo.m
//  NewLingYou
//
//  Created by Seven on 15/5/22.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "NSDate+timeAgo.h"

@implementation NSDate (timeAgo)
- (NSString *) longDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"M'月'd'日' HH:mm";
    
    return [formatter stringFromDate:self];
}

- (NSString *) mediumDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"yy/MM/dd";
    
    return [formatter stringFromDate:self];
}

- (NSString *) onlyDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"MM月dd日";
    
    return [formatter stringFromDate:self];
}

- (NSString *) shortDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"MM/dd";
    
    NSDate *date = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    
    if([self timeIntervalSinceDate:date]) //今天的时间
    {
        formatter.dateFormat = @"HH:mm";
        return [formatter stringFromDate:self];
    }
    
    return [formatter stringFromDate:self];
    
}

- (NSString *)timeAgo
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    formatter.dateStyle = kCFDateFormatterMediumStyle;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"M'月'd'日' HH:mm";
    NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
    NSInteger day = (seconds - [self timeIntervalSince1970])/( 60 * 60 * 24);
    
    if(day > 1)
    {
        return [formatter stringFromDate:self];
    }
    else if(day == 1)
    {
        return @"昨天";
    }
    else
    {
        NSInteger hour = (seconds - [self timeIntervalSince1970])/(60 * 60);
        if(hour > 0)
        {
            return [NSString stringWithFormat:@"%ld小时前",(long)hour];
        }
        else
        {
            NSInteger minins = (seconds - [self timeIntervalSince1970])/ 60;
            
            if(minins > 0)
            {
                return [NSString stringWithFormat:@"%ld分钟前",(long)minins];
            }
            else
            {
                NSInteger sec = seconds - [self timeIntervalSince1970];
                if(sec <= 5)
                {
                    return @"刚刚";
                }
                else
                {
                    return [NSString stringWithFormat:@"%ld秒钟前",(long)sec];
                }
            }
        }
    }
    return nil;
}
+(NSString *)timeForStringWithDate:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString * dateNow = [formatter stringFromDate:date];
    return dateNow;
}
@end
