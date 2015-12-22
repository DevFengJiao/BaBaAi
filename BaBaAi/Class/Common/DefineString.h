//
//  DefineString.h
//  LingYou
//
//  Created by Seven on 15/5/18.
//  Copyright (c) 2015年 sky. All rights reserved.
//

#ifndef LingYou_DefineString_h
#define LingYou_DefineString_h
/**
 *  DefineString.h
 *
 *  @定义 一些宏去处理问题.(多用一些与文档)
 *
 * @描述 MK代码APP.前缀 (Mate GUKE)
 */

// 生产环境
//#define  DaBan_URL   @"http://gateway.dabanke.com:8088"
//#define IMAGE_URL  @"http://image.dabanke.com:8090"


// 开发环境
#define  DaBan_URL   @"http://10.156.0.181:8088/"
#define IMAGE_URL   @"http://10.156.0.181:8088/"

// 测试环境
//#define  DaBan_URL   @"http://182.92.157.210:8088/"
//#define IMAGE_URL   @"http://182.92.157.210:8088"

// 本地保存数据



#define MAPID   @"f687c3ced4e586f7e84d2628c0f9ad97"
/**
   登陆判断  为空为未登录
 */
#define LOGIN      [[NSUserDefaults standardUserDefaults] objectForKey:@"ACCESS_TOKEN"]

/**
   用户ID
 */
#define USERID     [[NSUserDefaults standardUserDefaults] objectForKey:@"USERID"]

/**
   手机号
 */
#define MOBILE     [[NSUserDefaults standardUserDefaults] objectForKey:@"mobilephone1"];

/**
   用户名称
 */
#define USERNAME   [[NSUserDefaults standardUserDefaults] objectForKey:@"userName1"];

/**
   二维码图像
 */
#define CODEIMAGE  [[NSUserDefaults standardUserDefaults] objectForKey:@"codeIamge1"];

/**
   用户头像
 */
#define ICON       [[NSUserDefaults standardUserDefaults] objectForKey:@"icon2"];

#define LingYouLogInNotification  @"LingYouLogInNotification"

//微信支付后的返回通知
#define WXPAY_NOTIFICATION     @"weixinPayResultReturn"

//微信支付后的返回通知
#define WXAUTH_NOTIFICATION     @"weixinAuthLogin"


/**
   游客/导游  USERTYPE为1是游客   USERTYPE为2是导游
 */
#define USERTYPE     [[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];

#endif
