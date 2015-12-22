//
//  GlobalStyle.h
//  LingYou
//
//  Created by Seven on 15/5/18.
//  Copyright (c) 2015年 sky. All rights reserved.
//

/**
 *  GlobalStyle.h
 *
 *  @定义 一些宏去处理问题.(多用一些颜色,全局的颜色方法)
 *
 *  @描述 MK代码APP.前缀 (Mate GUKE)
 */

//以下 方法选择自己喜爱的都可以.

//16进制的.
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//非16进制的.
#define MK_RGBCOLOR(r,g,b)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define MK_RGBACOLOR(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define MK_SectionColor         [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]

//边框颜色 类似tableViewCell的分隔线
#define MK_BorderColor              MK_RGBCOLOR(215,215,215)        //#d7d7d7




