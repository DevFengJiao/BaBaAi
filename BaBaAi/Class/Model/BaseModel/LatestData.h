//
//  LatestData.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseModel.h"


@interface LatestData : BaseModel
@property(nonatomic,strong) NSString* sImei; //手表IMEI号

@property(nonatomic,strong) NSString* sTime; //更新时间


@property(readwrite) int iPower; // 电量

@property(readwrite) unsigned long long   llStep; //计步器的数量

@property(readwrite) int iLocType;      //locType定位类型0:GPS,1:LBS,2:WIFI

@property(readwrite) float fLongitude;     //经度

@property(readwrite) float fLatitude;     //纬度

@property(nonatomic,strong) NSString* sAddress; //地址


-(id)initByDic:(NSDictionary*)dic;


@end

