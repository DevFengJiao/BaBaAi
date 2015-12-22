//
//  MyMessageViewController.m
//  BabaGoing
//
//  Created by 冯大师 on 15/11/23.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageCell.h"
#import "TextViewController.h"

@interface MyMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置圆角
    self.title = @"我的信息";
    self.headImageview.layer.cornerRadius = self.headImageview.bounds.size.height/2;
    self.headImageview.clipsToBounds = YES;
    self.headImageview.contentMode = UIViewContentModeScaleAspectFill;
    
    self.myBtn.layer.cornerRadius = 3.0;
    self.myBtn.clipsToBounds = YES;
    self.myBtn.contentMode = UIViewContentModeScaleAspectFill;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentf = @"MyMessageCell";
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentf];
    if (cell == nil) {
        cell = (MyMessageCell *)[[[NSBundle mainBundle]loadNibNamed:@"MyMessageCell" owner:self options:nil]lastObject];
    }
    //这个地方名字没有取好
    if (indexPath.row == 0) {
        cell.titleLab.text = @"我是宝贝的";
        cell.telphoneLab.text = self.name;
    }else{
        cell.titleLab.text = @"我的手机号";
        cell.telphoneLab.text = self.telphone;
    }
   
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:line];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"11111");
    TextViewController *text = [[TextViewController alloc]init];
    [self.navigationController pushViewController:text animated:YES];
}


@end
