//
//  FileManagerHelper.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "FileManagerHelper.h"

@implementation FileManagerHelper
+(FileManagerHelper *)share{
    static dispatch_once_t pred;
    static FileManagerHelper * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}
-(UIImage *)getImageViewFromImage:(unsigned long long)llWearId{
    return nil;
}
@end
