//
//  AlertAreaVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

//#import <KidsLocation/BaseViewController.h>

@interface AlertAreaVC : BaseViewController

@property (nonatomic,weak) IBOutlet UIView * bottomView;
@property (nonatomic,weak) IBOutlet UIView * portraintView;
@property (nonatomic,weak) IBOutlet UIImageView * portraint;
@property (nonatomic,weak) IBOutlet UILabel * nameLabel;
@property (nonatomic,weak) IBOutlet UILabel * defaultLabel;
@property (nonatomic,weak) IBOutlet UIView * promptView;
@property (nonatomic,weak) IBOutlet UILabel * promptLabel;
@property (nonatomic,weak) IBOutlet UIView * buttonsView;
@property (nonatomic,weak) IBOutlet UIButton * sumbitButton;
@property (nonatomic,weak) IBOutlet UIButton * cancelButton;

@end
