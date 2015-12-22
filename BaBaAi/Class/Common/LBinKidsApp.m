//
//  LBinKidsApp.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "LBinKidsApp.h"

@implementation LBinKidsApp
+(LBinKidsApp *)share{
    static dispatch_once_t pred;
    static LBinKidsApp * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}

-(void) setApplication:(UIApplication *)application{
    self.clientID = @"ylf";
}

+(NSString *)setDomainName{
    NSString *domainName = @"ylf";
    return domainName;
}
/**
 * 设置端口
 */
+(NSString *)setSocketPort{
    NSString *domainName = @"ylf";
    return domainName;
}
/**
 * 设置地图类型
 */
+(NSString *)setMapType{
    NSString *domainName = @"ylf";
    return domainName;
}



@end
