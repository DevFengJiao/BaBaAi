//
//  TcpClient.h
//  ConnectTest
//
//  Created by  SmallTask on 13-8-15.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
//#import "ITcpClient.h"
#import "DataPacket.h"
//#import "Reachability.h"

#define SOCKET_TIME_OUT -1

@class DataPacket;

@interface TcpClient : NSObject<GCDAsyncSocketDelegate>
{
    long TAG_SEND;
    long TAG_RECIVED;
    
    id<ITcpClient> itcpClient;
    
    NSMutableArray *recivedArray;
}

@property (nonatomic,retain) GCDAsyncSocket *asyncSocket;


+ (TcpClient *)sharedInstance;

-(void)setDelegate_ITcpClient:(id<ITcpClient>)_itcpClient;
/**
 * 链接服务器
 */
-(void)openTcpConnection:(NSString*)host port:(NSInteger)port;
/**
 *  发送数据
 *
 *  @param prot 协议信息
 *  @param data 封装的数据
 */
- (void) sendContent:(DataPacket*)dataPacket;


/**
 * 写入数据
 */
-(void)writeData:(NSData*)data;

-(long)GetSendTag;

-(long)GetRecivedTag;




/**
 *  中断Socket连接
 */
- (void) disconnectSocket;
/**
 *  开始心跳
 */
- (void) startHeartRateTimer;
/**
 *让心跳重新开始
 */
- (void) restartHeartRate;
/**
 *  删除验证响应的临时对象
 *
 *  @param key 生成对象的时间戳
 */
- (void) removeCachDataPacketWithKey:(NSString*)key;
- (void) removeLoginTempDataPacket;

@end
