//
//  LBinKidsApp.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBinKidsApp : NSObject
@property(nonatomic,strong) NSString* mapType;     //地图类型
@property(nonatomic,strong) NSString* domainName;  //域名
@property(nonatomic,strong) NSString* port;        //端口
@property(nonatomic,strong) NSString* clientID;    //客户端id
+(LBinKidsApp *)share;

/**
 * 初始化application
 */
-(void) setApplication:(UIApplication *)application;

/**
 * 设置域名配置
 */
+(NSString *)setDomainName;
/**
 * 设置端口
 */
+(NSString *)setSocketPort;
/**
 * 设置地图类型
 */
+(NSString *)setMapType;








@end
