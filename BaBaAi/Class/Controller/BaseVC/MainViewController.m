//
//  MainViewController.m
//
//  Created by Seven on 15/5/26.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "MainViewController.h"
#import "FindViewController.h"
#import "LocationViewController.h"
#import "PhotoViewController.h"
#import "RelationViewController.h"
#import "SettingViewController.h"


/**
 *  消息 好友变化 群主变化, 登录状态 自动登录 CallManagerDelegate.
 */

//两次提示的默认间隔 震动响铃的时间
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface MainViewController ()<UIAlertViewDelegate>
{
    
}
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation MainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"巴巴爱";
//    self.view.backgroundColor = [UIColor navbackgroundColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
