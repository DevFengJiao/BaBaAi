//
//  TBChild.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "TBChild.h"

@implementation TBChild
+ (TBChild *)shareDB
{
    
    static dispatch_once_t pred;
    static TBChild * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}
- (NSMutableArray *) findByWhere:(NSString *)where{
    return nil;
}
-(ChildModel *)getChildByImei:(NSString *)sImei{
//    ChildModel *model = [self getChildByImei:sImei];
    return nil;
}
@end
