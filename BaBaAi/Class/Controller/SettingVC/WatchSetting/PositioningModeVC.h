//
//  PositioningModeVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//



@protocol PositioningModeVCDelegate;
@interface PositioningModeVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (readwrite) int locModeValue; //定位方式


@property (nonatomic,weak) id <PositioningModeVCDelegate>delegate;

@end

@protocol PositioningModeVCDelegate <NSObject>

-(void)setLocModeValue:(int )locMValue;

@end
