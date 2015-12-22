//
//  ChildrenListVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "ChildrenListVC.h"
#import "AddingWayTableViewCell.h"

#import "AddChildrenVC.h"
#import "AddChildWayVC.h"
#import "ChildrenListCell.h"

#import "EditChildVC.h"
#import "ChildModel.h"
#import "TBChild.h"

#import "AddQRCode.h"


#define  KADDWAYROW 44
#define  KChildRow 60


@interface ChildrenListVC ()<UITextFieldDelegate,AddChildrenVCDelegate,ITcpClient>{

    NSMutableArray *dataList;  //添加方式数组
    NSMutableArray *userList;  //小孩数组
}

@end

@implementation ChildrenListVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    [self navCustomViewHidden];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self rightNavBarItemWithTitle:MLString(@"添加") AndSel:@selector(AddChildWay:)];
    
    [self loadCustomView];

 
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self navigationBarShow];
    [self tabbarHidden];

    //所得小孩对象
    userList = [self getAllChilds];
    
    [self.myTableView reloadData];//刷新表格
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}
/**
 * 获得所有小孩的对象列表
 */
-(NSMutableArray *)getAllChilds{

    NSMutableArray* allChilds = [NSMutableArray array];
    allChilds = [[TBChild shareDB] findByWhere:nil];
    return allChilds;
}

#pragma mark - 添加方式信息
/**
 * navigationBar右边按钮点击
 * 添加方式信息
 */
-(void)AddChildWay:(UIBarButtonItem *)sender
{
    AddChildWayVC *addChildWayVC = [[AddChildWayVC alloc] initWithNibName:@"AddChildWayVC" bundle:[SystemSupport mainBundle]];
    [self.navigationController pushViewController:addChildWayVC animated:YES];
}
/**
 * 自定义视图
 */
-(void)loadCustomView{
    
   
//    CGRect tableFrame = self.myTableView.frame;
//    tableFrame.origin.y = kNavgationBarHeight;
//    tableFrame.size.height = kScreenHeight;
//    self.myTableView.frame = tableFrame;
    
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithObjects:MLString(@"扫码添加"),MLString(@"手动添加"),nil];
    dataList = tempArray;
    //初始化
    userList = [NSMutableArray array];
    

}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return kHeaderInSection;
    }
    return kSectionVerSpace;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (userList.count>0) {
        return userList.count;
    }else if (dataList!=nil) {
        return [dataList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (userList.count > 0) {
        
       ChildrenListCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:kChildrenListCell];
        if(cell==nil)
        {
            NSArray *nibs=[[SystemSupport mainBundle] loadNibNamed:@"ChildrenListCell" owner:self options:nil];
            for(id oneObject in nibs)
            {
                if([oneObject isKindOfClass:[ChildrenListCell class]])
                {
                    cell=(ChildrenListCell *)oneObject;
                }
            }
        }else{
            //解決重影問題
            NSArray *cellSubs = cell.contentView.subviews;
            for (int i=0; i< [cellSubs count]; i++) {
                [[cellSubs objectAtIndex:i] removeFromSuperview];
            }
        }
    
        ChildModel *cModel = [userList objectAtIndex:[indexPath row]];
        cell.cModel  = cModel;
       return cell;

    }else{
        AddingWayTableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:kAddingWayTableViewCell];
        if(cell==nil)
        {
            NSArray *nibs=[[SystemSupport mainBundle] loadNibNamed:@"AddingWayTableViewCell" owner:self options:nil];
            for(id oneObject in nibs)
            {
                if([oneObject isKindOfClass:[AddingWayTableViewCell class]])
                {
                    cell=(AddingWayTableViewCell *)oneObject;
                }
            }
        }else{
            //解決重影問題
            NSArray *cellSubs = cell.contentView.subviews;
            for (int i=0; i< [cellSubs count]; i++) {
                [[cellSubs objectAtIndex:i] removeFromSuperview];
            }
        }
        
        NSUInteger row = [indexPath row];
        
        if (row == 0) {
            cell.img.image  = [[SystemSupport share] imageOfFile:@"扫码添加图标"];
            
        }else if(row == 1){
            cell.img.image  = [[SystemSupport share] imageOfFile:@"手动添加图标"];
        }
        
        NSString *rowString = [dataList objectAtIndex:row];
        
        cell.name.text  = rowString;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;


    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (userList.count>0) {
        return KChildRow;
    }else if ([dataList count] > 0) {
        return KADDWAYROW;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (userList.count>0) {
        
        UIAlertAction *camera = [UIAlertAction actionWithTitle:MLString(@"编辑对象") style:UIAlertActionStyleDefault handler:^(UIAlertAction *cameraAct){
            [self editChild:indexPath];
        }];
        UIAlertAction *album = [UIAlertAction actionWithTitle:MLString(@"删除对象") style:UIAlertActionStyleDefault handler:^(UIAlertAction *albumAct){
            [self delChild:indexPath];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:MLString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction *cancelAct){
        }];
        UIAlertController *alerCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alerCtr addAction:camera];
        [alerCtr addAction:album];
        [alerCtr addAction:cancel];
        [self presentViewController:alerCtr animated:YES completion:^{}];
    
    }else{
        NSInteger row = indexPath.row;
        if (row == 0) {
            [self showScanningView];
        }else if (row ==1){
            [self createNewTracker];
        }
    }
}

