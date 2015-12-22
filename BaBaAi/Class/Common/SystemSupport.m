//
//  SystemSupport.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "SystemSupport.h"
#import <UIKit/UIKit.h>

@implementation SystemSupport

+(SystemSupport *)share{
    static dispatch_once_t pred;
    static SystemSupport *instare = nil;
    dispatch_once(&pred,^{instare = [[self alloc]init];
    });
    return instare;
}

-(UIImage *)imageOfFile:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

+ (NSBundle *)mainBundle{
    NSBundle *myBundle = [NSBundle mainBundle];
    return myBundle;
}
@end
