//
//  SettingViewController.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "SettingViewController.h"
#import "OneViewController.h"
#import "SettingCell.h"
#import "SettingSwichCell.h"
#import "SleepTimeCell.h"
#import "ReachToLocationVC.h"

#import "ParameterModel.h"
#import "PositioningModeVC.h"
#import "TimeIntervalVC.h"
#import "CollisionDetectionVC.h"

#import "DatetimePickerViewDelegate.h"

#import "TBParameters.h"
#import "ParameterModel.h"


@interface SettingViewController ()<PositioningModeVCDelegate,TimeIntervalVCDelegate,SettingSwichCellDelegate,CollisionDetectionVCDelegate,SleepTimeCellDelegate,DatetimeDelegate>{
    NSMutableArray* groupArray;
    int locModeValue; //定位方式
    
    ParameterModel *locModeModel;     //定位方式
    ParameterModel *locPeriodModel;   //时间间隔
    ParameterModel *cillSwitchModel;  //碰撞检测开关
    ParameterModel *sleepPeriodModel; //睡眠时段
    ParameterModel *cillLevelModel;   //碰撞碰撞等级
    ParameterModel *beltSwitchModel;  //表带脱落检测开关
    ParameterModel *locSwitchModel;   //定时定位开关
    ParameterModel *blueSwitchModel;  //蓝牙开关
    ParameterModel *fenceSwitchModel;      //电子围栏开关
    ParameterModel *arrivedSwitchModel;    //位置到达开关
    
    ParameterModel *remidSwitchModel;    //提醒
    
    NSString *startTime;
    NSString *endTime;
    
}


@end

@implementation SettingViewController


-(void)loadView
{
    [super loadView];
//    [self navigationBarShow];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = MLString(@"设置");
    [self loadCustomView];
    [self addObservers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.isHeadView = YES;
    [self navigationBarHidden];
    [self tabbarShow];
    self.navigationController.hidesBottomBarWhenPushed = NO ;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.hidesBottomBarWhenPushed = NO ;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];//注销观察者
}

#pragma mark - loadCustomView
-(void)loadCustomView{
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavgationBarHeight, kScreenWidth, kScreenHeight)];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    //读取plist文件路径
    NSString *filePath = [[SystemSupport mainBundle] pathForResource:@"settingList" ofType:@"plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        groupArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
//    [self reloadTableData];
}

