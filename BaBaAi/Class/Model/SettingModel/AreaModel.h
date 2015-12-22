//
//  AreaModel.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseModel.h"

@interface AreaModel : BaseModel

@property(readwrite) unsigned long long   llWearId; //用户ID
@property(nonatomic,strong) NSString* simei;        //手表IMEI号
@property(nonatomic,strong) NSString* sAreadata;    //地址集合

-(id)initByDic:(NSDictionary*)dic;
-(id)initByDictionary:(NSDictionary*)dic;
@end
