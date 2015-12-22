//
//  RelationViewController.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "RelationViewController.h"
#import "EditChildVC.h"
#import "PhotoViewController.h"

@interface RelationViewController ()<ITcpClient,UITableViewDataSource,UITableViewDelegate>

@end

@implementation RelationViewController

-(void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];

    [self addObservers];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.isHeadView = YES;
    [self navigationBarHidden];
    [self tabbarShow];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}



-(void)loadCustomView{
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavgationBarHeight, kScreenWidth, kScreenHeight-kTabBarHeight-44-kNavgationBarHeight)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.myTableView.frame), kScreenWidth, 0.8);
    self.lineView.backgroundColor = [UIColor lineColor];
    [self.view addSubview:self.lineView];
    
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame), kScreenWidth, 42.2)];
    _footerView.backgroundColor = [UIColor colorWithRed:220.0/255.0f green:220/255.0f blue:220/255.0f alpha:1];
    [self.view addSubview:_footerView];
    
    
    self.telBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, 32.2, 32.2)];
    self.telBtn.backgroundColor = [UIColor clearColor];
    [self.telBtn setBackgroundImage:[UIImage imageNamed:@"ic_call_new"] forState:UIControlStateNormal];
    [self.telBtn addTarget:self action:@selector(phoneCallAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.telBtn];
    
    _sendVoiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, 5, 200, 32.2)];
    _sendVoiceBtn.backgroundColor = [UIColor whiteColor];
    [_sendVoiceBtn setTitleColor:[UIColor colorWithHexString:@"#696969"] forState:UIControlStateNormal];
    _sendVoiceBtn.layer.borderWidth  = 1/kScreenScale;
    _sendVoiceBtn.layer.borderColor  = [[UIColor lineColor] CGColor];
    _sendVoiceBtn.clipsToBounds = YES;
    [_sendVoiceBtn setTitle:@"按住说话" forState:UIControlStateNormal];
    [_sendVoiceBtn.layer setCornerRadius:5.0f];
    [_sendVoiceBtn addTarget:self action:@selector(sendVoiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_sendVoiceBtn];
    
    self.playBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-15-32.2, 5, 32.2, 32.2)];
    self.playBtn.backgroundColor = [UIColor clearColor];
    [self.playBtn setBackgroundImage:[UIImage imageNamed:@"ic_callback_new"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(PlaybackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:self.playBtn];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];//注销观察者
}

#pragma mark - Notification
/**
 * 接受小孩对象切换
 */
-(void)addObservers{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recvChildChangeNoti:) name:KReloadChildChangeInfoNotification object:nil];
    
}

/**
 * 收到小孩对象切换的通知
 * 进行界面刷新
 */
-(void)recvChildChangeNoti:(NSNotification *)note
{
    //重新加载顶部视图
    [self reloadNavData];
    
    
}

#pragma mark - 发送语音
- (void)sendVoiceAction:(UIButton *)sender {
    
    
}
#pragma mark - 给小孩打电话
- (void)phoneCallAction:(UIButton *)sender {
    
    if(self.currChildModel.sWatchphone.length == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:MLString(@"温馨提示") message:MLString(@"请填写手表电话后，再使用！") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *submitAct = [UIAlertAction actionWithTitle:MLString(@"知道了") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        
        [alert addAction:submitAct];
        [self presentViewController:alert animated:YES completion:^{}];
        return;
    }else{
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.currChildModel.sWatchphone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }
    
}
#pragma mark - 回拨监听
- (void)PlaybackAction:(UIButton *)sender {
    
    if(self.currChildModel.sPhone.length == 0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:MLString(@"温馨提示") message:MLString(@"请填写本机电话后，再使用！") preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *submitAct = [UIAlertAction actionWithTitle:MLString(@"知道了") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
        }];
        
        [alert addAction:submitAct];
        [self presentViewController:alert animated:YES completion:^{}];
        return;
    }else{
        
        
        NSDictionary *para  = @{@"imei":self.currChildModel.simei,
                                @"operation":@"DIALBACK",
                                @"tag":self.currChildModel.sPhone
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
            
            DataPacket *dataPacket    = [[DataPacket alloc] init];
            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
            dataPacket.sCommand       = @"N_OP";
            dataPacket.paraDictionary = mutableDictionary;
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
            
        }else{
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
            return;
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentf = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentf];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentf];
    }
//    cell.textLabel.text = @"This is tableview";
    return cell;
}

#pragma mark ITcpClient
/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt{
    
    NSLog(@"发送到服务器端的数据");
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSDictionary *)recivedTxt{
    if ([self checkSocketRespClass:recivedTxt]){
        if ([self getCommod]!=nil) {
            
            if ([[self getCommod] isEqualToString:@"R_N_OP"] == YES) {
                
                NSDictionary *bodyInfo = [self getParaDic];
                
                NSLog(@"R_N_OP：：：%@",bodyInfo);
                
                NSString *operation = [NSString isNullObjwithNSString:[bodyInfo objectForKey:@"operation"]];
                if ([operation isEqualToString:@"DIALBACK"] == YES) {
                    //回拨监听
                    NSLog(@"回拨监听");
                }else if ([operation isEqualToString:@"CALLLOC"] == YES) {
                    //单次定位
                    NSLog(@"单次定位");
                }
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
