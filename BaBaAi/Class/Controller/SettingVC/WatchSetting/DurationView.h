//
//  DurationView.h
//  LBKidsApp
//
//  Created by kingly on 15/9/1.
//  Copyright (c) 2015年 kingly. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MrStatus.h"

@protocol DurationViewDelegate <NSObject>
- (void) removeSilentDuration:(int)index;
- (void) enableSlientRange:(BOOL)enable WithTag:(int)tag;
@end

@interface DurationView : UIView<UITextFieldDelegate>
@property(nonatomic,strong)  UILabel* titleLable;
@property(nonatomic,strong)  UITextField* fromField;
@property(nonatomic,strong)  UITextField* toField;
@property(nonatomic,strong)  UISwitch* enableSwith;
@property(nonatomic,strong)  UIButton* reduceDurationBtn;
@property(nonatomic,weak) id<DurationViewDelegate> durationViewDelegate;
@property(nonatomic,strong) MrStatus* mySilentDuration;

- (void) saveSilentDuration;
@end
