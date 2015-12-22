//
//  RegVC.m
//  LBKidsApp
//
//  Created by kingly on 15/7/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "RegVC.h"
#import "LBinKidsApp.h"

@interface RegVC ()<UITextFieldDelegate,UIScrollViewDelegate,ITcpClient>{

    unsigned int memberID;
    CGFloat scrollViewChangeHeight;//scrollview的高度变化
}
@end

@implementation RegVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册账号";

    
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
    
    self.sLine.frame = CGRectMake(self.sLine.frame.origin.x, self.sLine.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.sLine.backgroundColor = [UIColor lineColor];
    self.zLine.frame = CGRectMake(self.zLine.frame.origin.x, self.zLine.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.zLine.backgroundColor = [UIColor lineColor];
    self.xLine.frame = CGRectMake(self.xLine.frame.origin.x, self.xLine.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.xLine.backgroundColor = [UIColor lineColor];
    self.dLine.frame = CGRectMake(self.dLine.frame.origin.x, self.dLine.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.dLine.backgroundColor = [UIColor lineColor];
    
    //注册按钮
    self.regBtn.backgroundColor = [UIColor grayColor];
    [self.regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.regBtn.clipsToBounds = YES;
    self.regBtn.enabled = NO;

    [self.regBtn.layer setCornerRadius:3.0f];
    

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

/**
 * textfield文本变更的通知
 * 设置login登陆按钮可使用状态
 */
-(void)textfieldChange
{
    if ([NSString isBlankString:self.phoneText.text] != YES && [NSString isBlankString:self.passwdText.text] != YES && [NSString isBlankString:self.emailText.text] != YES) {
        self.regBtn.enabled = YES;
        self.regBtn.backgroundColor = [UIColor BtnBgColor];
    }else{
        self.regBtn.enabled = NO;
        self.regBtn.backgroundColor = [UIColor grayColor];
    }
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
    [self.phoneText resignFirstResponder];
    [self.passwdText resignFirstResponder];
    [self.emailText resignFirstResponder];
}


#pragma mark - 注册按钮提交
- (IBAction)regSubmitOnclick:(id)sender {
   
    self.regBtn.backgroundColor = [UIColor BtnBgColor];
    if([self checkStringFormat])
    {
        
        NSDictionary *para  = @{@"password":self.passwdText.text,
                                @"phone":self.phoneText.text,
                                @"clientID":[[LBinKidsApp share] clientID],
                                @"email":self.emailText.text};
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        
        
        
        if(tcp.asyncSocket.isDisconnected)
        {
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
            return;
        }
//        else if(tcp.asyncSocket.isConnected)
//        {
            self.regBtn.enabled = NO;
            self.regBtn.backgroundColor = [UIColor grayColor];
            
            DataPacket *dataPacket    = [[DataPacket alloc] init];
            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
            dataPacket.sCommand       = @"REG";
            dataPacket.paraDictionary = mutableDictionary;
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
        
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
//            return;
//        }
//        
    }
}

- (IBAction)regSubmitHighted:(id)sender {
    self.regBtn.backgroundColor = [UIColor BtnBgHightedColor];
}

/**
 * 检查输入项格式
 */
-(BOOL)checkStringFormat
{
    NSString *msg;
    NSInteger phonelength = [self.phoneText.text stringLenth];
    NSInteger passwdlength = [self.passwdText.text stringLenth];
    NSInteger emailTextlength = [self.emailText.text stringLenth];
    if (phonelength != 11) {
        msg =  MLString(@"请输入正确的手机号码！");
    }else if (passwdlength < PasswordMinLength || passwdlength > PasswordMaxLength) {
        msg =  MLString(@"请输入6~20个字符的密码！");
    }else if (emailTextlength == 0) {
        msg =  MLString(@"请输入email！");
    }else if (![NSString isValidateEmail:self.emailText.text]){
        msg =  MLString(@"电子邮箱格式不对！");
    }else if(emailTextlength >= EmailMaxLength){
        msg = [NSString stringWithFormat:MLString(@"邮箱的最大长度是%d."),EmailMaxLength];
    }
    if (msg.length != 0) {
//        [SVProgressHUD showErrorWithStatus:msg];
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
        [self.navigationController popViewControllerAnimated:YES];
        if (_delegate && [_delegate respondsToSelector:@selector(registerDoneWithAccount:Andpassword:)]) {
            [_delegate registerDoneWithAccount:self.phoneText.text Andpassword:self.passwdText.text];
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self keyBoardhidden];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [self viewUpward];
    
    if (kIphone4S) {
        
        if ([textField isEqual:self.passwdText]){
            [self viewUpwardWithMargin:20];//视图上移
        }else if ([textField isEqual:self.emailText]){
            [self viewUpwardWithMargin:50];//视图上移
        }
    }
    

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self viewDownward];
}
/**
 * view上移
 */
-(void)viewUpwardWithMargin:(float )heigth
{
    scrollViewChangeHeight = heigth;
    
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

@end
