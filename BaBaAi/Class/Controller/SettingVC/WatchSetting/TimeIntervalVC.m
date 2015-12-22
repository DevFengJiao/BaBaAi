//
//  TimeIntervalVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "TimeIntervalVC.h"


@interface TimeIntervalVC (){
    
    NSDictionary* groupArray;
}

@end

@implementation TimeIntervalVC

-(void)loadView
{
    [super loadView];
//    [self navigationBarShow];
    
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
    
    self.title = MLString(@"时间间隔");
    
    _locPeriodModel = [[ParameterModel alloc]init];
    groupArray = [[NSDictionary alloc] initWithDictionary:[BaseModel locPeriodArr]];
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
    
    static NSString *cellIdentifier=@"kTableViewCell";
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }
    
    NSString *timeKey = [[BaseModel locPeriodArrkeys] objectAtIndex:indexPath.row];
    cell.textLabel.text = [groupArray objectForKey:timeKey];
    if ([timeKey isEqualToString:_locPeriodModel.sParaValue]) {
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
            UITableViewCell *cell = (UITableViewCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
   
    NSString *timeKey = [[BaseModel locPeriodArrkeys] objectAtIndex:indexPath.row];
    _locPeriodModel.sParaValue = timeKey;
    [self.navigationController popViewControllerAnimated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(setLocPeriodValue:)]) {
        [_delegate setLocPeriodValue:_locPeriodModel];
    }
    
}

@end
