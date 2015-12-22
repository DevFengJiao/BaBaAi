//
//  DateUtil.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil
+ (NSDate*)initByYearMonthDay:(int)year Month:(int)month Day:(int)day{
    return nil;
}
//-(int) getYear{
//    int i=1;
//}
//-(int) getMonth{
//
//}
//-(int) getDay{
//
//}
+(int)getDaysfromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    return 1;
}
+ (NSString*) nowTimeStamp{
    return nil;
}
+ (NSString*) omnitureRoundedTimeStamp{
    return nil;
}
+ (NSString*) timeStampForDateFormat:(NSDate*)date{
    return nil;
}
+ (NSString*) stringZone{
    return nil;
}
+ (NSDate*) dateFromString:(NSString*)dateString{
    return nil;
}
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime{
    return nil;
}
- (BOOL) isExpiredToToday{
    return nil;
}
+ (NSString*) dateFormatMediumStyle:(NSDate*)date{
    return nil;
}
+ (NSDate*) dateFormatBODStyle:(NSString*)dateString{
    return nil;
}
+ (NSString*) dateStringBODStyle:(NSDate*)date{
    return nil;
}
+ (NSString*) dateStringFromString:(NSString*)string{
    return nil;
}
+ (NSString*) dateStringTwelveCharactersStyle:(NSDate*)date{
    return nil;
}

//年月日小时分钟秒,毫秒
+ (NSString*) stringFormateWithYYYYMMDDHHmmssSSS:(NSDate*)date{
    return nil;
}
+ (NSDate*) dateFormateWithYYYYMMDDHHmmssSSS:(NSString*)string{
    return nil;
}
+ (NSString*) stringFormateWithYYYYMMDDHHmmss:(NSDate*)date{
    return nil;
}
+ (NSString*) stringFormateRecordDate:(NSString*)string{
    return nil;
}
+ (NSDate*) dateFormateWithYYYYMMDDHHmmss:(NSString*)string{
    return nil;
}

+ (NSString*) dateStringHHMM:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    formatter.dateFormat = @"HH:mm";
    NSString *dateNow = [formatter stringFromDate:date];
    return dateNow;
    
}
+ (NSString*) dateStringMMDD:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"MM/DD";
    NSString *dateNow = [formatter stringFromDate:date];
    return dateNow;
}
+ (NSString*) stringFormateWithYYYYMMDD:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    formatter.dateFormat = @"YYYY/MM/DD";
    NSString *dateNow = [formatter stringFromDate:date];
    return dateNow;
}
+ (NSDate*) dateFromStringWithYYYYMMDD:(NSString*)dateString{
    return nil;
}

+ (NSString*) dateStringhhmm:(NSDate*)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

    formatter.dateFormat = @"HH:mm";
    NSString *dateNow = [formatter stringFromDate:date];
    NSLog(@"date:%@",dateNow);
    return dateNow;

}


//该日期是否是今天
+ (BOOL) isToday:(NSString *)string{
    return nil;
}
+ (NSDate *) lastDay:(NSDate *)currday{
    return nil;
}
/**
 *获得下一天的时间
 */
+ (NSDate *) nextDay:(NSDate *)currday{
    return nil;
}
/**
 * 获得该日期的那一天的星期几 （1为星期天）
 */
+(int)getWeekDay:(NSDate *)currDate{
    return nil;
}

+ (NSDate *) lastDay:(NSDate *)currday withdays:(int)days{
    return nil;
}
+ (NSDate *) nextDay:(NSDate *)currday withdays:(int)days{
    return nil;
}
/**
 *  获得零点  20140816000000
 */
+ (NSString*) dateStringZero:(NSDate*)date{
    return nil;
}
/**
 *  获得23点 20140816235959
 */
+ (NSString*) dateStringEndDate:(NSDate*)date{
    return nil;
}

+ (NSString*) stringFormateWithHHmmssSSS:(NSDate*)date{
    return nil;
}

@end
