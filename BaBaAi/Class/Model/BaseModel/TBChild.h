//
//  TBChild.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseDatabase.h"
#import "ChildModel.h"

/**
 * @brief 小孩信息表
 */
@interface TBChild : BaseDatabase

+(TBChild *)shareDB;
/**
 * @brief 插入feedModel数据
 * 插入时 记录 actiontime
 */
- (void)insert:(ChildModel *)temp;
/**
 * @brief 根据条件查询数据
 */
- (NSMutableArray *) findByWhere:(NSString *)where;
/**
 * @brief 根据条件获得第一条记录
 */
- (ChildModel *) findFirstByWhere:(NSString *)where;
/**
 * 根据Imei号获得该对象
 */
-(ChildModel *)getChildByImei:(NSString *)sImei;
/**
 * 根据llWearId号获得该对象
 */
-(ChildModel *)getChildByllWearId:(unsigned long long)llWearId;
/**
 * 获得所有小孩对象
 */
-(NSMutableArray *)getChildAll;

@end

