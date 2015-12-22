//
//  RecvNoteData.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewController.h"
#import "ChildModel.h"
#import "ParameterModel.h"
@interface RecvNoteData : BaseViewController

+(RecvNoteData *)share;
/**
 * 接受登陆的通知数据
 */
+(id)recvLoginInfoWith:(NSDictionary *)note;
/**
 * 接受亲情号码的通知数据
 */
+(void)recvRelativeInfoWith:(NSDictionary *)note;
/**
 *  获得小孩的头像
 */
-(void)requestChildLogo:(ChildModel *)cModel;
/**
 * 解析Parameters
 */
-(NSMutableArray *)getParametersArrWithArray:(NSArray *)parametersArr;
/**
 *  解析 电子栅栏
 */
-(NSMutableArray *)getfenceAreasArrWithArray:(NSArray *)fenceAreas;


@end