#pragma mark - 添加手表
-(void)createNewTracker{
    AddChildrenVC* createChildVC = [[AddChildrenVC alloc] initWithNibName:@"AddChildrenVC" bundle:[SystemSupport mainBundle]];
    createChildVC.mydelegate = self;
    [self.navigationController pushViewController:createChildVC animated:YES];
}
#pragma mark - 使用二维码添加
-(void)showScanningView{
    AddQRCode* coreVC = [[AddQRCode alloc] initWithNibName:@"AddQRCode" bundle:[SystemSupport mainBundle]];
    [self.navigationController pushViewController:coreVC animated:YES];
}

#pragma mark  - AddChildrenVCDelegate
/**
 * 添加小孩
 */
-(void)addChildren:(ChildModel *)cModel{
//    if (cModel!=nil) {
//        [userList insertObject:cModel atIndex:0];
//        [self.myTableView reloadData];//刷新表格
//        
//        NSLog(@"用户：%@",userList);
//    }
}
#pragma mark - 小孩的操作
/**
 * 编辑小孩
 */
-(void) editChild:(NSIndexPath *)indexPath{
 
    EditChildVC *editChildVC =  [[EditChildVC alloc] initWithNibName:@"AddChildrenVC" bundle:[SystemSupport mainBundle]];
    editChildVC.cModel = [userList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editChildVC animated:YES];
}
/**
 * 删除小孩
 */
-(void) delChild:(NSIndexPath *)indexPath{
   
    
    ChildModel *cModel = [userList objectAtIndex:indexPath.row];
    [[TBChild shareDB] deleteByllWearId:cModel.llWearId];
    
    [userList removeObjectAtIndex:indexPath.row];
    [self.myTableView reloadData];
    
    //执行服务器删除
    NSDictionary *para  = @{@"childrenID":[NSNumber numberWithUnsignedLongLong:cModel.llWearId]};
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
        //被注释
//        dataPacket.timestamp      = [NSDate stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
        dataPacket.sCommand       = @"D_CHILDREN";
        dataPacket.paraDictionary = mutableDictionary;
        dataPacket.iType          = 0;
        [tcp sendContent:dataPacket];
        
    }else{
        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
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
    NSLog(@"收到服务器端,%@",recivedTxt);
    if ([self checkSocketRespClass:recivedTxt]){
        
        if ([self getCommod]!=nil) {
            
            if ([[self getCommod] isEqualToString:@"R_D_CHILDREN"] == YES) {
                NSLog(@" 小孩对象删除成功！");
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
