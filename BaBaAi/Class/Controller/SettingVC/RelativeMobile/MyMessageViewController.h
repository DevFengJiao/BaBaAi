//
//  MyMessageViewController.h
//  BabaGoing
//
//  Created by 冯大师 on 15/11/23.
//  Copyright © 2015年 kingly. All rights reserved.
//



@interface MyMessageViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageview;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIButton *myBtn;

@property (nonatomic, strong) NSString *name;       //名字
@property (nonatomic, strong) NSString *telphone;   //电话
@property (nonatomic, strong) NSString *headImg;    //头像
@end
