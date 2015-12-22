//
//  AddRelativeMobileVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "AddRelativeMobileVC.h"
//#import "<QuartzCore/QuartzCore.h>"
#import "RelativeNumberModel.h"
#import "TBRelativeNumber.h"


@interface AddRelativeMobileVC ()<UITextFieldDelegate,UIScrollViewDelegate>{

    NSMutableArray *relativeArr;
}

@end

@implementation AddRelativeMobileVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];
    [self addGestureForView];
    [self addObserver];
    
    [self getRelativeData];
    [self rightNavBarItemWithTitle:MLString(@"提交") AndSel:@selector(submitAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self tabbarHidden];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
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


#pragma mark - loadCustomView
-(void)loadCustomView{
    [self.myScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight+1)];

    _relativeNum01.bounds = CGRectMake(0, 0,_relativeNum01.frame.size.width, _relativeNum01.frame.size.height);
    _relativeNum01.layer.cornerRadius = _relativeNum01.bounds.size.height/2;
    _relativeNum01.clipsToBounds = YES;
    _relativeNum01.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum01.backgroundColor = [UIColor parentsMainColor];
    
    _relativeNum01View.layer.cornerRadius=5.0f;
    _relativeNum01View.layer.masksToBounds=YES;
    _relativeNum01View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum01View.layer.borderWidth= 1/kScreenScale;
    
    _relativeNum02.bounds = CGRectMake(0, 0,_relativeNum02.frame.size.width, _relativeNum02.frame.size.height);
    _relativeNum02.layer.cornerRadius = _relativeNum02.bounds.size.height/2;
    _relativeNum02.clipsToBounds = YES;
    _relativeNum02.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum02.backgroundColor = [UIColor parentsMainColor];
    
    _relativeNum02View.layer.cornerRadius=5.0f;
    _relativeNum02View.layer.masksToBounds=YES;
    _relativeNum02View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum02View.layer.borderWidth= 1/kScreenScale;

    
    _relativeNum03.bounds = CGRectMake(0, 0,_relativeNum03.frame.size.width, _relativeNum03.frame.size.height);
    _relativeNum03.layer.cornerRadius = _relativeNum03.bounds.size.height/2;
    _relativeNum03.clipsToBounds = YES;
    _relativeNum03.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum03.backgroundColor = [UIColor parentsMainColor];
    
    _relativeNum03View.layer.cornerRadius=5.0f;
    _relativeNum03View.layer.masksToBounds=YES;
    _relativeNum03View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum03View.layer.borderWidth= 1/kScreenScale;
    
    
    _relativeNum04.bounds = CGRectMake(0, 0,_relativeNum04.frame.size.width, _relativeNum04.frame.size.height);
    _relativeNum04.layer.cornerRadius = _relativeNum04.bounds.size.height/2;
    _relativeNum04.clipsToBounds = YES;
    _relativeNum04.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum04.backgroundColor = [UIColor parentsMainColor];
    
    _relativeNum04View.layer.cornerRadius=5.0f;
    _relativeNum04View.layer.masksToBounds=YES;
    _relativeNum04View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum04View.layer.borderWidth= 1/kScreenScale;
    
    _relativeNum05.bounds = CGRectMake(0, 0,_relativeNum05.frame.size.width, _relativeNum05.frame.size.height);
    _relativeNum05.layer.cornerRadius = _relativeNum05.bounds.size.height/2;
    _relativeNum05.clipsToBounds = YES;
    _relativeNum05.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum05.backgroundColor = [UIColor parentsOtherfamilyColor];
    
    _relativeNum05View.layer.cornerRadius=5.0f;
    _relativeNum05View.layer.masksToBounds=YES;
    _relativeNum05View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum05View.layer.borderWidth= 1/kScreenScale;

    
    _relativeNum06.bounds = CGRectMake(0, 0,_relativeNum06.frame.size.width, _relativeNum06.frame.size.height);
    _relativeNum06.layer.cornerRadius = _relativeNum06.bounds.size.height/2;
    _relativeNum06.clipsToBounds = YES;
    _relativeNum06.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum06.backgroundColor = [UIColor parentsOtherfamilyColor];
    
    _relativeNum06View.layer.cornerRadius=5.0f;
    _relativeNum06View.layer.masksToBounds=YES;
    _relativeNum06View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum06View.layer.borderWidth= 1/kScreenScale;

    
    _relativeNum07.bounds = CGRectMake(0, 0,_relativeNum07.frame.size.width, _relativeNum07.frame.size.height);
    _relativeNum07.layer.cornerRadius = _relativeNum07.bounds.size.height/2;
    _relativeNum07.clipsToBounds = YES;
    _relativeNum07.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum07.backgroundColor = [UIColor parentsOtherfamilyColor];
    
    _relativeNum07View.layer.cornerRadius=5.0f;
    _relativeNum07View.layer.masksToBounds=YES;
    _relativeNum07View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum07View.layer.borderWidth= 1/kScreenScale;

    
    _relativeNum08.bounds = CGRectMake(0, 0,_relativeNum08.frame.size.width, _relativeNum08.frame.size.height);
    _relativeNum08.layer.cornerRadius = _relativeNum08.bounds.size.height/2;
    _relativeNum08.clipsToBounds = YES;
    _relativeNum08.contentMode = UIViewContentModeScaleAspectFill;
    _relativeNum08.backgroundColor = [UIColor parentsOtherfamilyColor];
    
    _relativeNum08View.layer.cornerRadius=5.0f;
    _relativeNum08View.layer.masksToBounds=YES;
    _relativeNum08View.layer.borderColor=[[UIColor lineColor] CGColor];
    _relativeNum08View.layer.borderWidth= 1/kScreenScale;

    [self textPlaceholder];
    _noteLabel.text = MLString(@"1-3为主亲情号码，4-8为副亲情号码。");
    
    relativeArr = [NSMutableArray array];
}
/**
 * 设置text的Placeholder
 */
