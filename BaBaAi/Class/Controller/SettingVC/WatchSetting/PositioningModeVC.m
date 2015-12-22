//
//  PositioningModeVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "PositioningModeVC.h"

#import "LocModeCell.h"
#import "ITcpClient.h"



@interface PositioningModeVC ()<ITcpClient>{

    NSMutableArray* groupArray;
}
@end

@implementation PositioningModeVC

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
    
    self.title = MLString(@"定位方式");
    
    groupArray = [NSMutableArray arrayWithArray:[BaseModel locModeArr]];
    
    [_myTableView reloadData];
    
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

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (groupArray.count>0) {
        return 44;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [groupArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    static NSString *cellIdentifier=@"kLocModeCell";
    LocModeCell *cell=(LocModeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"LocModeCell" owner:self options:nil];
        for(id oneObject in nibs)
        {
            if([oneObject isKindOfClass:[LocModeCell class]])
            {
                cell=(LocModeCell *)oneObject;
            }
        }
    }else{
        //解決重影問題
        NSArray *cellSubs = cell.contentView.subviews;
        for (int i=0; i< [cellSubs count]; i++) {
            [[cellSubs objectAtIndex:i] removeFromSuperview];
        }
    }
    cell.textLabel.text = [groupArray objectAtIndex:indexPath.row];
    if (indexPath.row == _locModeValue) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (groupArray.count>0) {

        for (int i =0; i<groupArray.count; i++) {
            LocModeCell *cell = (LocModeCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
     [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    _locModeValue = (int)indexPath.row;
    
//    [self sendRuestData];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(setLocModeValue:)]) {
        [_delegate setLocModeValue:_locModeValue];
    }
    
}
/**
 * 修改手表参数
 */
-(void) sendRuestData{

    NSDictionary *para  = @{@"paraName":@"locMode",
                            @"paraValue":[NSString stringWithFormat:@"%d",_locModeValue],
                            @"enabled":[NSNumber numberWithInt:1]};
    ParameterModel *pModel = [[ParameterModel alloc] initByDic:para];
    pModel.sImei  = [[UserHandle standardHandle] sImei];
    [[TBParameters shareDB] update:pModel];
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [mutableDictionary setObject:[[UserHandle standardHandle] sImei] forKey:@"imei"];
    [mutableDictionary setObject:[NSArray arrayWithObject:para] forKey:@"parameters"];
    
    //被注释
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
        dataPacket.sCommand       = @"S_TS";
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
    if ([self checkSocketRespClass:recivedTxt]){
       
        if ([self getCommod]!=nil) {
            
            if ([[self getCommod] isEqualToString:@"R_S_TS"] == YES) {
                 NSLog(@"定位设置成功");
                
            }
        }
       
        
    }else{
         NSLog(@"定位设置失败");
//        [SVProgressHUD showErrorWithStatus:[self getError]];
        return;
    }
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    
    NSLog(@"socket连接出现错误");
    
}


@end
