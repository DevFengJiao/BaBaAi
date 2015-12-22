//
//  NSString+util.m
//  NewLingYou
//
//  Created by Seven on 15/5/22.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "NSString+util.h"

@implementation NSString (util)

//判断是否是中文，但不支持中英文混编
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (NSString *)pinyin
{
    //方式一
    
    //先转换为带声调的拼音
    
    NSMutableString *str = [self mutableCopy];
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    return str;
}

- (BOOL)isOnlyNumber
{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ([str length] == 0) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString *)firstLetter
{
  NSString *pinyin = [self pinyin];
    return [[pinyin uppercaseString] substringToIndex:1];
}

-(NSInteger)stringLenth{
    NSInteger lenth = self.length;
    return lenth;
}
+ (BOOL)isBlankString:(NSString *)string{
    BOOL is = NULL_STR(string);
    return is;
}

+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString*)transferString:(NSString*)string{
    return nil;
}

@end
