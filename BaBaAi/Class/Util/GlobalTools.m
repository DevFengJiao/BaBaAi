//
//  GlobalTools.m
//  NewLingYou
//
//  Created by zlcs on 15/5/28.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "GlobalTools.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
//#import "WXUtil.h"
//#import "IPAddress.h"
@implementation GlobalTools

//+ (NSString *)deviceIPAdress {
//    NSString *address = @"an error occurred when obtaining ip address";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    
//    success = getifaddrs(&interfaces);
//    
//    if (success == 0) { // 0 表示获取成功
//        
//        temp_addr = interfaces;
//        while (temp_addr != NULL) {
//            if( temp_addr->ifa_addr->sa_family == AF_INET) {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    
//    freeifaddrs(interfaces);
//    
//    NSLog(@"手机的IP是：%@", address);
//    return address;
//}
//+(NSString *)getIPAddress
//{
//    InitAddresses();
//    GetIPAddresses();
//    GetHWAddresses();
//    
//    int i;
//    NSString *deviceIP = @"";
//    for (i=0; i<MAXADDRS; ++i)
//    {
//        static unsigned long localHost = 0x7F000001;            // 127.0.0.1
//        unsigned long theAddr;
//        
//        theAddr = ip_addrs[i];
//        
//        if (theAddr == 0) break;
//        if (theAddr == localHost) continue;
//        
//        NSLog(@"Name: %s MAC: %s IP: %s\n", if_names[i], hw_addrs[i], ip_names[i]);
//        deviceIP = [NSString stringWithUTF8String:ip_names[i]];
//    }
//    NSLog(@"getIPAddress--------%@",deviceIP);
//    
//    return deviceIP;
//}
//
//创建package签名
//+(NSString*) createMd5Sign:(WXPayData *)payData
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject: payData.openID        forKey:@"appid"];
//    [dict setObject: payData.nonceStr      forKey:@"noncestr"];
//    [dict setObject: payData.package       forKey:@"package"];
//    [dict setObject: payData.partnerId     forKey:@"partnerid"];
//    [dict setObject: [NSString stringWithFormat:@"%d",(unsigned int)payData.timeStamp]   forKey:@"timestamp"];
//    [dict setObject: payData.prepayId     forKey:@"prepayid"];
//    
//    NSMutableString *contentString  =[NSMutableString string];
//    NSArray *keys = [dict allKeys];
//    //按字母顺序排序
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    //拼接字符串
//    for (NSString *categoryId in sortedArray) {
//        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
//            && ![categoryId isEqualToString:@"sign"]
//            && ![categoryId isEqualToString:@"key"]
//            )
//        {
//            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
//        }
//        
//    }
//    //添加key字段
//    [contentString appendFormat:@"key=%@", payData.spKey];
//    //得到MD5 sign签名
//    NSString *md5Sign =[WXUtil md5:contentString];
//    NSLog(@"微信支付签名-----------%@",md5Sign);
//   // NSLog(@"MD5签名字符串：\n%@\n\n",contentString);
//    return md5Sign;
//}
+(NSString*)changeTheNumToString:(int) num
{
    NSString * numStr = @"";
    switch (num) {
        case 1:
            numStr = @"一";
            break;
        case 2:
            numStr = @"二";
            break;
        case 3:
            numStr = @"三";
            break;
        case 4:
            numStr = @"四";
            break;
        case 5:
            numStr = @"五";
            break;
        case 6:
            numStr = @"六";
            break;
        case 7:
            numStr = @"七";
            break;
        case 8:
            numStr = @"八";
            break;
        case 9:
            numStr = @"九";
            break;
        case 10:
            numStr = @"十";
            break;
        case 11:
            numStr = @"十一";
            break;
        case 12:
            numStr = @"十二";
            break;
        case 13:
            numStr = @"十三";
            break;
        case 14:
            numStr = @"十四";
            break;
        case 15:
            numStr = @"十五";
            break;
        default:
            break;
    }
    return numStr;
}

@end
