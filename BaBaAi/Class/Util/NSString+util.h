//
//  NSString+util.h
//  NewLingYou
//
//  Created by Seven on 15/5/22.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringUtils)

//判断是否是中文，但不支持中英文混编
-(BOOL)isChinese;

- (NSString *)pinyin;
//大写
- (NSString *)firstLetter;

//是否只包含十进制数字
- (BOOL)isOnlyNumber;

+ (NSString*)transferTimeString:(NSString*)string;
+ (NSString*)changeString:(NSString*)string1 String:(NSString*)string2;
+ (NSString*)transferString:(NSString*)string;
+ (NSString*)coordinationsToString:(NSArray*)coordinations;
+ (NSArray*)coordinationStringTocoordinations:(NSString*)coordinationString;
+ (NSArray*)coordinationStringToPoints:(NSString*)coordinationString;
+ (NSString*)CGPointsToString:(NSArray*)points;
+ (NSString*)stringByTrimmingCharacters:(NSString*)string;
+ (NSString*) randomString;
+ (NSString*) birdthdayFormat:(NSString*)string;
+ (NSString*) birdthdayFormatToNumber:(NSString*)string;
+ (NSString*) birdthdayFormat8:(NSString*)string;
- (NSString*) getLengthOfCommand;
/**
 * 十六进制转NSData
 */
- (NSData *) stringToHexData;

+(NSString *)RoundUp:(float)price;
+(NSString *)RoundBankers:(float)price;
+(NSString *)notRounding:(float)price afterPoint:(int)position;
+(NSString *)RoundUp:(float)price afterPoint:(int)position;
+(NSString *)RoundBankers:(float)price afterPoint:(int)position;

+(int)getRandomNumber:(int)from to:(int)to;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//把生日插入－
+(NSString*)changePureNumberToDobWith:(NSMutableString*)birthDay;




// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
//验证email是否合法
+ (BOOL) isValidateEmail:(NSString *)email;
//验证身份证是否合法
+ (BOOL) isValidateIdentityCardNumberl:(NSString *)cardNumberl;

/**
 * @brief 获取字符串（包含中英文混合的情况）的长度
 * @param strtemp 输入的字符串
 */
- (NSInteger)stringLenth;
/**
 * 判断字符串为空和只为空格解决办法
 */
+ (BOOL)isBlankString:(NSString *)string;
/**
 * 判断NSObject是否为空||null||nil...
 * 返回YES标示数据为空
 */
+ (BOOL)isNullObj:(id)object;
/**
 * 返回Int类型的字典成员
 */
+(int )isNullObjwithInt:(id)object;
/**
 * 返回longlong类型的字典成员
 */
+(long long)isNullObjwithlonglong:(id)object;

/**
 * 返回longlong类型的字典成员
 */
+(unsigned long long)isNullObjwithUnsignedlonglong:(id)object;

/**
 * 返回UnsignedInt类型的字典成员
 */
+(unsigned int)isNullObjwithUnsignedInt:(id)object;
/**
 * 返回bool类型的字典成员
 */
+(BOOL)isNullObjwithBool:(id)object;
/**
 * 返回NSString类型的字典成员
 */
+(NSString *)isNullObjwithNSString:(id)object;
/**
 * 返回float类型的字典成员
 */
+(float )isNullObjwithFloat:(id)object;
/**
 * 返回NSArray类型的字典成员
 */
+(NSArray *)isNullObjwithNSArray:(id)object;
/**
 * 返回NSDictionary类型的字典成员
 */
+(NSDictionary *)isNullObjwithNSDictionary:(id)object;
/**
 * 两端去空格
 */
+(NSString *)whitespace:(NSString *)str;


@end
