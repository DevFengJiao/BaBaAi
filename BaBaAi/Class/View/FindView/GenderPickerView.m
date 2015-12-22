//
//  GenderPickerView.m
//  kidsApp
//
//  Created by kingly on 15/7/23.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "GenderPickerView.h"

@implementation GenderPickerView
{
    UIPickerView* pickerView;
    UIView* backView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
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
        doneItem.frame = CGRectMake(kScreenWidth-60, 0,60, 44);
        [doneItem setTitle:MLString(@"确定")  forState:UIControlStateNormal];
        [doneItem setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [doneItem addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView* toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
        toolBar.backgroundColor = [UIColor barTintColor];
        [toolBar addSubview:cancelItem];
        [toolBar addSubview:doneItem];
        [backView addSubview:toolBar];
        
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolBar.frame.size.height, kScreenWidth, backView.frame.size.height-toolBar.frame.size.height-20)];
		pickerView.delegate = self;
		pickerView.dataSource = self;
		pickerView.showsSelectionIndicator = YES;
		[backView addSubview:pickerView];
        
        [self showPickerView];
    }
    return self;
}

- (void) showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, self.frame.size.height-244+20, kScreenWidth, 244);
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
    if ([_genderPickerViewDelegate respondsToSelector:@selector(finishSelectGender:withIndexPath:)])
    {
        [_genderPickerViewDelegate finishSelectGender:(int)[pickerView selectedRowInComponent:0] withIndexPath:_indexPath];
    }
    [UIView animateWithDuration:0.3 animations:^{
        backView.frame = CGRectMake(0, self.frame.size.height, kScreenWidth, 244);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark pickerView delegate
//返回pickerview的组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

//返回每个组件上的行数
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return 2;
}

//设置每行显示的内容


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _genderData[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

//自定义pickerview使内容显示在每行的中间，默认显示在每行的左边（(NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component）
- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *theLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [thePickerView rowSizeForComponent:component].width, [thePickerView rowSizeForComponent:component].height)];
    
    theLabel.text = _genderData[row];
	[theLabel setTextAlignment:NSTextAlignmentCenter];
    return theLabel;
}

//当你选中pickerview的某行时会调用该函数。
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSLog(@"You select row %d",(int)row);
//	if (row == 0)
//    {
//		selectLabel.text = @"you select 男";
//	}else if (row == 1) {
//		selectLabel.text = @"you select 女";
//	}
	
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
