//
//  DataPacket.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPacket : NSObject
/**
 * 命令
 */
@property (nonatomic,strong) NSString *sCommand;

/**
 * 命令 id
 **/
@property (nonatomic,assign) int iCommandId;
/**
 * 发送命令的时间
 */
@property (nonatomic,strong) NSString* timestamp;

/**
 *  存放发送的数据
 */
@property (nonatomic,strong) NSMutableDictionary *paraDictionary;
/**
 * 文本类型 1字节,0为文本,1为文本加二进制,2 gzip压缩文本,3:gzip压缩文本加二进制
 */
@property (nonatomic,assign) int iType;
/**
 * 二进制 文件
 */
@property (nonatomic,strong) NSData* dataContent;

/**
 * 获得请求的二进制流
 */
- (NSData*) requestDataToByteStream;
/**
 * 获得文本内容
 */
-(NSString *)getTextContent;
/**
 * 判断最后一个命令时间是否是一个心跳时间
 */
- (BOOL) isLost;


@end
