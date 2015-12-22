//
//  GlobalTools.h
//  NewLingYou
//
//  Created by zlcs on 15/5/28.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "WXPayData.h"
@interface GlobalTools : NSObject

//+ (NSString *)deviceIPAdress;
+(NSString *)getIPAddress;
//创建package签名
//+(NSString*) createMd5Sign:(WXPayData *)payData;

+(NSString*)changeTheNumToString:(int) num;
@end
