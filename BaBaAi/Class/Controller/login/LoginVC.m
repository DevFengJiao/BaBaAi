//
//  LoginVC.m
//  LBKidsApp
//
//  Created by kingly on 15/7/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "LoginVC.h"
#import "RegVC.h"
#import "FindPasswordVC.h"
#import "FindPwdVC.h"


@interface LoginVC ()<UITextFieldDelegate,UIScrollViewDelegate,ITcpClient,registerDoneDelegate>
{
    
    CGFloat scrollViewChangeHeight;//scrollview的高度变化
}
@end

@implementation LoginVC

-(void)loadView
{
    [super loadView];
    
    self.isHomePage = YES;//标记后不显示返回箭头
    
    [self addObserver];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];
    [self addGestureForView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self navCustomViewHidden];
    [self navigationBarHidden];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //如果用户名与密码都存在的时候，自动登录
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KUser_sUsername]!=nil) {
        self.phoneText.text = [[NSUserDefaults standardUserDefaults] objectForKey:KUser_sUsername];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:KUser_sPassword]!=nil) {
            self.passwdText.text = [[NSUserDefaults standardUserDefaults] objectForKey:KUser_sPassword];
            
//            [self userLogin];
            
        }
    }
    
    //显示小孩头像
    _loginImg.layer.cornerRadius = _loginImg.bounds.size.height/2;
    _loginImg.clipsToBounds = YES;
    _loginImg.contentMode = UIViewContentModeScaleAspectFill;
    _loginImg.image = [[FileManagerHelper share] getImageViewFromImage:self.currChildModel.llWearId];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    
    [self navigationBarShow];
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
#pragma mark - 自定义视图
/**
 * 自定义视图
 */
-(void)loadCustomView{
    
    [self.myScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight+1)];
    
    self.sLine.frame = CGRectMake(self.sLine.frame.origin.x, self.sLine.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.sLine.backgroundColor = [UIColor lineColor];
    self.zLine.frame = CGRectMake(self.zLine.frame.origin.x, self.zLine.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.zLine.backgroundColor = [UIColor lineColor];
    self.xLine.frame = CGRectMake(self.xLine.frame.origin.x, self.xLine.frame.origin.y, kScreenWidth, 1/kScreenScale);
    self.xLine.backgroundColor = [UIColor lineColor];
    
    self.myScrollView.delegate = self;
    
    //登录按钮
    [self.loginBtn setTitleColor:[UIColor BtnTitleColor] forState:UIControlStateNormal];
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.enabled = NO;
    self.loginBtn.backgroundColor = [UIColor grayColor];
    [self.loginBtn.layer setCornerRadius:3.0f];
    
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
    
    [self viewDownward];//view下移
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self keyBoardhidden];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self viewUpward];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self viewDownward];
}
/**
 * view上移
 */
-(void)viewUpward
{
    scrollViewChangeHeight = 80;
    
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
    if ([NSString isBlankString:self.phoneText.text] != YES && [NSString isBlankString:self.passwdText.text] != YES) {
        self.loginBtn.enabled = YES;
        self.loginBtn.backgroundColor = [UIColor BtnBgColor];
    }else{
        self.loginBtn.enabled = NO;
        self.loginBtn.backgroundColor = [UIColor grayColor];
    }
}

#pragma mark - 点击登录按钮
- (IBAction)loginClick:(id)sender {
    [self keyBoardhidden];
    self.loginBtn.backgroundColor = [UIColor BtnBgColor];
    [self userLogin];
}

- (IBAction)loginClickhighted:(id)sender {
    self.loginBtn.backgroundColor = [UIColor BtnBgHightedColor];
    
}
#pragma mark - 点击注册按钮
- (IBAction)regbtnClick:(id)sender {
    RegVC *regVC = [[RegVC alloc] initWithNibName:@"RegVC" bundle:nil];
    regVC.delegate = self;
    [self.navigationController pushViewController:regVC animated:YES];
}
#pragma mark - 点击忘记密码按钮
- (IBAction)findPwdOnclick:(id)sender {
    FindPwdVC *findPwdVC = [[FindPwdVC alloc] initWithNibName:@"FindPwdVC" bundle:nil];
    [self.navigationController pushViewController:findPwdVC animated:YES];
}

