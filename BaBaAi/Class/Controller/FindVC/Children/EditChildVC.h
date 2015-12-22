//
//  EditChildVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/18.
//  Copyright (c) 2015年 kingly. All rights reserved.
//


#import "ChildModel.h"

@interface EditChildVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) ChildModel *cModel;  //小孩模型

@end
