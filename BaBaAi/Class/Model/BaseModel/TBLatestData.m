//
//  TBLatestData.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "TBLatestData.h"

@implementation TBLatestData
+ (TBLatestData *)shareDB
{
    
    static dispatch_once_t pred;
    static TBLatestData * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}

/**
 * @brief 插入数据
 * 插入时 记录 actiontime
 */
- (void)insertLatestData:(LatestData *)temp{
}
/**
 * 根据Imei号获得该对象
 */
-(LatestData *)getLatestDataByImei:(NSString *)sImei{
    return nil;
}
/**
 * 获得所有小孩对象
 */
-(NSMutableArray *)getLatestDataAll{
    return nil;
}
@end
