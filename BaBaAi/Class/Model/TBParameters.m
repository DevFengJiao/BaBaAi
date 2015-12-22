//
//  TBParameters.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "TBParameters.h"

@implementation TBParameters
+ (TBParameters *)shareCustomrModel
{
    
    static dispatch_once_t pred;
    static TBParameters * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}


-(ParameterModel *)findFirstByImei:(NSString *)sImei withParaName:(NSString *)sParaName{
    return nil;
}
@end
