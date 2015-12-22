//
//  BaseDatabase.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "UserHandle.h"
//#import "VersionCollect.h"


#define k_DB_NAME [NSString stringWithFormat:@"LbKidsApp_DB_%@_.sqlite3",[VersionCollect versionRunCheckUp]]

@class FMDatabaseQueue;
@interface BaseDatabase : NSObject{
    FMDatabaseQueue *dbQueue;    //初使化FMDatabaseQueue,创建队列
}
@property(nonatomic,weak) NSString *tableName; //表的名称
@property(nonatomic,weak) NSString *error;     //错误信息

@property NSInteger lastInsertId;   //最后一条记录的主键id
@property int pagesize;             //每页分页数

+(BaseDatabase *)shareDB;
/**
 *  @brief 获得组装的sql执行语句
 *
 *  @param sql     SQl 语句
 *  @param table   表名称
 */
- (NSString *)SQL:(NSString *)sql inTable:(NSString *)table;
/**
 *  @brief 获得表名称
 */
- (NSString *)getTableName;
/**
 *  @brief NSInteger  最后一条记录的主键id
 */
- (NSInteger)getLastInsertId;
/**
 *  @brief  获得错误信息
 */
- (NSString *)getError;
/**
 *  @brief 检查表是否存在
 */
- (BOOL)tableExists:(NSString*)tableName;
/**
 *  @brief 创建表
 *  @param sql     SQl 语句
 */
- (BOOL)createTable:(NSString*)sql;
/**
 *  @brief 创建表
 *  @param createTableSQL  SQl 语句
 */
- (BOOL)createTableWithSql:(NSString*)createTableSQL;

/**
 * 分页的时候，组装 where
 */
-(NSString *)pagingWithWhere:(NSString *)where withPage:(int)page;

/**
 * @brief 获得记录的条数
 *
 * @param where  String sql语句条件字符串
 */
- (NSInteger) countByWhere:(NSString *)where;

/**
 *  @brief 根据主键删除一条记录，删除成功返回 YES，失败返回 NO
 *
 *  @param index  主键
 */
- (BOOL) deleteAtIndex:(int)index;
/**
 *  @brief 根据userid删除记录，删除成功返回 YES，失败返回 NO
 *
 */
- (BOOL) deleteByUserId:(unsigned int)uiUserId;
/**
 *  @brief 根据llWearId删除记录，删除成功返回 YES，失败返回 NO
 *
 *  @param llWearId
 */
- (BOOL) deleteByllWearId:(unsigned long long)llWearId;
/**
 *  @brief 根据simei删除记录，删除成功返回 YES，失败返回 NO
 *
 *  @param simei
 */
- (BOOL) deleteBySimei:(NSString *)simei;
/**
 *  @brief 根据where条件删除记录，删除成功返回 YES，失败返回 NO
 *
 *  @param where  NSString where 条件
 */
- (BOOL) deleteByWhere:(NSString *)where;
/**
 *  @brief 删除所有记录，删除成功返回 YES，失败返回 NO
 */

- (BOOL) deleteAll;
/**
 * 删除整个数据库
 */
- (void) deleteDabase;
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

@end