-(void)textPlaceholder{
  _relativeNum01Text.placeholder = MLString(@"主亲情号码");
  _relativeNum02Text.placeholder = MLString(@"主亲情号码");
  _relativeNum03Text.placeholder = MLString(@"主亲情号码");

  _relativeNum04Text.placeholder = MLString(@"主亲情号码");
  _relativeNum05Text.placeholder = MLString(@"副亲情号码");
  _relativeNum06Text.placeholder = MLString(@"副亲情号码");
  _relativeNum07Text.placeholder = MLString(@"副亲情号码");
  _relativeNum08Text.placeholder = MLString(@"副亲情号码");

}

/**
 * textfield文本变更的通知
 * 设置右侧按钮可使用状态
 */
-(void)textfieldChange
{

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
     [_relativeNum01Text resignFirstResponder];
     [_relativeNum02Text resignFirstResponder];
     [_relativeNum03Text resignFirstResponder];
     [_relativeNum04Text resignFirstResponder];
     [_relativeNum05Text resignFirstResponder];
     [_relativeNum06Text resignFirstResponder];
     [_relativeNum07Text resignFirstResponder];
     [_relativeNum08Text resignFirstResponder];
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
    
    //if (kIphone4S) {
        
        if ([textField isEqual:_relativeNum03Text]){
            [self viewUpwardWithMargin:30];//视图上移
        }else if ([textField isEqual:_relativeNum04Text]){
            [self viewUpwardWithMargin:44];//视图上移
        }else if ([textField isEqual:_relativeNum05Text]){
            [self viewUpwardWithMargin:88];//视图上移
        }else if ([textField isEqual:_relativeNum06Text]){
            [self viewUpwardWithMargin:132];//视图上移
        }else if ([textField isEqual:_relativeNum07Text]){
            [self viewUpwardWithMargin:176];//视图上移
        }else if ([textField isEqual:_relativeNum08Text]){
            [self viewUpwardWithMargin:210];//视图上移
        }
   // }
    
    
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
    if (self.myScrollView.contentOffset.y != heigth) {
        [UIView animateWithDuration:0.35f animations:^{
            self.myScrollView.contentOffset = CGPointMake(self.myScrollView.contentOffset.x, heigth);
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

#pragma mark - 获得电话请求
-(void)getRelativeData{

    NSMutableArray *rArr = [[TBRelativeNumber shareDB] findBysImei];
    if (rArr.count>0) {

        for (int i=0; i<rArr.count; i++) {
            RelativeNumberModel *rModel = [rArr objectAtIndex:i];
            if ([NSString isBlankString:rModel.sMobile]) {
               
                if (rModel.iSeq == 1) {
                    _relativeNum01Text.text = @"";
                }else if(rModel.iSeq == 2){
                    _relativeNum02Text.text = @"";
                }else if(rModel.iSeq == 3){
                    _relativeNum03Text.text = @"";
                }else if(rModel.iSeq == 4){
                    _relativeNum04Text.text = @"";
                }else if(rModel.iSeq == 5){
                    _relativeNum05Text.text = @"";
                }else if(rModel.iSeq == 6){
                    _relativeNum06Text.text = @"";
                }else if(rModel.iSeq == 7){
                    _relativeNum07Text.text = @"";
                }else if(rModel.iSeq == 8){
                    _relativeNum08Text.text = @"";
                }
                
            }else{
            
                if (rModel.iSeq == 1) {
                    _relativeNum01Text.text = rModel.sMobile;
                }else if(rModel.iSeq == 2){
                    _relativeNum02Text.text = rModel.sMobile;
                }else if(rModel.iSeq == 3){
                    _relativeNum03Text.text = rModel.sMobile;
                }else if(rModel.iSeq == 4){
                    _relativeNum04Text.text = rModel.sMobile;
                }else if(rModel.iSeq == 5){
                    _relativeNum05Text.text = rModel.sMobile;
                }else if(rModel.iSeq == 6){
                    _relativeNum06Text.text = rModel.sMobile;
                }else if(rModel.iSeq == 7){
                    _relativeNum07Text.text = rModel.sMobile;
                }else if(rModel.iSeq == 8){
                    _relativeNum08Text.text = rModel.sMobile;
                }

            }
        }
        
    }
}
#pragma mark - 提交亲情号码数据
/**
 * navigationBar右边按钮点击
 * 提交亲情号码数据
 */
-(void)submitAction:(UIBarButtonItem *)sender{

    if ([self checkInputInfo]) {
        NSString *simei = [[UserHandle standardHandle]sImei];
        [[TBRelativeNumber shareDB] updateRelativeNumber:relativeArr withSimei:simei];
        
        [self.navigationController popViewControllerAnimated:YES];
        //向服务器发送请求
        [self requestRelativeData];
    }
}
/**
 * 检查表单数据
 */
-(BOOL)checkInputInfo{

    NSString *simei = [[UserHandle standardHandle]sImei];
    if (![NSString isBlankString:_relativeNum01Text.text]) {
        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 1;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum01Text.text;
        [relativeArr addObject:rModel];
    }
    if (![NSString isBlankString:_relativeNum02Text.text]) {
    
        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 2;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum02Text.text;
        [relativeArr addObject:rModel];
    }
    if (![NSString isBlankString:_relativeNum03Text.text]) {

        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 3;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum03Text.text;
        [relativeArr addObject:rModel];

    }
    if (![NSString isBlankString:_relativeNum04Text.text]) {
     
        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 4;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum04Text.text;
        [relativeArr addObject:rModel];
        

    }
    if (![NSString isBlankString:_relativeNum05Text.text]) {
  
        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 5;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum05Text.text;
        [relativeArr addObject:rModel];
    }
    if (![NSString isBlankString:_relativeNum06Text.text]) {
       
        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 6;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum06Text.text;
        [relativeArr addObject:rModel];
    }
    if (![NSString isBlankString:_relativeNum07Text.text]) {
      
        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 7;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum07Text.text;
        [relativeArr addObject:rModel];

    }
    if (![NSString isBlankString:_relativeNum08Text.text]) {

        RelativeNumberModel *rModel = [[RelativeNumberModel alloc] init];
        rModel.iSeq = 8;
        rModel.sImei = simei;
        rModel.sMobile = _relativeNum08Text.text;
        [relativeArr addObject:rModel];

    }
    
    if (relativeArr.count > 0) {
        return YES;
    }
    
    [SVProgressHUD showErrorWithStatus:MLString(@"请填写亲情号码")];
    return NO;
}

/**
 * 向服务器发送请求
 */
-(void)requestRelativeData{

    NSMutableArray *fms= [NSMutableArray array];
    for (int i=0; i< relativeArr.count; i++) {
        RelativeNumberModel *rModel = [relativeArr objectAtIndex:i];
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:rModel.iSeq],
                                  @"mobile":rModel.sMobile};
        [fms addObject:mobile];
    }
    if ([NSString isBlankString:_relativeNum01Text.text]) {
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:1],
                                  @"mobile":@""};
        [fms addObject:mobile];
    }
    if ([NSString isBlankString:_relativeNum02Text.text]) {
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:2],
                                  @"mobile":@""};
        [fms addObject:mobile];
    }
    if ([NSString isBlankString:_relativeNum03Text.text]) {
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:3],
                                  @"mobile":@""};
        [fms addObject:mobile];
        
    }
    if ([NSString isBlankString:_relativeNum04Text.text]) {
        
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:4],
                                  @"mobile":@""};
        [fms addObject:mobile];
        
    }
    if ([NSString isBlankString:_relativeNum05Text.text]) {
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:5],
                                  @"mobile":@""};
        [fms addObject:mobile];
    }
    if ([NSString isBlankString:_relativeNum06Text.text]) {
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:6],
                                  @"mobile":@""};
        [fms addObject:mobile];
    }
    if ([NSString isBlankString:_relativeNum07Text.text]) {
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:7],
                                  @"mobile":@""};
        [fms addObject:mobile];
    }
    if ([NSString isBlankString:_relativeNum08Text.text]) {
        NSDictionary *mobile  = @{@"seq":[NSNumber numberWithInt:8],
                                  @"mobile":@""};
        [fms addObject:mobile];
    }
    NSString *simei = [[UserHandle standardHandle]sImei];
    NSDictionary *para  = @{@"imei":simei,
                            @"fms":fms};
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
        dataPacket.sCommand       = @"S_FM";
        dataPacket.paraDictionary = mutableDictionary;
        dataPacket.iType          = 0;
        [tcp sendContent:dataPacket];
        
    }else{
//        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
        return;
    }

    
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
            
            if ([[self getCommod] isEqualToString:@"R_S_FM"] == YES) {
                NSLog(@"设置电话成功");
                
            }
        }
        
        
    }else{
        NSLog(@"设置电话失败");
        //        [SVProgressHUD showErrorWithStatus:[self getError]];
        return;
    }
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    
    NSLog(@"socket连接出现错误");
    
}


@end
