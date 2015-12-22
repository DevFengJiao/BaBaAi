//
//  BaseModel.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief model 公共属性
 */
@interface BaseModel : NSObject


@property int index;   // 表主键
@property(nonatomic,strong) NSDate* actiontime;    //操作时间

/**
 * 判断NSObject是否为空||null||nil...
 * 返回YES标示数据为空
 */
- (BOOL)isNullObj:(id)object;
/**
 * 返回Int类型的字典成员
 */
-(int )isNullObjwithInt:(id)object;
/**
 * 返回UnsignedInt类型的字典成员
 */
-(unsigned int)isNullObjwithUnsignedInt:(id)object;

/**
 * 返回bool类型的字典成员
 */
-(BOOL)isNullObjwithBool:(id)object;

/**
 * 返回NSString类型的字典成员
 */
-(NSString *)isNullObjwithNSString:(id)object;

/**
 * 返回NSArray类型的字典成员
 */
-(NSArray *)isNullObjwithNSArray:(id)object;

/**
 * 返回NSDictionary类型的字典成员
 */
-(NSDictionary *)isNullObjwithNSDictionary:(id)object;



/**
 * 返回longlong类型的字典成员
 */
-(unsigned long long)isNullObjwithUnsignedlonglong:(id)object;
/**
 * 返回float类型的字典成员
 */
-(float )isNullObjwithFloat:(id)object;

/**
 * 定位方式数组
 */
+(NSArray *)locModeArr;
/**
 * 时间间隔 数组 3分钟 5分钟 10分钟  15分钟  20分钟 30 分钟
 */
+(NSDictionary *)locPeriodArr;
/**
 * 时间间隔的 key
 */
+(NSArray *)locPeriodArrkeys;
/**
 * 碰撞等级 0:轻量,1:一般;2:严重;3:重量
 */
+(NSArray *)cillLevelArr;

@end

