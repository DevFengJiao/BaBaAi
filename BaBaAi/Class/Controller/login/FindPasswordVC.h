//
//  FindPasswordVC.h
//  LBKidsApp
//
//  Created by kingly on 15/7/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//



@interface FindPasswordVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *line01;
@property (weak, nonatomic) IBOutlet UIView *line02;
@property (weak, nonatomic) IBOutlet UIView *line03;
@property (weak, nonatomic) IBOutlet UIView *line04;
@property (weak, nonatomic) IBOutlet UIView *line05;
@property (weak, nonatomic) IBOutlet UIView *line06;
@property (weak, nonatomic) IBOutlet UIView *line07;
@property (weak, nonatomic) IBOutlet UITextField *currPassedText;
@property (weak, nonatomic) IBOutlet UITextField *passwdText;
@property (weak, nonatomic) IBOutlet UITextField *qrpasswdText;
@property (weak, nonatomic) IBOutlet UIButton *findPasswdBtn;
- (IBAction)findpwdSubmitBtn:(id)sender;
- (IBAction)findpwdSubmitHighted:(id)sender;

@end
