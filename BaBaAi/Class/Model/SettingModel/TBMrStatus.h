//
//  TBMrStatus.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseDatabase.h"
#import "MrStatus.h"

@interface TBMrStatus : BaseDatabase
+(TBMrStatus *)shareDB;

/**
 * @brief 插入数据
 * 插入时 记录 actiontime
 */
- (void)insert:(MrStatus *)temp;

/**
 * @brief 根据条件查询数据
 */
-(NSMutableArray *)findByWhere:(NSString *)where;

/**
 * @brief 根据simei条件查询数据
 */
-(NSMutableArray *)findByWhereWithImei:(NSString *)sImei;



/**
 * 修改 静音时段
 */
-(void) updateMrStatus:(NSMutableArray *)arr withSimei:(NSString *)simei;

/**
 * 删除一条
 */
-(void)deleteWithMrStatus:(MrStatus *)temp;

@end
