//
//  AddChildrenVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/12.
//  Copyright (c) 2015年 kingly. All rights reserved.
//


#import "ChildModel.h"
@protocol AddChildrenVCDelegate;
@interface AddChildrenVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
/**
 * 添加小孩的协议
 */
@property (nonatomic,weak) id <AddChildrenVCDelegate> mydelegate;

@end

/**
 * 添加小孩的协议
 */
@protocol AddChildrenVCDelegate <NSObject>

@optional
/**
 * 添加小孩 
 */
-(void)addChildren:(ChildModel *)cModel;

@end