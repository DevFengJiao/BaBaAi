//
//  TBArea.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseDatabase.h"
#import "AreaModel.h"

@interface TBArea : BaseDatabase
+(TBArea *)shareDB;
/**
 * @brief 插入数据
 * 插入时 记录 actiontime
 */
- (void)insertArea:(AreaModel *)temp;
/**
 * 根据llWearId号获得该对象
 */
-(AreaModel *)getAreaByllWearId:(unsigned long long  )llWearId;
@end
