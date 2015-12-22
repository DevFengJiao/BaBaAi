//
//  AddChildrenCell.h
//  LBKidsApp
//
//  Created by kingly on 15/8/12.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildModel.h"
@protocol AddChildrenCellDelegate;

@interface AddChildrenCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic, retain) NSIndexPath *indexPath;

@property (weak, nonatomic) NSMutableArray *groupArr;

@property (weak, nonatomic) ChildModel *cModel;

/**
 * 添加小孩的协议
 */
@property (nonatomic,weak) id <AddChildrenCellDelegate> mydelegate;

@end

/**
 * 添加小孩的协议
 */
@protocol AddChildrenCellDelegate <NSObject>

@optional
/**
 * 添加小孩 － 性别
 */
-(void)showUserSix:(NSIndexPath *)indexPath;
/**
 * 显示生日
 */
-(void)showBirthPicker:(NSIndexPath *)indexPath;
/**
 * 显示亲属关系
 */
-(void)showRelationship:(NSIndexPath *)indexPath;
@end