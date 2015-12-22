//
//  MainViewController.h
//  NewLingYou
//
//  Created by Seven on 15/5/26.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"
#import "FindViewController.h"
#import "PhotoViewController.h"
#import "RelationViewController.h"
#import "SettingViewController.h"

@interface MainViewController : UITabBarController

@property (nonatomic, strong)LocationViewController *locationVC;
@property (nonatomic, strong)FindViewController     *findVC;
@property (nonatomic, strong)PhotoViewController    *photoVC;
@property (nonatomic, strong)RelationViewController *relationVC;
@property (nonatomic, strong)SettingViewController  *setVC;

@end
