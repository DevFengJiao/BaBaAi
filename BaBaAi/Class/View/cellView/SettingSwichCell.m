//
//  SettingSwichCell.m
//  LBKidsApp
//
//  Created by kingly on 15/8/26.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "SettingSwichCell.h"


@implementation SettingSwichCell

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
        
        [_setSwitch addTarget:self action:@selector(switchAction:)forControlEvents:UIControlEventValueChanged];
        
        if ([_pModel.sParaValue intValue] == 0) {
            _setSwitch.on = NO;
        }else{
            _setSwitch.on = YES;
        }
        
        NSMutableArray *arr = [_groupArr objectAtIndex:_indexPath.section];
        NSMutableDictionary *dis = [arr objectAtIndex:_indexPath.row];
        
        _NameLabel.text = MLString([dis objectForKey:@"name"]);
        
        if ([[dis objectForKey:@"viewName"] isEqualToString:@"TimeIntervalVC"] == YES) {
            //时间间隔
            NSDictionary *dic = [BaseModel locPeriodArr];
            if (_pModel.sParaValue==nil || _pModel.sParaValue == 0) {
                _pModel.sParaValue = [[BaseModel locPeriodArrkeys] firstObject];
            }
           _noteLabel.text = [dic objectForKey:_pModel.sParaValue];
            
           if ([_locSwitchModel.sParaValue intValue] == 0) {
                _setSwitch.on = NO;
            }else{
                _setSwitch.on = YES;
            }
          
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"CollisionDetectionVC"] == YES){
            //碰撞等级
            _noteLabel.text = [[BaseModel cillLevelArr] objectAtIndex:[_pModel.sParaValue integerValue]];
            if ([_cillSwitchModel.sParaValue intValue] == 0) {
                _setSwitch.on = NO;
            }else{
               _setSwitch.on = YES;
            }
        
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"SheddingDetectionVC"] == YES){
           //脱落开关
     
          
            
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"AlertAreaVC"] == YES){
            //电子围栏
     
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"ReachToLocationVC"] == YES){
            //位置到达
     
        }

        
    }
}

#pragma mark  - switchAction
-(void)switchAction:(id)sender
{
    ParameterModel *switchModel = [[ParameterModel alloc] init];
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    

    if ([_pModel.sParaName isEqualToString:@"cillLevel"]) {
        //如果碰撞的时候
        
        if (isButtonOn) {
            _cillSwitchModel.sParaValue = @"1";
        }else {
            _cillSwitchModel.sParaValue = @"0";
        }
        switchModel = _cillSwitchModel;
        
    }else if ([_pModel.sParaName isEqualToString:@"locPeriod"]) {
        //定位定位
        if (isButtonOn) {
            _locSwitchModel.sParaValue = @"1";
        }else {
            _locSwitchModel.sParaValue = @"0";
        }
        switchModel = _locSwitchModel;
    }else{
        
        if (isButtonOn) {
            _pModel.sParaValue = @"1";
        }else {
            _pModel.sParaValue = @"0";
        }
        switchModel = _pModel;

    }
    
    if (_mydelegate && [_mydelegate respondsToSelector:@selector(switchAction:)]) {
        [_mydelegate switchAction:switchModel];
    }
    
}

@end
