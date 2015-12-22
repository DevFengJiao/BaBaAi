//
//  DateUtil.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSDate
+ (NSDate*)initByYearMonthDay:(int)year Month:(int)month Day:(int)day;
-(int) getYear;
-(int) getMonth;
-(int) getDay;
+(int)getDaysfromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSString*) nowTimeStamp;
+ (NSString*) omnitureRoundedTimeStamp;
+ (NSString*) timeStampForDateFormat:(NSDate*)date;
+ (NSString*) stringZone;
+ (NSDate*) dateFromString:(NSString*)dateString;
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
- (BOOL) isExpiredToToday;
+ (NSString*) dateFormatMediumStyle:(NSDate*)date;
+ (NSDate*) dateFormatBODStyle:(NSString*)dateString;
+ (NSString*) dateStringBODStyle:(NSDate*)date;
+ (NSString*) dateStringFromString:(NSString*)string;
+ (NSString*) dateStringTwelveCharactersStyle:(NSDate*)date;

//年月日小时分钟秒,毫秒
+ (NSString*) stringFormateWithYYYYMMDDHHmmssSSS:(NSDate*)date;
+ (NSDate*) dateFormateWithYYYYMMDDHHmmssSSS:(NSString*)string;
+ (NSString*) stringFormateWithYYYYMMDDHHmmss:(NSDate*)date;
+ (NSString*) stringFormateRecordDate:(NSString*)string;
+ (NSDate*) dateFormateWithYYYYMMDDHHmmss:(NSString*)string;

+ (NSString*) dateStringHHMM:(NSDate*)date;
+ (NSString*) dateStringMMDD:(NSDate*)date;
+ (NSString*) stringFormateWithYYYYMMDD:(NSDate*)date;
+ (NSDate*) dateFromStringWithYYYYMMDD:(NSString*)dateString;

+ (NSString*) dateStringhhmm:(NSDate*)date;


//该日期是否是今天
+ (BOOL) isToday:(NSString *)string;
+ (NSDate *) lastDay:(NSDate *)currday;
/**
 *获得下一天的时间
 */
+ (NSDate *) nextDay:(NSDate *)currday;
/**
 * 获得该日期的那一天的星期几 （1为星期天）
 */
+(int)getWeekDay:(NSDate *)currDate;

+ (NSDate *) lastDay:(NSDate *)currday withdays:(int)days;
+ (NSDate *) nextDay:(NSDate *)currday withdays:(int)days;
/**
 *  获得零点  20140816000000
 */
+ (NSString*) dateStringZero:(NSDate*)date;
/**
 *  获得23点 20140816235959
 */
+ (NSString*) dateStringEndDate:(NSDate*)date;

+ (NSString*) stringFormateWithHHmmssSSS:(NSDate*)date;
@end
