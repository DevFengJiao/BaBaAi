//
//  BirthdayPickerView.m
//  kidsApp
//
//  Created by kingly on 15/7/23.
//  Copyright (c) 2015年 kingly. All rights reserved.

#import "BirthdayPickerView.h"

@implementation BirthdayPickerView
{
    UIDatePicker* datePickerView;
    UIView* backView;
    NSString *sBirdOfDate;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        sBirdOfDate = _defaultBirdOfDate;
        
        CGRect backRect = CGRectMake(0, self.frame.size.height-150, kScreenWidth, 244);
        backView = [[UIView alloc] initWithFrame:backRect];
        backView.backgroundColor = [UIColor tabBackGroundColor];
        [self addSubview:backView];
        
        UIButton *cancelItem = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelItem.frame = CGRectMake(0, 0, 60, 44);
        [cancelItem setTitle:MLString(@"取消")  forState:UIControlStateNormal];
        [cancelItem setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [cancelItem addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *doneItem = [UIButton buttonWithType:UIButtonTypeCustom];
        doneItem.frame = CGRectMake(kScreenWidth-60, 0, 60, 44);
        [doneItem setTitle:MLString(@"确定")  forState:UIControlStateNormal];
        [doneItem setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [doneItem addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView* toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
        toolBar.backgroundColor = [UIColor barTintColor];
        [toolBar addSubview:cancelItem];
        [toolBar addSubview:doneItem];
        [backView addSubview:toolBar];
        
        datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, toolBar.frame.size.height, kScreenWidth, backView.frame.size.height-toolBar.frame.size.height-20)];
        [datePickerView setDatePickerMode:UIDatePickerModeDate];
		[backView addSubview:datePickerView];
        
        NSLog(@"sds:%@",_indexPath);
        [self showPickerView];
    }
    return self;
}

- (void) showPickerView
{
    NSString *defaultDateste = (_defaultBirdOfDate.length == 0)?kDefaultBirdOfDate:_defaultBirdOfDate;
    
    NSLog(@"%%%%,%@",_defaultBirdOfDate);
    //注释时间
//    NSDate *defaultDate= [NSDate dateFormatBODStyle:defaultDateste];
//    if (defaultDate)
//    {
//        datePickerView.date = defaultDate;
//    }
//    
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, self.frame.size.height-244+20,kScreenWidth , 244);
    } completion:nil];
}
- (void) cancelAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, self.frame.size.height, kScreenWidth, 244);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void) doneAction:(id)sender
{
    if ([_birthdayPickerViewDelegate respondsToSelector:@selector(finishSelectBOD:withIndexPath:)])
    {
        //注释时间
//        [_birthdayPickerViewDelegate finishSelectBOD:[NSDate dateStringBODStyle:datePickerView.date] withIndexPath:_indexPath];
    }
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, self.frame.size.height, kScreenWidth, 244);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
