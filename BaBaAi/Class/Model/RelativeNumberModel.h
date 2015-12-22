//
//  RelativeNumberModel.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseDatabase.h"

@interface RelativeNumberModel : BaseDatabase

@property (nonatomic,strong)  NSString* sImei;       //对应的IMEI 号
@property (nonatomic,strong)  NSString* sMobile;     //亲情号码
@property (readwrite) int iSeq;                      //第几个

-(id)initByDic:(NSDictionary*)dic;
@end
