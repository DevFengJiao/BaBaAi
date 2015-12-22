//
//  TBLatestData.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseDatabase.h"
#import "LatestData.h"

@interface TBLatestData : BaseDatabase

+(TBLatestData *)shareDB;

/**
 * @brief 插入数据
 * 插入时 记录 actiontime
 */
- (void)insertLatestData:(LatestData *)temp;
/**
 * 根据Imei号获得该对象
 */
-(LatestData *)getLatestDataByImei:(NSString *)sImei;
/**
 * 获得所有小孩对象
 */
-(NSMutableArray *)getLatestDataAll;

@end
