//
//  Util.m
//
//  Created by Seven on 15/5/18.
//  Copyright (c) 2015年 sky. All rights reserved.
//

#import "Util.h"

@implementation Util



+(NSDate*) dateFromFormatStr:(NSString*)timeFormat timeStr:(NSString*)timeStr
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:timeFormat];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    return inputDate;
}

+(NSString*) dateStrFromStr:(NSString*)timeFormat date:(NSDate*)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:timeFormat];
    NSString *str = [outputFormatter stringFromDate:date];
    return str;
}

+(NSString *)dateStrFromStr:(NSString *)timeFormat timeStr:(NSString *)timeStr
{
    NSDate *date = [Util dateFromFormatStr:timeFormat timeStr:timeStr];
    NSLog(@"dateStrFromStr:%@",date);
    return [Util dateStrFromStr:timeFormat date:date];
}

+(NSString*) fileNameUnderDocPath:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return  [documentsDirectory stringByAppendingPathComponent:fileName];
}

+(NSString*)fileNameUnderCachePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return  [documentsDirectory stringByAppendingPathComponent:fileName];
}

+(BOOL) isLeapYear:(int)year
{
    return (year%4==0 && year%100!=0) || year%400==0;
}

+ (NSArray*) allFilesAtPath:(NSString*) dirString {
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* tempArray = [fileMgr contentsOfDirectoryAtPath:dirString error:nil];
    for (NSString* fileName in tempArray) {
        BOOL flag = YES;
        NSString* fullPath = [dirString stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag) {
                [array addObject:fileName];
            }
        }
    }
    return array;
}

+ (id)jsonObjectFromJsonFile:(NSString *)jsonFile
{
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:jsonFile] ) {
        return nil;
    }
    
    NSData *fileData = [NSData dataWithContentsOfFile:jsonFile];
     id objc   = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:NULL];
    return objc;
}

+ (NSString*)stringWithUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

@end




@implementation NSObject (Addition)

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    if (signature) {
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:selector];
        for(int i = 0; i < [objects count]; i++){
            id object = [objects objectAtIndex:i];
            [invocation setArgument:&object atIndex: (i + 2)];
        }
        [invocation invoke];
        if (signature.methodReturnLength) {
            id anObject;
            [invocation getReturnValue:&anObject];
            return anObject;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}
@end



@implementation NSArray (Reverse)

- (NSArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end

@implementation NSMutableArray (Reverse)

- (void)reverse {
    if ([self count] == 0)
        return;
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
        
        i++;
        j--;
    }
}
@end