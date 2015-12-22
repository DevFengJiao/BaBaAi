//
//  TcpClient.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//


#import "TcpClient.h"
#import "GCDAsyncSocket.h"
#import "DDLog.h"
#import "DDTTYLogger.h"


static const int ddLogLevel = LOG_LEVEL_INFO;

#define USE_SECURE_CONNECTION 0
#define ENABLE_BACKGROUNDING  0

#if USE_SECURE_CONNECTION
#define HOST @"192.168.1.119"
#define PORT 9000
#else
#define HOST @"120.24.181.205"
#define PORT 8983
#endif

@implementation TcpClient
@synthesize asyncSocket;

+ (TcpClient *)sharedInstance
{
    static TcpClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TcpClient alloc] init];
    });
    
    return _sharedInstance;
}


-(id)init
{
    self = [super init];
    recivedArray = [NSMutableArray arrayWithCapacity:10];
    return self;
}

-(void)setDelegate_ITcpClient:(id<ITcpClient>)_itcpClient
{
    itcpClient = _itcpClient;
    [self openTcpConnection:HOST port:PORT];
}

-(void)openTcpConnection:(NSString*)host port:(NSInteger)port
{

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
    
    if (![asyncSocket connectToHost:host onPort:port error:0]) {
        [SVProgressHUD showErrorWithStatus:@"连接服务器失败!!"];
    }
}


-(void)writeData:(NSData*)data
{
    TAG_SEND++;
    [asyncSocket writeData:data withTimeout:-1. tag:TAG_SEND];
}


-(long)GetSendTag
{
    return TAG_SEND;
}

-(long)GetRecivedTag
{
    return TAG_RECIVED;
}


- (void) sendContent:(DataPacket*)dataPacket{
    
    NSNumber *number = [NSNumber numberWithLong:2147483647];
    
    NSDictionary *dic = dataPacket.paraDictionary;
    
    
    NSDictionary *dataDic = @{@"id":number,@"body":dic,@"code":dataPacket.sCommand};
    
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:dataDic options:0 error:0];
    
    NSString *myDataStr = [[NSString alloc]initWithData:dataJson encoding:NSUTF8StringEncoding];
    
    NSLog(@"json:%@  jsonLeng:%d",myDataStr,(int)myDataStr.length);
    
    char buf[128];
    //总长度
    int leng1 = (int)myDataStr.length+3;
    //类型为0是json;
    int leng2 = dataPacket.iType;
    //json内容长度
    int leng3 = (int)myDataStr.length;
    
    //总长度转无符号二字节
    unsigned char char1[2];
    char1[1] = (char)(leng1 & 0xff);
    char1[0] = (char)((leng1 >> 8)&0xff);
    
    unsigned char char2[1];
    char2[0] = (char)(leng2 & 0xff);
    
    sprintf(buf, "--%d--",char2[0]);

    NSString *myBuf = [NSString stringWithFormat:@"%s",buf];
 
    NSLog(@"mybuf:%@",myBuf);
    
    NSLog(@"sunLeng:%d jsonLeng:%d",leng1,leng3);
    
    unsigned char char3[2];
    char3[1] = (char)(leng3 & 0xff);
    char3[0] = (char)((leng3 >> 8)&0xff);

    NSMutableData *datas = [[NSMutableData alloc]init];
    //消息头
    [datas appendData:[@"YLF" dataUsingEncoding:NSASCIIStringEncoding]];
    [datas appendBytes:&char1 length:sizeof(char1)];
    [datas appendBytes:&char2 length:sizeof(char2)];
    [datas appendBytes:&char3 length:sizeof(char3)];
    //json内容
    [datas appendData:dataJson];

    NSString *datasStr = [[NSString alloc]initWithData:datas encoding:NSUTF8StringEncoding];
    NSLog(@"datas: %@",datasStr);
    
   [asyncSocket writeData:datas withTimeout:-1 tag:1];
   
}

#pragma mark Socket Delegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"connectToHost!!!");
   

}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [sock readDataWithTimeout: -1 tag: 0];
//    [sock readDataToData:[GCDAsyncSocket LFData] withTimeout:-1 tag:0];
    DDLogInfo(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
    dispatch_async(dispatch_get_main_queue(), ^{
        [itcpClient OnSendDataSuccess:[NSString stringWithFormat:@"tag:%li",tag]];
    });
}

//如果得到数据，会调用回调方法
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *temp = [aStr substringFromIndex:8];
    NSData *jsonData = [temp dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        [itcpClient OnReciveData:dic];
    });
    
    [sock readDataWithTimeout:-1 tag:0];
}
//重新连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    
    NSLog(@"onSocketDidDisconnect:%p", sock);
    dispatch_async(dispatch_get_main_queue(), ^{
        [itcpClient OnConnectionError:err];
    });
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
    NSLog(@"onSocket:%p didSecure:YES", sock);
}

/**
 *  中断Socket连接
 */
- (void) disconnectSocket{
    [asyncSocket disconnect];
    asyncSocket = nil;
}
/**
 *  开始心跳
 */
- (void) startHeartRateTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(restartHeartRate) userInfo:nil repeats:YES];
    [timer fire];
}
/**
 *让心跳重新开始
 */
- (void)restartHeartRate{
    // 根据服务器要求发送固定格式的数据，假设为指令@"longConnect"，但是一般不会是这么简单的指令
    NSString *longConnect = @"longConnect";
    
    NSData   *dataStream  = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    
    [asyncSocket writeData:dataStream withTimeout:1 tag:1];
}
/**
 *  删除验证响应的临时对象
 *
 *  @param key 生成对象的时间戳
 */
- (void) removeCachDataPacketWithKey:(NSString*)key{
    
}
- (void) removeLoginTempDataPacket{
    
}

@end

