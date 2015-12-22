//
//  SettingSwichCell.h
//  LBKidsApp
//
//  Created by kingly on 15/8/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParameterModel.h"
@protocol SettingSwichCellDelegate;
@interface SettingSwichCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UISwitch *setSwitch;

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (weak, nonatomic) ParameterModel *pModel;
@property (weak, nonatomic) ParameterModel *cillSwitchModel;  //碰撞检测开关
@property (weak, nonatomic) ParameterModel *locSwitchModel;   //定时定位开关

@property (weak, nonatomic) NSMutableArray *groupArr;

/**
 * 设置手表的协议
 */
@property (nonatomic,weak) id <SettingSwichCellDelegate> mydelegate;

@end

/**
 *  设置手表的协议
 */
@protocol SettingSwichCellDelegate <NSObject>

@optional
/**
 * 设置手表switchAction
 */
-(void)switchAction:(ParameterModel *)pModel;


@end