-(void)reloadTableData{
    
    //被注释
//    NSMutableArray *arr = [[TBParameters shareDB] findByWhereWithImei:[[UserHandle standardHandle] sImei]];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    if (arr.count > 0) {
        for (int j=0; j < arr.count; j++) {
            ParameterModel *ct = [[ParameterModel alloc]init];
            ct = [arr objectAtIndex:j];
            
            if ([ct.sParaName isEqualToString:@"locMode"]) {
                locModeModel = ct;
            }else if ([ct.sParaName isEqualToString:@"locPeriod"]) {
                locPeriodModel = ct;
            }else if ([ct.sParaName isEqualToString:@"cillSwitch"]) {
                cillSwitchModel = ct;
            }else if ([ct.sParaName isEqualToString:@"sleepPeriod"]) {
                sleepPeriodModel = ct;
            }else if ([ct.sParaName isEqualToString:@"cillLevel"]) {
                cillLevelModel = ct;
            }else if ([ct.sParaName isEqualToString:@"beltSwitch"]) {
                beltSwitchModel = ct;
            }else if ([ct.sParaName isEqualToString:@"locSwitch"]) {
                locSwitchModel = ct;
            }else if ([ct.sParaName isEqualToString:@"blueSwitch"]) {
                blueSwitchModel = ct;
            }else if ([ct.sParaName isEqualToString:@"fenceSwitch"]) {
                fenceSwitchModel = ct;
            }else if ([ct.sParaName isEqualToString:@"arrivedSwitch"]) {
                arrivedSwitchModel = ct;
            }else if([ct.sParaName isEqualToString:@"remidSwitch"]){
                remidSwitchModel = ct;
            }
        }
    }
    
    
    if (locModeModel==nil) {
        locModeModel        =  [[ParameterModel alloc]init];
        locModeModel.sImei  = [[UserHandle standardHandle] sImei];
        locModeModel.sParaName =  @"locMode";
        if ([locModeModel.sParaValue intValue] == 0) {
            locModeModel.sParaValue = @"0";
        }
    }
    
    if (locPeriodModel==nil) {
        locPeriodModel      =  [[ParameterModel alloc]init];
        locPeriodModel.sImei  = [[UserHandle standardHandle] sImei];
        locPeriodModel.sParaName =  @"locPeriod";
        if ([locPeriodModel.sParaValue intValue] == 0) {
            locPeriodModel.sParaValue = @"0";
        }
    }
    
    
    if (cillSwitchModel==nil) {
        cillSwitchModel     =  [[ParameterModel alloc]init];
        cillSwitchModel.sImei  = [[UserHandle standardHandle] sImei];
        cillSwitchModel.sParaName =  @"cillSwitch";
        if ([cillSwitchModel.sParaValue intValue] == 0) {
            cillSwitchModel.sParaValue = @"0";
        }
    }
    
    if (sleepPeriodModel==nil) {
        sleepPeriodModel    =  [[ParameterModel alloc]init];
        sleepPeriodModel.sImei  = [[UserHandle standardHandle] sImei];
        sleepPeriodModel.sParaName =  @"sleepPeriod";
        if ([sleepPeriodModel.sParaValue intValue] == 0) {
            sleepPeriodModel.sParaValue = @"0";
        }
    }
    
    if (cillLevelModel==nil) {
        cillLevelModel      =  [[ParameterModel alloc]init];
        cillLevelModel.sImei  = [[UserHandle standardHandle] sImei];
        cillLevelModel.sParaName =  @"cillLevel";
        if ([cillLevelModel.sParaValue intValue] == 0) {
            cillLevelModel.sParaValue = @"0";
        }
    }
    
    if (locSwitchModel==nil) {
        locSwitchModel      =  [[ParameterModel alloc]init];
        locSwitchModel.sImei  = [[UserHandle standardHandle] sImei];
        locSwitchModel.sParaName =  @"locSwitch";
        if ([locSwitchModel.sParaValue intValue] == 0) {
            locSwitchModel.sParaValue = @"0";
        }
    }
    
    if (beltSwitchModel==nil) {
        beltSwitchModel     =  [[ParameterModel alloc]init];
        beltSwitchModel.sImei  = [[UserHandle standardHandle] sImei];
        beltSwitchModel.sParaName =  @"beltSwitch";
        if ([beltSwitchModel.sParaValue intValue] == 0) {
            beltSwitchModel.sParaValue = @"0";
        }
    }
    
    if (blueSwitchModel==nil) {
        blueSwitchModel     =  [[ParameterModel alloc]init];
        blueSwitchModel.sImei  = [[UserHandle standardHandle] sImei];
        blueSwitchModel.sParaName =  @"blueSwitch";
        if ([blueSwitchModel.sParaValue intValue] == 0) {
            blueSwitchModel.sParaValue = @"0";
        }
    }
    
    
    if (fenceSwitchModel==nil) {
        fenceSwitchModel    =  [[ParameterModel alloc]init];
        fenceSwitchModel.sImei  = [[UserHandle standardHandle] sImei];
        fenceSwitchModel.sParaName =  @"fenceSwitch";
        if ([fenceSwitchModel.sParaValue intValue] == 0) {
            fenceSwitchModel.sParaValue = @"0";
        }
    }
    
    if (arrivedSwitchModel==nil) {
        arrivedSwitchModel  =  [[ParameterModel alloc]init];
        arrivedSwitchModel.sImei  = [[UserHandle standardHandle] sImei];
        arrivedSwitchModel.sParaName =  @"arrivedSwitch";
        if ([arrivedSwitchModel.sParaValue intValue] == 0) {
            arrivedSwitchModel.sParaValue = @"0";
        }
    }
    
    if (remidSwitchModel==nil) {
        remidSwitchModel = [[ParameterModel alloc]init];
        remidSwitchModel.sImei = [[UserHandle standardHandle]sImei];
        remidSwitchModel.sParaName = @"remidSwitch";
        if ([remidSwitchModel.sParaName intValue] == 0) {
            remidSwitchModel.sParaValue = @"0";
        }
    }
    
    
    //获得定位模式
    if (locModeModel.sParaValue!=nil) {
        locModeValue  = [locModeModel.sParaValue intValue];
    }
    
    
    
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return kHeaderInSection;
    }
    return kSectionVerSpace;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([groupArray count] == section+1) {
        return 44;
    }
    return kSectionVerSpace;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [groupArray count];//返回标题数组中元素的个数来确定分区的个数
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [groupArray objectAtIndex:section];
    return  [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"SettingCell";
    SettingCell *cell=(SettingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nibs=[[SystemSupport mainBundle] loadNibNamed:@"SettingCell" owner:self options:nil];
        for(id oneObject in nibs)
        {
            if([oneObject isKindOfClass:[SettingCell class]])
            {
                cell=(SettingCell *)oneObject;
            }
        }
    }else{
        //解決重影問題
        NSArray *cellSubs = cell.contentView.subviews;
        for (int i=0; i< [cellSubs count]; i++) {
            [[cellSubs objectAtIndex:i] removeFromSuperview];
        }
    }
    
    NSMutableArray *arr = [groupArray objectAtIndex:indexPath.section];
    NSMutableDictionary *dis = [arr objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = MLString([dis objectForKey:@"name"]);
    // cell.loginIcon.image = [[SystemSupport share] imageOfFile:[dis objectForKey:@"name"]];
    
    if ([[dis objectForKey:@"viewName"] isEqualToString:@"SleepTimeVC"] == YES) {
        
        static NSString *cellIdentifier=@"kSleepTimeCell";
        SleepTimeCell *cell=(SleepTimeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell==nil)
        {
            NSArray *nibs=[[SystemSupport mainBundle] loadNibNamed:@"SleepTimeCell" owner:self options:nil];
            for(id oneObject in nibs)
            {
                if([oneObject isKindOfClass:[SleepTimeCell class]])
                {
                    cell=(SleepTimeCell *)oneObject;
                }
            }
        }else{
            //解決重影問題
            NSArray *cellSubs = cell.contentView.subviews;
            for (int i=0; i< [cellSubs count]; i++) {
                [[cellSubs objectAtIndex:i] removeFromSuperview];
            }
        }
        cell.indexPath = indexPath;
        cell.pModel    = sleepPeriodModel;
        cell.groupArr  = groupArray;
        cell.mydelegate = self;
        return cell;
    }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"SilentDuration_VC"] == YES) {
        
    }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"HitLevelConfig_VC"] == YES) {
        
    }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"PositioningModeVC"] == YES) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.noteLabel.text = [[BaseModel locModeArr] objectAtIndex:locModeValue];
    }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"TimeIntervalVC"] == YES
              || [[dis objectForKey:@"viewName"] isEqualToString:@"CollisionDetectionVC"] == YES
              || [[dis objectForKey:@"viewName"] isEqualToString:@"SheddingDetectionVC"] == YES
              || [[dis objectForKey:@"viewName"] isEqualToString:@"AlertAreaVC"] == YES
