//
//  CollisionDetectionVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "BaseViewController.h"
#import "ParameterModel.h"

@protocol CollisionDetectionVCDelegate;

@interface CollisionDetectionVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) ParameterModel *cillLevelModel;

@property (nonatomic,weak) id <CollisionDetectionVCDelegate>delegate;

@end

@protocol CollisionDetectionVCDelegate <NSObject>
/**
 * 设置碰撞等级
 */
-(void)setCillLevelValue:(ParameterModel *)pModel;

@end