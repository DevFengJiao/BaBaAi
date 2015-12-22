//
//  MapSetting.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "MapSetting.h"


@interface MapSetting ()
{
    NSString *mapApikey;//地图的key
}

@end

@implementation MapSetting


/**
 * @brief 实例化对象
 */
+(instancetype)share
{
    return [[MapSetting alloc]init];
}

-(instancetype)init
{
    if (self = [super init]) {
        mapApikey = @"f687c3ced4e586f7e84d2628c0f9ad97";
    }
    return self;
}

- (void) setMapConfigs:(NSString *)mapKey{
    NSString *apikey = (mapKey==nil)?mapApikey:mapKey;
    [MAMapServices sharedServices].apiKey = (NSString *)apikey;
}

/**
 * 地图语言
 */
- (MAMapLanguage ) setlanguage{
    MAMapLanguage culang;
    if ([[[UserHandle standardHandle] currLanguage] isEqualToString:@"cn"] == YES) {
        culang = MAMapLanguageZhCN;
    }else{
        culang = MAMapLanguageEn;
    }
    return culang;
}

@end
