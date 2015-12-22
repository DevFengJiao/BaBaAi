//
//  RegVC.h
//  LBKidsApp
//
//  Created by kingly on 15/7/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//


@protocol registerDoneDelegate;
@interface RegVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *sLine;
@property (weak, nonatomic) IBOutlet UIView *zLine;
@property (weak, nonatomic) IBOutlet UIView *xLine;
@property (weak, nonatomic) IBOutlet UIView *dLine;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;  //手机号码
@property (weak, nonatomic) IBOutlet UITextField *passwdText; //密码
@property (weak, nonatomic) IBOutlet UITextField *emailText;  //email
@property (weak, nonatomic) IBOutlet UIButton *regBtn;

- (IBAction)regSubmitOnclick:(id)sender;
- (IBAction)regSubmitHighted:(id)sender;

@property (nonatomic,weak) id <registerDoneDelegate>delegate;

@end

@protocol registerDoneDelegate <NSObject>

-(void)registerDoneWithAccount:(NSString *)account Andpassword:(NSString *)password;

@end
