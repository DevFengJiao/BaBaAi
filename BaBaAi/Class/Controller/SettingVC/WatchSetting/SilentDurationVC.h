//
//  SilentDurationVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/31.
//  Copyright (c) 2015年 kingly. All rights reserved.
//


@interface SilentDurationVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;


@property(nonatomic,weak) IBOutlet UIButton* addDurationBtn;
@property(nonatomic,weak) IBOutlet UIView* topView;
@property(nonatomic,weak) IBOutlet UIView* durationsView;
@property(nonatomic,weak) IBOutlet UIView* bottomView;
@property(nonatomic,weak) IBOutlet UIButton* deleteAllDurationsBtn;

//Localizable
@property(nonatomic,weak) IBOutlet UILabel* titleLabel;
@property(nonatomic,weak) IBOutlet UILabel* infoLabel;

@end
