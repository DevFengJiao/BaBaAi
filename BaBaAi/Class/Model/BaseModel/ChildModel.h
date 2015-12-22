//
//  ChildModel.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseModel.h"

@interface ChildModel : BaseModel

@property(readwrite) unsigned long long   llWearId; //用户ID
@property(nonatomic,strong) NSString* simei; //手表IMEI号
@property(nonatomic,strong) NSString* sChildName; //最大长度为32个英文字符
@property(nonatomic,strong) NSString* sWatchphone; //手表手机号

@property(readwrite) int iGender; //性别，1表示男性，0表示女性,不填表示保密
@property(nonatomic,strong) NSString* sbirthdate; //出生日期(date of birth)，精确到天的8位紧凑时间格式,如20081223
@property(readwrite) int iHeight; //身高cm，如135

@property(readwrite) float fWeight; //体重kg，如32.5

@property(readwrite) float Fwengi;

@property(nonatomic,strong) NSString* sCreatedTime;

@property(readwrite) int iRelationship; //亲属关系的索引值

@property(readwrite) int iRelationshipPic; //亲属关系的索引值

@property(readwrite) int iMarkPicID;     //大头针id

@property(nonatomic,strong) NSString* sPhone; //本机号码

@property(nonatomic,weak) UIImage *selectPicture;//相机相册中选择的图片

@property(nonatomic,weak) NSString *sPicturePath; //本地图片路径


@property(nonatomic,weak) NSData *childLogoData; //用户头像 二进制流

@property(nonatomic,copy) NSString *sFileType;  //头像格式 （jpg,png）

@property(readwrite) NSUInteger iChildLogoLenght; //头像的长度

@property(readwrite) unsigned long long   llavatarPicID; //头像ID

-(id)initByDic:(NSDictionary*)dic;

@end
