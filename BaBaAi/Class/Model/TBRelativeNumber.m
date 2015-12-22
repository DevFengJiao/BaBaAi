//
//  TBRelativeNumber.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "TBRelativeNumber.h"

@implementation TBRelativeNumber
+ (TBRelativeNumber *)shareDB
{
    
    static dispatch_once_t pred;
    static TBRelativeNumber * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}

/**
 * @brief 插入数据
 * 插入时 记录 actiontime
 */
- (void)insert:(RelativeNumberModel *)temp{

}

/**
 * 根据条件查询数据
 */
-(NSMutableArray *)findByWhere:(NSString *)where{
    return nil;
}

/**
 * 根据条件获得第一条记录
 */
- (RelativeNumberModel *) findFirstByWhere:(NSString *)where{
    return nil;
}
/**
 * 根据sImei获得电话列表
 */
-(NSMutableArray *)findBysImei{
    return nil;
}

/**
 * 修改亲情号码
 */
-(void) updateRelativeNumber:(NSMutableArray *)arr withSimei:(NSString *)simei{
 
}

@end
