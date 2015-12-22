//
//  FindPwdVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/6.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "FindPwdVC.h"
#import "LBinKidsApp.h"

@interface FindPwdVC ()<ITcpClient>

@end

@implementation FindPwdVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    [self addObserver];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = MLString(@"找回密码");
    
    [self loadCustomView];
    [self addGestureForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([NSString isBlankString:self.phoneText.text] != YES ) {
        self.sendBtn.enabled = YES;
        self.sendBtn.backgroundColor = [UIColor BtnBgColor];
    }else{
        self.sendBtn.enabled = NO;
        self.sendBtn.backgroundColor = [UIColor grayColor];
    }
}

#pragma mark - 自定义视图
/**
 * 自定义视图
 */
-(void)loadCustomView{
    
    [self.myScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight+1)];
    
    self.xLineView.frame = CGRectMake(self.xLineView.frame.origin.x, self.xLineView.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.xLineView.backgroundColor = [UIColor lineColor];
    self.sLineView.frame = CGRectMake(self.sLineView.frame.origin.x, self.sLineView.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.sLineView.backgroundColor = [UIColor lineColor];
    
    self.NoteLabel.text = @"";
    //发送按钮
    self.sendBtn.backgroundColor = [UIColor grayColor];
    [self.sendBtn setTitleColor:[UIColor BtnTitleColor] forState:UIControlStateNormal];
    self.sendBtn.clipsToBounds = YES;
    self.sendBtn.enabled = NO;
    [self.sendBtn.layer setCornerRadius:3.0f];
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
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self keyBoardhidden];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


#pragma mark - 发送短信
- (IBAction)onClickSendBtn:(id)sender {
    self.sendBtn.backgroundColor = [UIColor BtnBgColor];
    [self sendMsg];
}

- (IBAction)OnClickSendHighted:(id)sender {
    self.sendBtn.backgroundColor = [UIColor BtnBgHightedColor];
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
        //        [[NSUserDefaults standardUserDefaults]setObject:phoneText.text forKey:kUser_sPhoneNum];
        //        [[NSUserDefaults standardUserDefaults]setObject:[MD5String MD5:newPwdText.text] forKey:kUser_sPassword];
//        [self.navigationController popViewControllerAnimated:YES];
//        if (_delegate && [_delegate respondsToSelector:@selector(registerDoneWithAccount:Andpassword:)]) {
//            [_delegate registerDoneWithAccount:self.phoneText.text Andpassword:self.passwdText.text];
//        }
//
        self.NoteLabel.text = MLString(@"找回密码成功，系统将生成随机密码发送到你的注册邮箱");
        
    }else{
        self.NoteLabel.text = @"";
        [SVProgressHUD showErrorWithStatus:[self getError]];
        return;
    }
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    
    NSLog(@"socket连接出现错误");
    self.NoteLabel.text = @"";
    
}
#pragma mark - 发送修改密码
-(void)sendMsg{

    NSInteger phonelength = [self.phoneText.text stringLenth];
    if (phonelength != 11) {
        [SVProgressHUD showErrorWithStatus:MLString(@"请输入正确的手机号码！")];
        return;
    }
    
    TcpClient *tcp = [TcpClient sharedInstance];
    [tcp setDelegate_ITcpClient:self];
    if(tcp.asyncSocket.isDisconnected)
    {
        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
        return;
    }else if(tcp.asyncSocket.isConnected)
    {
        self.sendBtn.enabled = NO;
        self.sendBtn.backgroundColor = [UIColor grayColor];
        
        NSDictionary *para  = @{@"phone":self.phoneText.text,
                                @"clientID":[[LBinKidsApp share] clientID]
                                };
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
        
        DataPacket *dataPacket    = [[DataPacket alloc] init];
        dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
        dataPacket.sCommand       = @"F_PASSWORD";
        dataPacket.paraDictionary = mutableDictionary;
        dataPacket.iType          = 0;
        [tcp sendContent:dataPacket];
        
    }else{
        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
        return;
    }

   
    
}


@end
