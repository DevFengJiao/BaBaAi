//
//  MrStatus.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseModel.h"

@interface MrStatus : BaseModel
@property(nonatomic,strong) NSString* userId; //用户ID
@property(nonatomic,strong) NSString* childId;
@property(nonatomic,strong) NSString* imei; //手表IMEI号  imei

@property(nonatomic,strong) NSString* lut; //最后更新的时间
@property (readwrite) int no;//    seq
@property (readwrite) int enabled;// enabled
@property(nonatomic,strong) NSString* range; // 插入
@property(nonatomic,strong) NSString* luUserId;
@property(nonatomic,strong) NSString* luUserName;

//Extension
@property (nonatomic,strong) NSString* fromTime;   //start
@property (nonatomic,strong) NSString* toTime;     //end

- (NSString*) timeRange;
- (BOOL) validateRange;
- (void) setUserId:(NSString *)userId;

@end
