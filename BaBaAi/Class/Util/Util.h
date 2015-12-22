//
//  Util.h
//
//  Created by Seven on 15/5/18.
//  Copyright (c) 2015年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Util : NSObject

//常用日期结构：
//yyyy-MM-dd HH:mm:ss.SSS
//yyyy-MM-dd HH:mm:ss
//yyyy-MM-dd
//MM dd yyyy
+(NSDate*) dateFromFormatStr:(NSString*)timeFormat timeStr:(NSString*)timeStr;
+(NSString*) dateStrFromStr:(NSString*)timeFormat date:(NSDate*)date;
+(NSString*)dateStrFromStr:(NSString *)timeFormat timeStr:(NSString *)timeStr;


+(NSString*) fileNameUnderDocPath:(NSString*)fileName;
+(NSString*) fileNameUnderCachePath:(NSString *)fileName;

//是否闰年
+(BOOL) isLeapYear:(int)year;
+ (NSArray*) allFilesAtPath:(NSString*) dirString;

//把一个json文本文件内容转化成一个NSArray 或者NSDictionary 对象
+ (id)jsonObjectFromJsonFile:(NSString *)jsonFile;

+ (NSString*)stringWithUUID;
@end




@interface NSObject (Addition)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
@end

@interface NSArray (Reverse)
- (NSArray *)reversedArray;
@end



@interface NSMutableArray (Reverse)
- (void)reverse;
@end
