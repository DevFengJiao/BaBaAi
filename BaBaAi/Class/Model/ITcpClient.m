//
//  ITcpClient.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "ITcpClient.h"

@implementation ITcpClient:NSObject

-(void)OnSendDataSuccess:(NSString*)sendedTxt{

}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{

}
/**
 * 收到服务器端发送的文本数据
 */
-(void)OnReciveData:(NSDictionary *)recivedTxt{
    NSLog(@"收到服务器端,%@",recivedTxt);
    NSLog(@"msg:%@",[recivedTxt objectForKey:@"msg"]);
}
/**
 * 收到服务器端发送的文本数据和二机制数据
 */
-(void)OnReciveData:(NSDictionary*)recivedTxt withData:(NSData *)recivedData{

}
@end
