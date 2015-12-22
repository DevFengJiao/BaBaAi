//
//  UserProtocolVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "UserProtocolVC.h"

@interface UserProtocolVC ()
{
    UIWebView   *myWebView;
}
@end

@implementation UserProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    myWebView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight)];
    [self.view addSubview:myWebView];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"agreement_cn" ofType:@"html"];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [myWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self navigationBarShow];
    [self tabbarHidden];
    
}


@end
