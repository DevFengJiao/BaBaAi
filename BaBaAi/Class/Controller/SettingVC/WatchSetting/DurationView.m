//
//  DurationView.m
//  LBKidsApp
//
//  Created by kingly on 15/9/1.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "DurationView.h"



@implementation DurationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(17, 5, 140,21)];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLable];
        
        _fromField = [[UITextField alloc] initWithFrame:CGRectMake(12, 31, 86, 30)];
        _fromField.font = [UIFont systemFontOfSize:14];
        _fromField.borderStyle = UITextBorderStyleRoundedRect;
        _fromField.keyboardType = UIKeyboardTypeNumberPad;
        _fromField.delegate = self;
        _fromField.placeholder = MLString(@"小时:分钟");
        _fromField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_fromField];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 36, 14, 18)];
        [imageView setImage:[[SystemSupport share]imageOfFile:@"arrowSilent"]];
        [self addSubview: imageView];
        
        _toField = [[UITextField alloc] initWithFrame:CGRectMake(132, 30, 86, 30)];
        _toField.font = [UIFont systemFontOfSize:14];
        _toField.borderStyle = UITextBorderStyleRoundedRect;
        _toField.keyboardType = UIKeyboardTypeNumberPad;
        _toField.delegate = self;
        _toField.placeholder = MLString(@"小时:分钟");
        _toField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_toField];
        
        _reduceDurationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceDurationBtn.frame = CGRectMake(kScreenWidth-59, 31, 28, 28);
        _reduceDurationBtn.hidden = YES;
        [_reduceDurationBtn addTarget:self action:@selector(deleteDurationAction:) forControlEvents:UIControlEventTouchUpInside];
        [_reduceDurationBtn setBackgroundImage:[[SystemSupport share]imageOfFile:@"reduceIcon_normal"] forState:UIControlStateNormal];
        [_reduceDurationBtn setBackgroundImage:[[SystemSupport share]imageOfFile:@"reduceIcon_disable"] forState:UIControlStateHighlighted];
        [_reduceDurationBtn setBackgroundImage:[[SystemSupport share] imageOfFile:@"reduceIcon_disable"] forState:UIControlStateDisabled];
        [self addSubview:_reduceDurationBtn];
        
        _enableSwith = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth-59, 31, 49, 31)];
        _enableSwith.on = YES;
        [_enableSwith addTarget:self action:@selector(enableSlientRange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_enableSwith];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)deleteDurationAction:(UIButton*)sender
{
    if ([_durationViewDelegate respondsToSelector:@selector(removeSilentDuration:)])
    {
        [_durationViewDelegate removeSilentDuration:(int)self.tag];
    }
}

- (void) enableSlientRange:(UISwitch*)sender
{
    if ([_durationViewDelegate respondsToSelector:@selector(enableSlientRange:WithTag:)])
    {
        [_durationViewDelegate enableSlientRange:sender.on WithTag:(int)self.tag];
    }
}

- (void) setMySilentDuration:(MrStatus *)mySilentDuration
{
    _mySilentDuration = mySilentDuration;
    if (mySilentDuration.range)
    {
        _mySilentDuration.fromTime = [NSString stringWithFormat:@"%@:%@",[mySilentDuration.range substringWithRange:NSMakeRange(0, 2)],[mySilentDuration.range substringWithRange:NSMakeRange(2, 2)]];
        _mySilentDuration.toTime = [NSString stringWithFormat:@"%@:%@",[mySilentDuration.range substringWithRange:NSMakeRange(4, 2)],[mySilentDuration.range substringWithRange:NSMakeRange(6, 2)]];
    }
    _fromField.text = [NSString transferString:_mySilentDuration.fromTime];
    _toField.text = [NSString transferString:_mySilentDuration.toTime];
    
    if (_mySilentDuration.enabled==0) {
        _enableSwith.on=NO;
    }
    if (_mySilentDuration.enabled==1) {
        _enableSwith.on=YES;
    }
    
}

- (void) saveSilentDuration
{
    _mySilentDuration.imei    =  [[UserHandle standardHandle] sImei];
    _mySilentDuration.fromTime = _fromField.text;
    _mySilentDuration.toTime = _toField.text;
    _mySilentDuration.enabled = _enableSwith.on;
    NSLog(@"%@--%@",_fromField.text,_toField.text);
}

#pragma mark - TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![string isEqualToString:@""] && ![self isPureInt:string])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:MLString(@"静音时段只能包含数字!") message:Nil delegate:Nil cancelButtonTitle:MLString(@"确定") otherButtonTitles:Nil, nil];
        [alertView show];
        return NO;
    }
    NSString* time = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![string isEqualToString:@""])
    {
        if (time.length >= 5)
        {
            return NO;
        }else
        {
            if (time.length == 1)
            {
                textField.text = [NSString stringWithFormat:@"%@%@:",time,string];
                return NO;
            }
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_fromField resignFirstResponder];
    [_toField resignFirstResponder];
    
    return YES;
}

- (BOOL)isPureInt:(NSString *)string
{
    int val;
    NSScanner* scan = [NSScanner scannerWithString:string];
    while ([scan isAtEnd] == NO) {
        
        if (![scan scanInt:&val])
        {
            return NO;
        }
    }
    return YES;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
