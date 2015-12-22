//
//  SystemSupport.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemSupport : NSObject

+(SystemSupport*)share;
/**
 * 图片扩展
 */
-(UIImage *)imageOfFile:(NSString *)name;
/*
 * 获得主Bundle
 */
+ (NSBundle *)mainBundle;
@end
