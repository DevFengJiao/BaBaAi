//
//  AppDelegate+MainUI.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "AppDelegate+MainUI.h"
#import "FindViewController.h"
#import "LocationViewController.h"
#import "PhotoViewController.h"
#import "RelationViewController.h"
#import "SettingViewController.h"
#import "SystemSupport.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation AppDelegate (MainUI)
- (MainViewController *)fetchTabbarController
{
    [self appAppearanceConfig];
    
    MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[SystemSupport mainBundle]];
    //避免ListVC为空./
    self.mainVC = mainVC;
    mainVC.viewControllers = [self fetchAllViewController];
    return mainVC;
}

- (NSMutableArray *)fetchAllViewController
{
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"定位",@"联系",@"发现",@"设置", nil];
    NSArray *imageArray = @[@"tab_location",@"tab_connection",@"tab_find",@"tab_setting",];
    NSArray *selectImageArray = @[@"tab_location",@"tab_connection",@"tab_find",@"tab_setting",];
    NSMutableArray *classArray =[NSMutableArray arrayWithArray: @[@"LocationViewController",@"RelationViewController",@"FindViewController",@"SettingViewController"]];
    
//    if (LOGIN && USERID) {
//        [titleArray addObject:@"我的"];
//        [classArray addObject:@"ChatListViewController"];
//        [classArray addObject:@"MemberInfoViewController"];
//    }else
//    {
//        NSLog(@"MainUI:USERID :%@",USERID);
//        [titleArray addObject:@"我的"];
//        [classArray addObject:@"LoginViewController"];
//        [classArray addObject:@"LoginViewController"];
//    }
    
    NSMutableArray* viewControllers = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString *className in classArray) {
        Class class = NSClassFromString(className);
        if (class) {
            BaseViewController *rvc = [[class alloc] init];
            if ( [rvc isKindOfClass:[LocationViewController class]]) {
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:rvc];
                [viewControllers addObject:nc];
            }
            else
            {
                BaseNavigationController *nc = [[BaseNavigationController alloc] initWithRootViewController:rvc];
                [viewControllers addObject:nc];
            }
            
            
            rvc.title = titleArray[i]; //此方法会影响 NavigationItem 的 setTitle方法.
            if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
                UIImage *normalImage = [UIImage imageNamed:imageArray[i]];
                UIImage *selectImage = [UIImage imageNamed:selectImageArray[i]];
                [rvc.tabBarItem setFinishedSelectedImage:selectImage withFinishedUnselectedImage:normalImage];
                rvc.tabBarItem.title = titleArray[i];
                
                UIColor *selectColor = [UIColor colorFromHexString:@"#0fc1d1"];
                rvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:nil tag:i+1000];
                [rvc.tabBarItem setFinishedSelectedImage:selectImage withFinishedUnselectedImage:normalImage];
                [rvc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        selectColor, NSForegroundColorAttributeName,
                                                        nil] forState:UIControlStateHighlighted];
            }
            else
            {
                UIImage *normalImage = [[UIImage imageNamed:imageArray[i]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIImage *selectImage = [[UIImage imageNamed:selectImageArray[i]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIColor *selectColor = [UIColor colorFromHexString:@"#0fc1d1"];
                
                
                rvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:normalImage selectedImage:selectImage];
                rvc.tabBarItem.tag = i + 1000;
                [rvc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        selectColor, NSForegroundColorAttributeName,
                                                        nil] forState:UIControlStateHighlighted];
            }
            
            
        }
        
        
        i++;
    }
//    [viewControllers removeAllObjects];
//    
//    self.mainVC.locationVC = [[LocationViewController alloc]initWithNibName:@"LocationViewController" bundle:[SystemSupport mainBundle]];
//    self.mainVC.relationVC = [[RelationViewController alloc]initWithNibName:@"RelationViewController" bundle:[SystemSupport mainBundle]];
//    self.mainVC.photoVC = [[PhotoViewController alloc]initWithNibName:@"PhotoViewController" bundle:[SystemSupport mainBundle]];
//    self.mainVC.findVC = [[FindViewController alloc]initWithNibName:@"FindViewController" bundle:[SystemSupport mainBundle]];
//    self.mainVC.setVC = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:[SystemSupport mainBundle]];
//
//    [viewControllers addObject:self.mainVC.locationVC];
//    [viewControllers addObject:self.mainVC.relationVC];
//    [viewControllers addObject:self.mainVC.photoVC];
//    [viewControllers addObject:self.mainVC.findVC];
//    [viewControllers addObject:self.mainVC.setVC];
    
    return viewControllers;
}

-(void)appAppearanceConfig
{
    //GLOBAL APPEARANCE CONFIG
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor navbackgroundColor]];
        //不加这个有颜色会变淡，因为是由于半透明模糊引起的
        [[UINavigationBar appearance]setTranslucent:NO];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [[UINavigationBar appearance] setTitleTextAttributes:dict];
        [[UITableViewCell appearance] setTintColor:[UIColor navbackgroundColor]];
        
        if ([UINavigationBar instancesRespondToSelector:@selector(setBackIndicatorImage:)])
        {
            // iOS 7
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 5, 5, 5);
            [[UINavigationBar appearance] setBackIndicatorImage:[[[UIImage imageNamed:@"button-Return"] imageWithAlignmentRectInsets:insets] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[[UIImage imageNamed:@"button-Return"] imageWithAlignmentRectInsets:insets] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault]; // Takes out title
            
        }
    }
    else
    {
        [[UINavigationBar appearance] setTintColor:[UIColor navbackgroundColor]];
        
        [[UILabel appearance] setBackgroundColor:[UIColor clearColor]];
        // [[UITabBar appearance] setSelectedImageTintColor:APP_COLOR];
        
        // Change the title color of tab bar items
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithWhite:0.45 alpha:1.0], NSForegroundColorAttributeName,
                                                           nil] forState:UIControlStateNormal];
        UIColor *titleHighlightedColor = [UIColor navbackgroundColor];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           titleHighlightedColor, NSForegroundColorAttributeName,
                                                           nil] forState:UIControlStateSelected];
        
    }
    
    [[UISwitch appearance]setOnTintColor:[UIColor navbackgroundColor]];
    
}


@end

