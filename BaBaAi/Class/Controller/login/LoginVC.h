//
//  LoginVC.h
//  LBKidsApp
//
//  Created by kingly on 15/7/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//



@interface LoginVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *sLine;
@property (weak, nonatomic) IBOutlet UIView *zLine;
@property (weak, nonatomic) IBOutlet UIView *xLine;
@property (weak, nonatomic) IBOutlet UIImageView *loginImg;

@property (weak, nonatomic) IBOutlet UITextField *phoneText;    //手机号
@property (weak, nonatomic) IBOutlet UITextField *passwdText;   //密码
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;        //登录按钮

//登录按钮点击
- (IBAction)loginClick:(id)sender;
- (IBAction)loginClickhighted:(id)sender;
- (IBAction)regbtnClick:(id)sender;
- (IBAction)findPwdOnclick:(id)sender;


@end
