//
//  MapSetting.h
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>


@interface MapSetting : NSObject

/*!
 @brief 地图语言
 */
@property (nonatomic, assign) MAMapLanguage language;

/**
 * @brief 实例化对象
 */
+(instancetype)share;

/**
 * 初始化地图
 */
- (void) setMapConfigs:(NSString *)mapKey;

/**
 * 地图语言
 */
- (MAMapLanguage ) setlanguage;


@end
