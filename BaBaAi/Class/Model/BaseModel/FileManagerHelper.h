//
//  FileManagerHelper.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManagerHelper : NSObject
+(FileManagerHelper*)share;
/*
 * 获得小孩的头像
 */
-(UIImage *)getImageViewFromImage:(unsigned long long)llWearId;
@end