//              || [[dis objectForKey:@"viewName"] isEqualToString:@"ReachToLocationVC"] == YES
              ) {
        
        static NSString *cellIdentifier=@"kSettingSwichCell";
        SettingSwichCell *cell=(SettingSwichCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell==nil)
        {
            NSArray *nibs=[[SystemSupport mainBundle] loadNibNamed:@"SettingSwichCell" owner:self options:nil];
            for(id oneObject in nibs)
            {
                if([oneObject isKindOfClass:[SettingSwichCell class]])
                {
                    cell=(SettingSwichCell *)oneObject;
                }
            }
        }else{
            //解決重影問題
            NSArray *cellSubs = cell.contentView.subviews;
            for (int i=0; i< [cellSubs count]; i++) {
                [[cellSubs objectAtIndex:i] removeFromSuperview];
            }
        }
        cell.indexPath = indexPath;
        if ([[dis objectForKey:@"viewName"] isEqualToString:@"TimeIntervalVC"] == YES) {
            cell.pModel    = locPeriodModel;
            cell.locSwitchModel = locSwitchModel;
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"CollisionDetectionVC"] == YES){
            cell.pModel    = cillLevelModel;
            cell.cillSwitchModel = cillSwitchModel;
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"SheddingDetectionVC"] == YES){
            cell.pModel    = beltSwitchModel;
            
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"AlertAreaVC"] == YES){
            cell.pModel    = fenceSwitchModel;
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"ReachToLocationVC"] == YES){
            cell.pModel    = arrivedSwitchModel;
        }
        
        cell.groupArr  = groupArray;
        cell.mydelegate = self;
        
        return cell;
    }
    return cell;
    
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_myTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *arr = [groupArray objectAtIndex:indexPath.section];
    NSMutableDictionary *dis = [arr objectAtIndex:indexPath.row];
    
    if ([[dis objectForKey:@"viewName"] isEqualToString:@"SleepTimeVC"] == YES) {
        //睡眠时段

    }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"PositioningModeVC"] == YES) {
        //定位方式
        PositioningModeVC *positioningModeVC = [[PositioningModeVC alloc] initWithNibName:@"PositioningModeVC" bundle:[SystemSupport mainBundle]];
        positioningModeVC.locModeValue = locModeValue;
        positioningModeVC.delegate = self;
       [self pushViewController:positioningModeVC];
//        [self.navigationController pushViewController:positioningModeVC animated:YES];

    }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"TimeIntervalVC"] == YES) {
        //时间间隔
        TimeIntervalVC *timeIntervalVC = [[TimeIntervalVC alloc] initWithNibName:@"TimeIntervalVC" bundle:[SystemSupport mainBundle]];
        timeIntervalVC.locPeriodModel = locPeriodModel;
        timeIntervalVC.delegate = self;
        [self pushViewController:timeIntervalVC];
        
    }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"CollisionDetectionVC"] == YES) {
        //碰撞等级
        CollisionDetectionVC *collisionDetectionVC = [[CollisionDetectionVC alloc] initWithNibName:@"CollisionDetectionVC" bundle:[SystemSupport mainBundle]];
        collisionDetectionVC.cillLevelModel = cillLevelModel;
        collisionDetectionVC.delegate = self;
        [self pushViewController:collisionDetectionVC];
        
    }else if([[dis objectForKey:@"viewName"] isEqualToString:@"SheddingDetectionVC"] == YES){
        //脱落开关
    }else{
        UIViewController* viewController = [[NSClassFromString([dis objectForKey:@"viewName"]) alloc] initWithNibName:[dis objectForKey:@"viewName"] bundle:[NSBundle mainBundle]];
        viewController.title = MLString([dis objectForKey:@"name"]);
        UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
        customLeftBarButtonItem.title = MLString(@"返回");
        self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
        [self pushViewController:viewController];

    }
}


