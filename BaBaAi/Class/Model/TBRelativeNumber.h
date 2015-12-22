//
//  TBRelativeNumber.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseDatabase.h"
#import "RelativeNumberModel.h"
@interface TBRelativeNumber : BaseDatabase
/**
 * @brief 亲情号码设置表
 */


+(TBRelativeNumber *)shareDB;

/**
 * @brief 插入数据
 * 插入时 记录 actiontime
 */
- (void)insert:(RelativeNumberModel *)temp;

/**
 * 根据条件查询数据
 */
-(NSMutableArray *)findByWhere:(NSString *)where;

/**
 * 根据条件获得第一条记录
 */
- (RelativeNumberModel *) findFirstByWhere:(NSString *)where;
/**
 * 根据sImei获得电话列表
 */
-(NSMutableArray *)findBysImei;

/**
 * 修改亲情号码
 */
-(void) updateRelativeNumber:(NSMutableArray *)arr withSimei:(NSString *)simei;


@end
