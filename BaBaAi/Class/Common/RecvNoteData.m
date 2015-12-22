//
//  RecvNoteData.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/8.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "RecvNoteData.h"

@interface RecvNoteData ()

@end

@implementation RecvNoteData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(RecvNoteData *)share{
    static dispatch_once_t pred;
    static RecvNoteData * instance = nil;
    dispatch_once(&pred, ^{instance = [[self alloc] init];
    });
    return instance;
}
/**
 * 接受登陆的通知数据
 */
+(id)recvLoginInfoWith:(NSDictionary *)note{
    id my = [self recvLoginInfoWith:note];
    return my;
}
/**
 * 接受亲情号码的通知数据
 */
+(void)recvRelativeInfoWith:(NSDictionary *)note{
//    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
