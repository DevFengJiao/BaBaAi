//
//  ParameterModel.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseModel.h"

@interface ParameterModel : BaseModel
@property(nonatomic,strong) NSString* sImei;       //对应的IMEI 号
@property(nonatomic,strong) NSString* sParaName;   //参数名称
@property(nonatomic,strong) NSString* sParaValue;  //参数值
@property(readwrite) int iEnabled;    //开关 0 为关闭 1为开启

-(id)initByDic:(NSDictionary*)dic;
@end