#pragma mark ITcpClient
/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt{
    
    NSLog(@"发送到服务器端的数据");
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSDictionary *)recivedTxt{
    
    self.loginBtn.enabled = YES;
    self.loginBtn.backgroundColor = [UIColor BtnBgColor];
    
    if ([self checkSocketRespClass:recivedTxt]){
        
        if ([self getCommod]!=nil) {
            
            if ([[self getCommod] isEqualToString:@"R_LOGIN"] == YES) {
                //接受登录的数据
                NSDictionary *bodyInfo = [self getParaDic];
                
                
                //设置用户数据
                NSString *photext = [NSString stringWithFormat:@"%@",[NSString whitespace:self.phoneText.text]];
                NSString *passwd  = [NSString stringWithFormat:@"%@",[NSString whitespace:self.passwdText.text]];
                
                [[NSUserDefaults standardUserDefaults]setObject:photext forKey:KUser_sUsername];
                [[NSUserDefaults standardUserDefaults]setObject:passwd  forKey:KUser_sPassword];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                self.passwdText.text = @"";
                
                [RecvNoteData recvLoginInfoWith:bodyInfo];
                
                [[TcpClient sharedInstance] removeLoginTempDataPacket];
                [[TcpClient sharedInstance] startHeartRateTimer];
                
                [self requestRelativeMobile:[[UserHandle standardHandle]sImei]];
                //登录成功，显示主界面
                
                [self showTabBar:self];
                
            }else if ([[self getCommod] isEqualToString:@"R_Q_FM"] == YES) {
                //接受登录的数据
                NSDictionary *bodyInfo = [self getParaDic];
                
                [RecvNoteData recvRelativeInfoWith:bodyInfo];
                
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
#pragma mark - registerDoneDelegate
/**
 * 注册完成后的协议方法(自动登录)
 */
-(void)registerDoneWithAccount:(NSString *)account Andpassword:(NSString *)password
{
    self.phoneText.text = account;
    self.passwdText.text = password;
    
//    [self userLogin];
}
#pragma mark - 账号登陆
/**
 * 账号登录后保存用户信息
 */
-(void)userLogin
{
    if ([self checkStringFormat]) {
        
        UserHandle *userHandle = [UserHandle standardHandle];
        [userHandle setLoginInfo:self.phoneText.text];
        [userHandle setPasswordInfo:self.passwdText.text];
        
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        if(tcp.asyncSocket.isDisconnected)
        {
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
            return;
        }else if(tcp.asyncSocket.isConnected)
        {
            self.loginBtn.enabled = NO;
            self.loginBtn.backgroundColor = [UIColor grayColor];
            
            DataPacket *dataPacket    = [[DataPacket alloc] init];
            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
            dataPacket.sCommand       = @"LOGIN";
            dataPacket.paraDictionary = [userHandle paraInfoDic];
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
            
        }else{
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
            return;
        }
        
        
    }
}

/**
 * 检查输入项格式
 */
-(BOOL)checkStringFormat
{
    NSString *msg;
    NSInteger phonelength = [self.phoneText.text stringLenth];
    NSInteger passwdlength = [self.passwdText.text stringLenth];
    
    if (phonelength != 11) {
        msg =  MLString(@"请输入正确的手机号码！");
    }else if (passwdlength < PasswordMinLength || passwdlength > PasswordMaxLength) {
        msg =  MLString(@"请输入6~20个字符的密码！");
    }
    if (msg.length != 0) {
        [SVProgressHUD showErrorWithStatus:msg];
        return NO;
    }
    return YES;
}


/**
 * 请求 亲情号码
 */
-(void)requestRelativeMobile:(NSString *)simei{
    
    if (simei.length!=0) {
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *para  = @{@"imei":simei};
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        if(tcp.asyncSocket.isDisconnected)
        {
            //        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
            return;
        }else if(tcp.asyncSocket.isConnected)
        {
            
            DataPacket *dataPacket    = [[DataPacket alloc] init];
            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
            dataPacket.sCommand       = @"Q_FM";
            dataPacket.paraDictionary = mutableDictionary;
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
            
        }else{
            //        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
            return;
        }
        //        });
        
    }
    
}





@end
