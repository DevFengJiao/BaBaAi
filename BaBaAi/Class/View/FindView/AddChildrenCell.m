//
//  AddChildrenCell.m
//  LBKidsApp
//
//  Created by kingly on 15/8/12.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "AddChildrenCell.h"

@implementation AddChildrenCell

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
        
        
        
        NSMutableArray *arr = [_groupArr objectAtIndex:_indexPath.section];
        NSMutableDictionary *dis = [arr objectAtIndex:_indexPath.row];
        
        _nameLabel.text = MLString([dis objectForKey:@"name"]);
       
        _nameTextField.tag = _indexPath.row+100*(_indexPath.section+1);
        
        if ([[dis objectForKey:@"viewName"] isEqualToString:@"childname"] == YES){
            _nameTextField.text = (_cModel.sChildName!=nil)?_cModel.sChildName:@"";
    
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"height"] == YES){
            
            if (_cModel.iHeight>0) {
                _nameTextField.text = [NSString stringWithFormat:@"%d",_cModel.iHeight];
            }else{
                _nameTextField.text = @"";
            }
            [_nameTextField setKeyboardType:UIKeyboardTypeNumberPad];
            
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"weight"] == YES){
            
            if (_cModel.fWeight>0) {
                _nameTextField.text = [NSString stringWithFormat:@"%.1f",_cModel.fWeight];
            }else{
                _nameTextField.text = @"";
            }
            [_nameTextField setKeyboardType:UIKeyboardTypeDecimalPad];
            
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"watchphone"] == YES){
            _nameTextField.text = (_cModel.sWatchphone!=nil)?_cModel.sWatchphone:@"";

            [_nameTextField setKeyboardType:UIKeyboardTypePhonePad];
            
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"phone"] == YES){
              _nameTextField.text = (_cModel.sPhone!=nil)?_cModel.sPhone:@"";
              [_nameTextField setKeyboardType:UIKeyboardTypePhonePad];
            
        }else if([[dis objectForKey:@"viewName"] isEqualToString:@"imei"] == YES){
            _nameTextField.text = (_cModel.simei!=nil)?_cModel.simei:@"";
            [_nameTextField setKeyboardType:UIKeyboardTypePhonePad];
            
        }else if ([[dis objectForKey:@"name"] isEqualToString:@"性别"] == YES) {
            _nameTextField.enabled = NO;
            _nameTextField.text = (_cModel.iGender == 0)?MLString(@"男孩"):MLString(@"女孩");
            UIView *sixView= [[UIView alloc] init];
            sixView.backgroundColor= [UIColor clearColor];
            sixView.frame= CGRectMake(0,0, kScreenWidth, self.contentView.frame.size.height);
            UITapGestureRecognizer *tapPortrait = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showUserSix:)];
            sixView.userInteractionEnabled = YES;
            [sixView addGestureRecognizer:tapPortrait];
            
            [self.contentView addSubview:sixView];
        }else if ([[dis objectForKey:@"name"] isEqualToString:@"生日"] == YES) {
             _nameTextField.enabled = NO;
            if (_cModel.sbirthdate!=nil) {
                NSMutableString * birth =[NSMutableString stringWithString:_cModel.sbirthdate];
                _nameTextField.text      = birth;
              
            }else{
                 _nameTextField.text      = @"2015-01-01";
            }
            UIView *srView= [[UIView alloc] init];
            srView.backgroundColor= [UIColor clearColor];
            srView.frame= CGRectMake(0,0, kScreenWidth, self.contentView.frame.size.height);
            UITapGestureRecognizer *tapPortrait = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBirthPicker:)];
            srView.userInteractionEnabled = YES;
            [srView addGestureRecognizer:tapPortrait];
            [self.contentView addSubview:srView];
        }else if ([[dis objectForKey:@"name"] isEqualToString:@"亲属关系"] == YES) {
            _nameTextField.enabled = NO;
            NSArray *relationshipArr  = [NSArray arrayWithObjects:MLString(@"爸爸"),MLString(@"妈妈"),MLString(@"爷爷"),MLString(@"奶奶"),MLString(@"叔叔"),MLString(@"阿姨"),MLString(@"伯父"),MLString(@"伯母"),MLString(@"其他"), nil];
            
            if (_cModel.iRelationship == 0) {
                
                _nameTextField.text = relationshipArr[_cModel.iRelationship];

            }else{
                _nameTextField.text = relationshipArr[_cModel.iRelationship-1];
            }
            
            UIView *srView= [[UIView alloc] init];
            srView.backgroundColor= [UIColor clearColor];
            srView.frame= CGRectMake(0,0, kScreenWidth, self.contentView.frame.size.height);
            UITapGestureRecognizer *tapPortrait = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showRelationship:)];
            srView.userInteractionEnabled = YES;
            [srView addGestureRecognizer:tapPortrait];
            [self.contentView addSubview:srView];
        }

        
        

    }
}
/**
 * 显示性别
 */
-(void)showUserSix:(UITapGestureRecognizer *)sender
{
    if (_mydelegate && [_mydelegate respondsToSelector:@selector(showUserSix:)]) {
        [_mydelegate showUserSix:_indexPath];
    }
}
/**
 * 显示生日
 */
-(void)showBirthPicker:(UITapGestureRecognizer *)sender{

    if (_mydelegate && [_mydelegate respondsToSelector:@selector(showBirthPicker:)]) {
        [_mydelegate showBirthPicker:_indexPath];
    }
}
/**
 * 显示亲属关系
 */
-(void)showRelationship:(UITapGestureRecognizer *)sender{

    if (_mydelegate && [_mydelegate respondsToSelector:@selector(showRelationship:)]) {
        [_mydelegate showRelationship:_indexPath];
    }
}

@end
