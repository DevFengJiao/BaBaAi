//
//  ITcpClient.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITcpClient <NSObject>

@optional
#pragma mark ITcpClient

/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt;

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err;
/**
 * 收到服务器端发送的文本数据
 */
-(void)OnReciveData:(NSDictionary *)recivedTxt;
/**
 * 收到服务器端发送的文本数据和二机制数据
 */
-(void)OnReciveData:(NSDictionary*)recivedTxt withData:(NSData *)recivedData;

@end
