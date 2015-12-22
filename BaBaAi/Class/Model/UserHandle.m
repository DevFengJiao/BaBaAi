//
//  UserHandle.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "UserHandle.h"

@implementation UserHandle
+(instancetype)standardHandle
{
    
    static dispatch_once_t pred;
    static UserHandle * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}
-(NSString *)sImei{
    return @"111111111111";
}
-(NSString *)currLanguage{
    return MAMapLanguageZhCN;
}
-(NSString *)sMemberID{
    return @"18682381760";
}
-(void)setLoginInfo:(NSString *)loginInfo{

}
@end
