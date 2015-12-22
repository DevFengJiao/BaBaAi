//
//  TBArea.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/10.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "TBArea.h"

@implementation TBArea
+ (TBArea *)shareDB
{
    
    static dispatch_once_t pred;
    static TBArea * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}

- (void)insertArea:(AreaModel *)temp{

}
/**
 * 根据llWearId号获得该对象
 */
-(AreaModel *)getAreaByllWearId:(unsigned long long  )llWearId{
    return nil;
}
@end
