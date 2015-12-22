//
//  AddChildWayVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/12.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "AddChildWayVC.h"
#import "AddingWayTableViewCell.h"
#import "AddChildrenVC.h"
#import "AddQRCode.h"

#define  KADDWAYROW 44

@interface AddChildWayVC (){

    NSMutableArray *dataList;  //添加方式数组

}

@end

@implementation AddChildWayVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //    [self rightNavBarItemWithTitle:@"提交" AndSel:@selector(addChi:)];
    
    [self loadCustomView];
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
/**
 * 自定义视图
 */
-(void)loadCustomView{
    
    self.title = MLString(@"添加方式");

    CGRect tableFrame = self.myTableView.frame;
    tableFrame.origin.y = kNavgationBarHeight;
    tableFrame.size.height = kScreenHeight;
    self.myTableView.frame = tableFrame;
    
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithObjects:MLString(@"扫码添加"),MLString(@"手动添加"),nil];
    dataList = tempArray;
    
    
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
    if (dataList!=nil) {
        return [dataList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentifier=@"AddingWayTableViewCell";
    AddingWayTableViewCell *cell=(AddingWayTableViewCell *)[self.myTableView dequeueReusableCellWithIdentifier:cellIdentifier];
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

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (dataList  && [dataList count] > 0) {
        return KADDWAYROW;
    }
    return 0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [_myTableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    //    self.navigationItem.backBarButtonItem = BUTTONADD(@"返回",nil);
    
    
    //    if(dataCenterInstance.childrenArray.count>=CHILDREN_LIMIT_NUM){
    //
    //
    //        NSString *msg = [NSString stringWithFormat:MLString(@"您添加的小孩过多，不能再添加小孩！")];
    //        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:MLString(@"确定") otherButtonTitles:Nil, nil];
    //        [alertView show];
    //
    //        return;
    //    }
    NSInteger row = indexPath.row;
    if (row == 0) {
        [self showScanningView];
    }else if (row ==1){
        [self createNewTracker];
    }
}

#pragma mark - 添加手表
-(void)createNewTracker{
    AddChildrenVC* createChildVC = [[AddChildrenVC alloc] initWithNibName:@"AddChildrenVC" bundle:[SystemSupport mainBundle]];
    [self.navigationController pushViewController:createChildVC animated:YES];
}
#pragma mark - 使用二维码添加
-(void)showScanningView{
    AddQRCode* coreVC = [[AddQRCode alloc] initWithNibName:@"AddQRCode" bundle:[SystemSupport mainBundle]];
    [self.navigationController pushViewController:coreVC animated:YES];
}


@end
