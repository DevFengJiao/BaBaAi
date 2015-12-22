//
//  TimeIntervalVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//


#import "ParameterModel.h"

@protocol TimeIntervalVCDelegate;

@interface TimeIntervalVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) ParameterModel *locPeriodModel;

@property (nonatomic,weak) id <TimeIntervalVCDelegate>delegate;

@end

@protocol TimeIntervalVCDelegate <NSObject>

-(void)setLocPeriodValue:(ParameterModel *)pModel;

@end