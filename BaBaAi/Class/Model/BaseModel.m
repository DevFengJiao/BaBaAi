//
//  BaseModel.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


+(NSArray *)locModeArr{
    NSArray *array = @[@"省电模式",@"正常模式",@"精准模式"];
    return array;
}
///**
// * 时间间隔 数组 3分钟 5分钟 10分钟  15分钟  20分钟 30 分钟
// */
+(NSDictionary *)locPeriodArr{
    NSDictionary *dic = @{@"3分钟":@"3分钟",@"5分钟":@"5分钟",@"10分钟":@"10分钟",@"20分钟":@"20分钟",@"30分钟":@"30分钟"};
    return dic;
}
/**
 * 时间间隔的 key
 */
+(NSArray *)locPeriodArrkeys{
    NSArray *array = @[@"3分钟",@"5分钟",@"10分钟",@"20分钟",@"30分钟"];
    return array;
}
/**
 * 碰撞等级 0:轻量,1:一般;2:严重;3:重量
 */
+(NSArray *)cillLevelArr{
    NSArray *array = @[@"轻量",@"一般",@"严重",@"重量"];
    return array;
}
-(NSDictionary *)isNullObjwithNSDictionary:(id)object{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"1" forKey:@"1"];
    return dic;
}

@end
