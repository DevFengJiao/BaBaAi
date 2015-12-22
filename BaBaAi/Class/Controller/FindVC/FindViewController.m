//
//  FindViewController.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "FindViewController.h"
#import "SystemSupport.h"
#import "SettingCell.h"

@interface FindViewController ()
{
    
    NSMutableArray* groupArray;
    
}
@end

@implementation FindViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发现";
    groupArray = [NSMutableArray array];
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
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}


#pragma mark - loadCustomView
-(void)loadCustomView{
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavgationBarHeight, kScreenWidth, kScreenHeight-100)];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    //读取plist文件路径
    NSString *filePath = [[SystemSupport mainBundle] pathForResource:@"findList" ofType:@"plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        groupArray = [NSMutableArray arrayWithContentsOfFile:filePath];
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
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:self options:nil];
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
    
    cell.textLabel.text = MLString([dis objectForKey:@"name"]);
    
    if ([[dis objectForKey:@"viewName"] isEqualToString:@"Logoff"] == YES) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
    
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_myTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *arr = [groupArray objectAtIndex:indexPath.section];
    NSMutableDictionary *dis = [arr objectAtIndex:indexPath.row];
    
    if ([[dis objectForKey:@"viewName"] isEqualToString:@"Logoff"] == YES) {
        [self Logoff];
    }else{
        UIViewController* viewController = [[NSClassFromString([dis objectForKey:@"viewName"]) alloc] initWithNibName:[dis objectForKey:@"viewName"] bundle:[SystemSupport mainBundle]];
        viewController.title = MLString([dis objectForKey:@"name"]);
        UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
        customLeftBarButtonItem.title = MLString(@"返回");
        self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
        [self pushViewController:viewController];
//        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - 私有方法
-(NSString *)getSetName:(BOOL)rs{
    
    if (rs) {
        return MLString(@"已设定");
    }else{
        return MLString(@"未设定");
    }
}

- (NSString*) levelToString:(int)hitLevel
{
    NSString* levelString = nil;
    switch (hitLevel)
    {
        case 1:
            levelString = MLString(@"轻量");
            break;
        case 2:
            levelString = MLString(@"一般");
            break;
        case 3:
            levelString = MLString(@"严重");
            break;
        case 4:
            levelString = MLString(@"重量");
            break;
    }
    
    return levelString;
}

-(NSString *)getMrStatus{
    NSString *rs = [self getSetName:NO];
    //    NSArray *mrStatus= [[DataAccessor sharedDBAccessor] getKidmate_mrStatusByImei:UserDefault_Get_TrackerImei([[DataCenterManager shareDataInstance] userId])];
    //    if (mrStatus.count>0) {
    //        rs = [self getSetName:YES];
    //    }
    return rs;
}
-(NSString *)getStatusInfo{
    int hitLevel = 1;
    //    StatusInfo*  statusInfo = [[DataAccessor sharedDBAccessor] getStatusInfoByImei:UserDefault_Get_TrackerImei([[DataCenterManager shareDataInstance] userId])];
    //    if (statusInfo) {
    //        hitLevel = (int)statusInfo.hitLevel;
    //
    //    }
    return [self levelToString:hitLevel];
}

/**
 * 退出登录
 */
-(void)Logoff{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:MLString(@"温馨提示") message:MLString(@"您确定要退出吗？")  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        
//        [[UserHandle standardHandle]removeUserLocalStorage];//清除用户数据
//        [[TcpClient sharedInstance] disconnectSocket];      //断开socket
//        
//        [self showLoginViewInVc:self];
        
    }];
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
    }];
    [alert addAction:sureAct];
    [alert addAction:cancelAct];
    [self presentViewController:alert animated:YES completion:^{}];
}

/**
 * 让 UIImagePickerController 显示后 的状态栏始终保持某一种风格.
 */
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
//    [self reloadNavData];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
