//
//  SilentDurationVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/31.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "SilentDurationVC.h"
#import "SystemSupport.h"
#import "MrStatus.h"
#import "DurationView.h"
#import "UserHandle.h"
#import "TBMrStatus.h"

@interface SilentDurationVC ()<DurationViewDelegate,ITcpClient>{

    NSMutableArray* silentDurations;
    NSMutableArray* silentViewsArray;
    BOOL isEdit;

}

@end

@implementation SilentDurationVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];
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


#pragma mark - loadCustomView
-(void)loadCustomView{
    
    self.title = MLString(@"静音时段");
    
    isEdit = NO;
    silentDurations = [NSMutableArray array];
    silentViewsArray = [NSMutableArray array];
    
    [self.myScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight+1)];
    
    [_addDurationBtn setBackgroundImage:[[SystemSupport share] imageOfFile:@"addIcon_normal"] forState:UIControlStateNormal];
    [_addDurationBtn setBackgroundImage:[[SystemSupport share] imageOfFile:@"addIcon_disable"] forState:UIControlStateHighlighted];
    [_addDurationBtn setBackgroundImage:[[SystemSupport share] imageOfFile:@"addIcon_disable"] forState:UIControlStateDisabled];
   
    
    _titleLabel.text = MLString(@"设置静音时段");
    _infoLabel.text = MLString(@"手表在以上时段内将保持静音");
    [_deleteAllDurationsBtn setTitle:MLString(@"删除") forState:UIControlStateNormal];
    _deleteAllDurationsBtn.layer.cornerRadius = 4;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self rightNavBarItemWithTitle:MLString(@"保存") AndSel:@selector(saveSilentDuration:)];
    
    [self getSilentDuration];
}
/**
 * 注销监听
 */
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//键盘将要出现
- (void)keyboardWillShow:(NSNotification*)notification
{
    CGSize size = _myScrollView.contentSize;
    _myScrollView.contentSize = CGSizeMake(kScreenWidth, size.height+HeightOfKeyboard);
}

//键盘将要消失
- (void)keyboardWillHide:(NSNotification*)notification
{
    CGSize size = _myScrollView.contentSize;
    _myScrollView.contentSize = CGSizeMake(kScreenWidth, size.height-HeightOfKeyboard);
}

-(void)getSilentDuration{

    [silentViewsArray removeAllObjects];
    [silentDurations removeAllObjects];
    
    NSString *sImei = [[UserHandle standardHandle] sImei];
    [silentDurations addObjectsFromArray:[[TBMrStatus shareDB] findByWhereWithImei:sImei]];

    [self adjustUIFrame];


}

#pragma mark - IB Actions
- (IBAction)addDurationAction:(UIButton*)sender
{
    [self saveAllSilentDurationToModel];
    
    MrStatus* silentDurationOjc = [[MrStatus alloc] init];
    [silentDurations addObject:silentDurationOjc];
    
    for (int i = 0; i < silentViewsArray.count; i++)
    {
        [silentViewsArray[i] removeFromSuperview];
    }
    [silentViewsArray removeAllObjects];
    [self adjustUIFrame];
}

- (IBAction)deleteAllDurationsAction:(UIButton*)sender
{
    isEdit = !isEdit;
    _addDurationBtn.enabled = !isEdit;
    self.navigationItem.rightBarButtonItem.enabled = !isEdit;
    for (int i = 0; i < silentViewsArray.count; i++)
    {
        DurationView* view = silentViewsArray[i];
        view.reduceDurationBtn.hidden = !isEdit;
        view.enableSwith.hidden = isEdit;
    }
    
    NSString* title = isEdit? MLString(@"完成"):MLString(@"删除");
    [_deleteAllDurationsBtn setTitle:title forState:UIControlStateNormal];
}

- (void) adjustUIFrame
{
    float y = _topView.frame.size.height+_topView.frame.origin.y;//_topView.frame.size.height
    float height = 0;
    for (int i = 0; i < silentDurations.count; i++)
    {
        MrStatus* silentDuration = silentDurations[i];
        DurationView* view = [[DurationView alloc] initWithFrame:CGRectMake(0, 68*i, kScreenWidth, 68)];
        view.tag = i;
        view.durationViewDelegate = self;
        view.titleLable.text = [NSString stringWithFormat:MLString(@"时段%d:"),i+1];
        view.reduceDurationBtn.hidden = !isEdit;
        view.enableSwith.hidden = isEdit;
        view.mySilentDuration = silentDuration;
        [_durationsView addSubview:view];
        [silentViewsArray addObject:view];
        height += view.frame.size.height;
    }

    _durationsView.frame = CGRectMake(0, y, kScreenWidth, height);
    
    float h = _durationsView.frame.origin.y+_durationsView.frame.size.height+_bottomView.frame.size.height;
    if (h>kScreenHeight) {
         _bottomView.frame = CGRectMake(_bottomView.frame.origin.x, _durationsView.frame.origin.y+_durationsView.frame.size.height, kScreenWidth, _bottomView.frame.size.height);
        _myScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _myScrollView.contentSize = CGSizeMake(0, _bottomView.frame.origin.y+_bottomView.frame.size.height);
    }
}