#pragma mark  - PositioningModeVCDelegate

-(void)setLocModeValue:(int )locMValue{
    locModeValue = locMValue;
    [_myTableView reloadData];
}
#pragma mark  - TimeIntervalVCDelegate
/**
 * 设置时间间隔
 */
-(void)setLocPeriodValue:(ParameterModel *)pModel{
    locPeriodModel = pModel;
    NSLog(@"%@ -- %@",pModel.sParaName,pModel.sParaValue);
    [_myTableView reloadData];
    [self sendRuestData:pModel];
}
#pragma mark - CollisionDetectionVCDelegate
/**
 * 设置碰撞等级
 */
-(void)setCillLevelValue:(ParameterModel *)pModel{
    
    cillLevelModel = pModel;
    [_myTableView reloadData];
    [self sendRuestData:pModel];
    
}
#pragma mark - SettingSwichCellDelegate
/**
 * 设置手表switchAction
 */
-(void)switchAction:(ParameterModel *)pModel{
    [self sendRuestData:pModel];
}
#pragma mark - SleepTimeCellDelegate
/**
 * 设置睡眠时段switchAction
 */
-(void)SleepTimeswitchAction:(ParameterModel *)pModel{
    [self sendRuestData:pModel];
}

/**
 * 点击开始时间
 */
