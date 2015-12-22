//
//  AddContactManagerVC.m
//  BabaGoing
//
//  Created by 冯大师 on 15/11/20.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "AddContactManagerVC.h"
#import "MyMessageViewController.h"
#import "UISegmentedControl+util.h"

@interface AddContactManagerVC ()
@property (nonatomic, copy)NSString *tableType;
@end

@implementation AddContactManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self drawView];
    
    if ([_tableType isEqual:@"1"])
    {
        mainTableView.hidden = YES;
        sencondTableView.hidden = NO;
    }else
    {
        mainTableView.hidden = NO;
        sencondTableView.hidden = YES;
    }
}

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"家庭成员",@"其它联系人"]];
    [segment setDefaultSegment];
    
    [segment addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem.titleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.navigationItem.titleView = segment;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self tabbarHidden];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selected:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            mainTableView.hidden = NO;
            sencondTableView.hidden = YES;
        }
            break;
        case 1:{
            mainTableView.hidden = YES;
            sencondTableView.hidden = NO;
        }
            break;
        default:
            break;
    }
}

-(void)initData{
    mainArrays = [NSMutableArray array];
    subArryas = [NSMutableArray array];
    for (int i=0; i<8; i++) {
        model = [[ManagerModel alloc]init];
        if (i%2 == 0) {
            model.name = @"妈妈";
            model.telPhone = @"1654223215";
        }else{
            model.name = @"爸爸";
            model.telPhone = @"1888888836";
        }
        
        model.nameImage = @"default_icon";
        [mainArrays  addObject:model];
    }
    
    for (int i = 0; i<4; i++) {
        model  = [[ManagerModel alloc]init];
        if (i%2 == 0) {
            model.name = @"叔叔";
            model.telPhone = @"122222222";
        }else{
            model.name = @"老师";
            model.telPhone = @"333333333";
        }
        model.nameImage = @"default_icon";
        [subArryas addObject:model];
    }
    
   
}

-(void)drawView{
    mainScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth,kScreenHeight-kNavgationBarHeight)];
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:mainScrollView];
    
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(mainScrollView.frame)-60)];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainScrollView addSubview:mainTableView];
    
    sencondTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(mainScrollView.frame)-60)];
    sencondTableView.delegate = self;
    sencondTableView.dataSource = self;
    sencondTableView.backgroundColor = [UIColor clearColor];
    sencondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainScrollView addSubview:sencondTableView];
    
    
    belowLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(mainTableView.frame)+10, kScreenWidth-30, 40)];
    belowLab.backgroundColor = [UIColor backgroundColor];
    belowLab.font = [UIFont systemFontOfSize:14.0];
    belowLab.text = @"当宝贝发起求助时，手表会按照此列表的顺序呼叫家庭成员。家庭成员可以随时呼叫宝贝。";
    belowLab.numberOfLines = 0;
    CGSize size = [belowLab sizeThatFits:CGSizeMake(belowLab.frame.size.width, 9999)];
    belowLab.frame = CGRectMake(belowLab.frame.origin.x, belowLab.frame.origin.y, belowLab.frame.size.width, size.height);
    [mainScrollView addSubview:belowLab];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == mainTableView) {
        return mainArrays.count;
    }else{
        return subArryas.count;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView  cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ContactManagerCell";
    ContactManagerCell *cell = (ContactManagerCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell= (ContactManagerCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ContactManagerCell" owner:self options:nil]  lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
    if (tableView == sencondTableView) {
        model = [subArryas objectAtIndex:indexPath.row];
        cell.model  = model;
    }else{
        model = [mainArrays objectAtIndex:indexPath.row];
        cell.model = model;
    }

    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 99.5, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:line];
//    mainTableView.frame = CGRectMake(mainTableView.frame.origin.x, mainTableView.frame.origin.y, mainTableView.frame.size.width,cell.frame.size.height * mainArrays.count);
//    NSLog(@"height ---%.2f",mainTableView.frame.size.height);
//    
//     mainScrollView.contentSize = CGSizeMake(kScreenWidth,CGRectGetMaxY(mainTableView.frame)+60);
    // 自己的一些设置
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (tableView == sencondTableView) {
        model = [subArryas objectAtIndex:indexPath.row];
    }else{
        model = [mainArrays objectAtIndex:indexPath.row];
    }
    
    MyMessageViewController *message = [[MyMessageViewController alloc]init];
    message.name = model.name;
    message.telphone = model.telPhone;
    [self pushViewController:message];

}

@end
