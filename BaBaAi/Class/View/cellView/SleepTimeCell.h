//
//  SleepTimeCell.h
//  LBKidsApp
//
//  Created by kingly on 15/8/29.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <KidsLocation/ParameterModel.h>

@protocol SleepTimeCellDelegate;

@interface SleepTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *startTimeField;
@property (weak, nonatomic) IBOutlet UITextField *endField;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;

- (IBAction)OnClickEndTime:(id)sender;
- (IBAction)OnClickStartTime:(id)sender;

@property (nonatomic, retain) NSIndexPath *indexPath;
@property (weak, nonatomic) ParameterModel *pModel;

@property (weak, nonatomic) NSMutableArray *groupArr;


/**
 * 设置手表的协议
 */
@property (nonatomic,weak) id <SleepTimeCellDelegate> mydelegate;

@end

/**
 *  设置手表的协议
 */
@protocol SleepTimeCellDelegate <NSObject>

@optional
/**
 * 设置手表SleepTimeswitchAction
 */
-(void)SleepTimeswitchAction:(ParameterModel *)pModel;
/**
 * 点击开始时间
 */
-(void)onClickStartTime:(ParameterModel *)pModel withIndexPath:(NSIndexPath *)indexPath;
/**
 * 点击结束时间
 */
-(void)OnClickEndTime:(ParameterModel *)pModel withIndexPath:(NSIndexPath *)indexPath;


@end