//
//  FindPasswordVC.m
//  LBKidsApp
//
//  Created by kingly on 15/7/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "FindPasswordVC.h"


@interface FindPasswordVC ()<UITextFieldDelegate,UIScrollViewDelegate,ITcpClient>{

    CGFloat scrollViewChangeHeight;//scrollview的高度变化
    
    NSString *pwd;

}

@end

@implementation FindPasswordVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = MLString(@"修改密码");
    self.myScrollView.contentSize = CGSizeMake(0, 0);
    [self loadCustomView];
    [self addGestureForView];
    [self addObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - loadCustomView
-(void)loadCustomView{
    
    [self.myScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight+1)];
    
    self.line01.frame = CGRectMake(self.line01.frame.origin.x, self.line01.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.line01.backgroundColor = [UIColor lineColor];
    self.line02.frame = CGRectMake(self.line02.frame.origin.x, self.line02.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.line02.backgroundColor = [UIColor lineColor];
    self.line03.frame = CGRectMake(self.line03.frame.origin.x, self.line03.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.line03.backgroundColor = [UIColor lineColor];
    self.line04.frame = CGRectMake(self.line04.frame.origin.x, self.line04.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.line04.backgroundColor = [UIColor lineColor];
    self.line05.frame = CGRectMake(self.line05.frame.origin.x, self.line05.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.line05.backgroundColor = [UIColor lineColor];
    self.line06.frame = CGRectMake(self.line06.frame.origin.x, self.line06.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.line06.backgroundColor = [UIColor lineColor];
    self.line07.frame = CGRectMake(self.line07.frame.origin.x, self.line07.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.line07.backgroundColor = [UIColor lineColor];
    
    //修改密码按钮
    self.findPasswdBtn.backgroundColor = [UIColor grayColor];
    [self.findPasswdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.findPasswdBtn.clipsToBounds = YES;
    [self.findPasswdBtn.layer setCornerRadius:3.0f];
    
    _phoneLabel.text = [[UserHandle standardHandle] sMemberID];
    
    
}


#pragma mark - 添加观察者
/**
 * 添加观察者
 */
-(void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldChange) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 添加手势
/**
 * 添加手势
 */
-(void)addGestureForView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardhidden)];
    [self.view addGestureRecognizer:tap];
}

/**
 * 隐藏键盘
 */
-(void)keyBoardhidden
{
    [self.currPassedText resignFirstResponder];
    [self.passwdText resignFirstResponder];
    [self.qrpasswdText resignFirstResponder];
    
//    [self viewDownward];//view下移
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self keyBoardhidden];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.passwdText] || [textField isEqual:self.qrpasswdText]){
        scrollViewChangeHeight = textField.frame.origin.y;
//        [self viewUpwardWithMargin:100];
    }else{
//       [self viewUpwardWithMargin:44];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self viewDownward];
}
/**
 * view上移
 */
-(void)viewUpwardWithMargin:(CGFloat )changeHeight
{

        scrollViewChangeHeight = changeHeight;
   
    
    if (self.myScrollView.contentOffset.y != scrollViewChangeHeight) {
        [UIView animateWithDuration:0.35f animations:^{
            self.myScrollView.contentOffset = CGPointMake(self.myScrollView.contentOffset.x, scrollViewChangeHeight);
        }];
    }
}

/**
 * view下移
 */
-(void)viewDownward
{
    if (self.myScrollView.contentOffset.y != 0) {
        [UIView animateWithDuration:0.35f animations:^{
            self.myScrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
}

/**
 * textfield文本变更的通知
 * 设置login登陆按钮可使用状态
 */
-(void)textfieldChange
{
    if ([NSString isBlankString:self.passwdText.text] != YES && [NSString isBlankString:self.currPassedText.text] != YES && [NSString isBlankString:self.qrpasswdText.text] != YES) {
        self.findPasswdBtn.enabled = YES;
        self.findPasswdBtn.backgroundColor = [UIColor BtnBgColor];
    }else{
        self.findPasswdBtn.enabled = NO;
        self.findPasswdBtn.backgroundColor = [UIColor grayColor];
    }
}
#pragma mark - 点击密码修改按钮
- (IBAction)findpwdSubmitBtn:(id)sender {
    self.findPasswdBtn.backgroundColor = [UIColor BtnBgColor];
    
    if([self checkStringFormat]){
        
        NSDictionary *para  = @{@"oldPwd":self.currPassedText.text,
                                @"newPwd":self.passwdText.text,
                                };
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        if(tcp.asyncSocket.isDisconnected)
        {
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
            return;
        }else if(tcp.asyncSocket.isConnected)
        {
            self.findPasswdBtn.enabled = NO;
            self.findPasswdBtn.backgroundColor = [UIColor grayColor];
            
            pwd = self.passwdText.text;
            
            self.currPassedText.text = @"";
            self.passwdText.text     = @"";
            self.qrpasswdText.text     = @"";
            
            
            
            DataPacket *dataPacket    = [[DataPacket alloc] init];
            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
            dataPacket.sCommand       = @"U_PWD";
            dataPacket.paraDictionary = mutableDictionary;
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
            
        }else{
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
            return;
        }
        
    }

}

- (IBAction)findpwdSubmitHighted:(id)sender {
    self.findPasswdBtn.backgroundColor = [UIColor BtnBgHightedColor];
}

/**
 * 检查输入项格式
 */
-(BOOL)checkStringFormat
{
    NSString *msg;
    NSInteger passwdlength = [self.passwdText.text stringLenth];
    NSInteger currPassedTextLenght = [self.currPassedText.text stringLenth];
    
    if (currPassedTextLenght < PasswordMinLength || currPassedTextLenght > PasswordMaxLength) {
         msg =  MLString(@"请输入6~20个字符的密码！");
    }else if (passwdlength < PasswordMinLength || passwdlength > PasswordMaxLength) {
        msg =  MLString(@"请输入6~20个字符的密码！");
    }else if (![self.passwdText.text isEqualToString:self.qrpasswdText.text]) {
        msg =  MLString(@"两次输入的密码不一致！");
    }
    
    if (msg.length != 0) {
        [SVProgressHUD showErrorWithStatus:msg];
        return NO;
    }
    
    return YES;
}


#pragma mark ITcpClient
/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt{
    
    NSLog(@"发送到服务器端的数据");
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSDictionary *)recivedTxt{
    NSLog(@"收到服务器端,%@",recivedTxt);
    if ([self checkSocketRespClass:recivedTxt]){
        
        if ([self getCommod]!=nil) {
            
            if ([[self getCommod] isEqualToString:@"R_U_PWD"] == YES) {
                
                [[NSUserDefaults standardUserDefaults]setObject:pwd  forKey:KUser_sPassword];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
            }
        }
        
    }else{
        [SVProgressHUD showErrorWithStatus:[self getError]];
        return;
    }
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    
    NSLog(@"socket连接出现错误");
    
}




@end