-(void)onClickStartTime:(ParameterModel *)pModel withIndexPath:(NSIndexPath *)indexPath{
    [self tabbarHidden];
    DatetimePickerViewDelegate  * bodView = [[DatetimePickerViewDelegate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bodView.itag = 200;
    bodView.indexPath = indexPath;
    bodView.DatetimeDelegate = self;
    [self.view addSubview:bodView];
}
/**
 * 点击结束时间
 */
-(void)OnClickEndTime:(ParameterModel *)pModel withIndexPath:(NSIndexPath *)indexPath{
    
    [self tabbarHidden];
    
    DatetimePickerViewDelegate  * bodView = [[DatetimePickerViewDelegate alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bodView.itag = 201;
    bodView.indexPath = indexPath;
    bodView.DatetimeDelegate = self;
    [self.view addSubview:bodView];
    
}

#pragma mark -DatetimePickerViewDelegate
- (void) finishSelectDatetime:(NSDate *)datetime  withTag:(int)itag withIndexPath:(NSIndexPath *)indexPath{
    
    
    [self tabbarShow];
    
    SleepTimeCell *cell = (SleepTimeCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    if (itag == 200) {
        startTime = [DateUtil dateStringhhmm:datetime];
        [cell.startBtn setTitle:[DateUtil dateStringHHMM:datetime] forState:UIControlStateNormal];
    }else if(itag == 201){
        [cell.endBtn setTitle:[DateUtil dateStringHHMM:datetime] forState:UIControlStateNormal];
        endTime = [DateUtil dateStringhhmm:datetime];
    }
    
    if (startTime.length >0 && endTime.length>0) {
        
        if ([startTime intValue] > [endTime intValue]) {
            [SVProgressHUD showErrorWithStatus:MLString(@"设置的时间有误，请设置")];
        }else{
            //发送请求设置睡眠时段
            NSString *startTimestr = [startTime stringByReplacingOccurrencesOfString:@":" withString:@""];
            NSString *endTimestr = [endTime stringByReplacingOccurrencesOfString:@":" withString:@""];
            
            sleepPeriodModel.sParaValue = [NSString stringWithFormat:@"%@%@",startTimestr,endTimestr];
            
            [self sendRuestData:sleepPeriodModel];
        }
    }
    
    
}
- (void)cancelAction:(id)sender{
    
    [self tabbarShow];
    
}

#pragma mark - 发送修改手表参数的请求
/**
 * 修改手表参数
 */
-(void) sendRuestData:(ParameterModel *)pModel{
    
    //    if (pModel==nil) {
    //        NSLog(@"操作有误！！！！");
    //        return;
    //    }
    //
    //    NSDictionary *para  = @{@"paraName":pModel.sParaName,
    //                            @"paraValue":pModel.sParaValue,
    //                            @"enabled":[NSNumber numberWithInt:pModel.iEnabled]};
    //    [[TBParameters shareDB] update:pModel];
    //
    //    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    //    NSLog(@"==%@",pModel.sImei);
    //    [mutableDictionary setObject:pModel.sImei forKey:@"imei"];
    //    [mutableDictionary setObject:[NSArray arrayWithObject:para] forKey:@"parameters"];
    //    TcpClient *tcp = [TcpClient sharedInstance];
    //    [tcp setDelegate_ITcpClient:self];
    //    if(tcp.asyncSocket.isDisconnected)
    //    {
    //        //        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
    //        return;
    //    }else if(tcp.asyncSocket.isConnected)
    //    {
    //
    //        DataPacket *dataPacket    = [[DataPacket alloc] init];
    //        dataPacket.timestamp      = [NSDate stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
    //        dataPacket.sCommand       = @"S_TS";
    //        dataPacket.paraDictionary = mutableDictionary;
    //        dataPacket.iType          = 0;
    //        [tcp sendContent:dataPacket];
    //
    //    }else{
    //        //        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
    //        return;
    //    }
    
    
}

#pragma mark ITcpClient
/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt{
    
    NSLog(@"发送到服务器端的数据");
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSDictionary *)recivedTxt{
//    if ([self checkSocketRespClass:recivedTxt]){
//        
//        if ([self getCommod]!=nil) {
//            
//            if ([[self getCommod] isEqualToString:@"R_S_TS"] == YES) {
//                NSLog(@"定位设置成功");
//                
//            }
//        }
//        
//        
//    }else{
//        NSLog(@"定位设置失败");
//        //        [SVProgressHUD showErrorWithStatus:[self getError]];
//        return;
//    }
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    
    NSLog(@"socket连接出现错误");
    
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
//    [self reloadNavData];
    
    [self reloadTableData];
    [self.myTableView reloadData];
}


@end
