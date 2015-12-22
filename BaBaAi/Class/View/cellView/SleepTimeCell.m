//
//  SleepTimeCell.m
//  LBKidsApp
//
//  Created by kingly on 15/8/29.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "SleepTimeCell.h"

@implementation SleepTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 * 设置数据模型，刷新视图
 */
-(void)setGroupArr:(NSMutableArray *)groupArr
{
    if (_groupArr != groupArr) {
        _groupArr = nil;
        _groupArr = groupArr;
        
        [_switchBtn addTarget:self action:@selector(switchAction:)forControlEvents:UIControlEventValueChanged];
        
        if (_pModel.iEnabled == 0) {
            _switchBtn.on = NO;
        }else{
            _switchBtn.on = YES;
        }
        
        if (_pModel.sParaValue.length==8) {
            
           
            [_startBtn setTitle:[NSString stringWithFormat:@"%@:%@",[_pModel.sParaValue substringWithRange:NSMakeRange(0, 2)],[_pModel.sParaValue substringWithRange:NSMakeRange(2, 2)]] forState:UIControlStateNormal];
            [_endBtn setTitle:[NSString stringWithFormat:@"%@:%@",[_pModel.sParaValue substringWithRange:NSMakeRange(4, 2)],[_pModel.sParaValue substringWithRange:NSMakeRange(6, 2)]] forState:UIControlStateNormal];
            
            
        }
        
        
        NSMutableArray *arr = [_groupArr objectAtIndex:_indexPath.section];
        NSMutableDictionary *dis = [arr objectAtIndex:_indexPath.row];
        
        _titleLabel.text = MLString([dis objectForKey:@"name"]);
        
        
    }
}

#pragma mark  - switchAction
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    
    if (isButtonOn == YES) {
        _pModel.iEnabled = 1;
    }else{
        _pModel.iEnabled = 0;
    }
    
    if (_mydelegate && [_mydelegate respondsToSelector:@selector(SleepTimeswitchAction:)]) {
        [_mydelegate SleepTimeswitchAction:_pModel];
    }
    
}

/**
 * 点击结束时间
 */
- (IBAction)OnClickEndTime:(id)sender {
    
    if (_mydelegate && [_mydelegate respondsToSelector:@selector(OnClickEndTime:withIndexPath:)]) {
        [_mydelegate OnClickEndTime:_pModel withIndexPath:_indexPath];
    }
    
}

/**
 * 点击开始时间
 */

- (IBAction)OnClickStartTime:(id)sender{
    
    if (_mydelegate && [_mydelegate respondsToSelector:@selector(onClickStartTime:withIndexPath:)]) {
        [_mydelegate onClickStartTime:_pModel withIndexPath:_indexPath];
    }
}
@end
