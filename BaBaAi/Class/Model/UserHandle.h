//
//  UserHandle.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapView.h>


@interface UserHandle : NSObject

/**
 * @brief 获取UserHandle用户管理实例
 */
+(instancetype)standardHandle;
/**
 * 设置登录
 */
-(void)setLoginInfo:(NSString *)loginInfo;
/**
 * 设置密码
 */
-(void)setPasswordInfo:(NSString *)PasswordInfo;
/**
 * 登录请求体
 */
-(NSMutableDictionary *)paraInfoDic;


/**
 * 用户id
 */
-(NSString *)sMemberID;
/**
 * 获取用户登录用的token
 */
-(NSString *)sToken;

/**
 * 手表的标示
 */
-(NSString *)sImei;

/**
 * 清除登陆用户的本地存储信息
 */
-(void)removeUserLocalStorage;
/**
 * 获得当前语言
 */
-(NSString *)currLanguage;


@end
