//
//  TBMrStatus.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "TBMrStatus.h"

@implementation TBMrStatus
+ (TBMrStatus *)shareDB
{
    
    static dispatch_once_t pred;
    static TBMrStatus * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}
- (void)insert:(MrStatus *)temp{

}

/**
 * @brief 根据条件查询数据
 */
-(NSMutableArray *)findByWhere:(NSString *)where{
    NSMutableArray *arry = [NSMutableArray array];
    return arry;
}

/**
 * @brief 根据simei条件查询数据
 */
-(NSMutableArray *)findByWhereWithImei:(NSString *)sImei{
    return nil;
}



/**
 * 修改 静音时段
 */
-(void) updateMrStatus:(NSMutableArray *)arr withSimei:(NSString *)simei{
   
}

/**
 * 删除一条
 */
-(void)deleteWithMrStatus:(MrStatus *)temp{

}

@end