- (void) saveAllSilentDurationToModel
{
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    for (int i = 0; i < silentViewsArray.count; i++)
    {
        DurationView* view = silentViewsArray[i];
        [view saveSilentDuration];
    }
}

- (void) resignAllTextFieldInView:(UIView*)parentView
{
    for (UIView* view in parentView.subviews)
    {
        [view resignFirstResponder];
        [self resignAllTextFieldInView:view];
    }
}

#pragma mark - DurationView Delegate
- (void) removeSilentDuration:(int)index
{
    [self saveAllSilentDurationToModel];
    if (silentViewsArray.count >= index)
    {
        MrStatus *mrStatus = silentDurations[index];
        [[TBMrStatus shareDB] deleteWithMrStatus:mrStatus];
        
        [silentDurations removeObjectAtIndex:index];
        
        for (int i = 0; i < silentViewsArray.count; i++)
        {
            [silentViewsArray[i] removeFromSuperview];
        }
        [silentViewsArray removeAllObjects];
        [self adjustUIFrame];
    }
}

- (void) enableSlientRange:(BOOL)enable WithTag:(int)tag
{
    //    MrStatus* mrStatus = silentDurations[tag];
    //    mrStatus.enabled = (int)enable;
}

- (void) saveSilentDuration:(UIBarButtonItem*)sender
{
    [self resignAllTextFieldInView:_durationsView];
    [self saveAllSilentDurationToModel];
    NSMutableDictionary* silentDic = [NSMutableDictionary dictionary];
    NSMutableArray* mrStatusArr = [NSMutableArray array];
    NSMutableArray* silentArray = [NSMutableArray arrayWithCapacity:silentDurations.count];
    for (int i = 1; i <= silentDurations.count; i++)
    {
        MrStatus* silentDuration = silentDurations[i-1];
        silentDuration.no = i;
        NSLog(@"%@",silentDuration);
        NSString* silentTime = [silentDuration timeRange];
        silentDuration.range = silentTime;
//        if (silentTime == Nil)
//        {
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:MLString(@"静音时段设置不完整!") message:Nil delegate:Nil cancelButtonTitle:MLString(@"确定") otherButtonTitles:nil, nil];
//            [alertView show];
//            return;
//        }else if(![silentDuration validateRange])
//        {
//            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:MLString(@"静音时段设置不正确!") message:Nil delegate:Nil cancelButtonTitle:MLString(@"确定") otherButtonTitles:nil, nil];
//            [alertView show];
//            return;
//        }
        
        NSString * switchEnable=@"false";;
        if (silentDuration.enabled==0) {
            switchEnable = @"false";
        }
        if (silentDuration.enabled==1) {
            switchEnable=@"true";
        }
        
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        
        [dic setObject:[silentDuration.fromTime stringByReplacingOccurrencesOfString:@":" withString:@""] forKey:@"start"];
        [dic setObject:[silentDuration.toTime stringByReplacingOccurrencesOfString:@":" withString:@""] forKey:@"end"];
        [dic setObject:[NSNumber numberWithInt:silentDuration.enabled] forKey:@"enable"];
        [dic setObject:[NSNumber numberWithInt:silentDuration.no] forKey:@"seq"];
        [silentArray addObject:dic];
        [mrStatusArr addObject:silentDuration];
    }
    [silentDic setObject:[[UserHandle standardHandle] sImei] forKey:@"imei"];
    [silentDic setObject:silentArray forKey:@"mrs"];

    //设置静音时段
    [self requestSaveSilentPacket:silentDic withArr:mrStatusArr];
    
}

#pragma mark - 设置静音时段
/**
 * 设置静音时段
 */
-(void)requestSaveSilentPacket:(NSMutableDictionary *)silentDic withArr:(NSMutableArray *)mrStatusArr{
    
    if (silentDic!=nil) {
        
        //写入数据库
        [[TBMrStatus shareDB] updateMrStatus:mrStatusArr withSimei:[[UserHandle standardHandle] sImei]];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:silentDic];
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        if(tcp.asyncSocket.isDisconnected)
        {
//            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
            return;
        }else if(tcp.asyncSocket.isConnected)
        {
            
            DataPacket *dataPacket    = [[DataPacket alloc] init];
            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
            dataPacket.sCommand       = @"S_MR";
            dataPacket.paraDictionary = mutableDictionary;
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
            
        }else{
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
            return;
        }
        
    }
    
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
            
            if ([[self getCommod] isEqualToString:@"R_S_MR"] == YES) {
            
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
