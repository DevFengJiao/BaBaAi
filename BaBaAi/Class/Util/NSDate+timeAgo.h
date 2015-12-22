//
//  NSDate+timeAgo.h
//  NewLingYou
//
//  Created by Seven on 15/5/22.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (timeAgo)
/**
 *  显示yy/MM/dd HH:mm格式的时间
 *
 *  @return 时间
 */
- (NSString *) longDateString;

- (NSString *) mediumDateString;

- (NSString *) onlyDateString;

/**
 *  如果是今天就显示12:20 ，如果是今天之前的时间就显示日期
 *
 *  @return 时间
 */
- (NSString *) shortDateString;

/**
 *   一个小时之内显示多少分钟之前
 *   今天之内的显示多少小时之前
 *   昨天的直接显示昨天
 *   昨天之前的直接显示日期
 *
 *  @return 时间
 */
- (NSString *)timeAgo;
+ (NSString *)timeForStringWithDate:(NSDate *)date;
@end
