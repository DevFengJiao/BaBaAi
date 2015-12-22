//
//  TBParameters.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseDatabase.h"
#import "ParameterModel.h"

/**
 * @brief手表参数设置表
 */

@interface TBParameters : BaseDatabase

+(TBParameters *)shareDB;
/**
 * @brief 插入ParameterModel数据
 * 插入时 记录 actiontime
 */
- (void)insert:(ParameterModel *)temp;
/**
 *  @brief  获得该对象
 *  @param sImei 手表的Imei号
 *  @param sParaName 对应的参数名称
 */
-(ParameterModel *)findFirstByImei:(NSString *)sImei withParaName:(NSString *)sParaName;
/**
 * @brief 根据条件查询数据
 */
-(NSMutableArray *)findByWhere:(NSString *)where;
/**
 * @brief 根据simei条件查询数据
 */
-(NSMutableArray *)findByWhereWithImei:(NSString *)sImei;
/**
 * 修改参数
 */
-(void) update:(ParameterModel *)temp;


@end
