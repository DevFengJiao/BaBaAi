//
//  BaseNavigationController.m
//  NewLingYou
//
//  Created by zlcs on 15/5/26.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    //
//    self.navigationBar.barTintColor = [UIColor colorWithRed:121/255.0 green:245/255.0 blue:200/255.0 alpha:0.1];
//    self.navigationBar.translucent =YES;//半透明
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated{
    
    [super setNavigationBarHidden:hidden animated:animated];
    
}

//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{//
//    
////    if ([viewController isKindOfClass:[MemberInfoViewController class]] || [viewController isKindOfClass:[LoginViewController class]]) {
//////        [viewController setAutomaticallyAdjustsScrollViewInsets:NO];
////        [super pushViewController:viewController animated:animated];
////        return;
////    }
//    
//    if (self.viewControllers.count >=1)
//    {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}

//-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    
//    return [super popViewControllerAnimated:animated];
//}

@end

@implementation UIViewController (BaseNavigationController)

- (void)navigationController:(BaseNavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    if ([navigationController isKindOfClass:[BaseNavigationController class]] == NO) {
//        return;
//    }
//    
//    UIViewController * targetVC = ([viewController isKindOfClass:[UITabBarController class]])?([(UITabBarController *)viewController selectedViewController]):viewController;
//    
//    if ([viewController isKindOfClass:[UITabBarController class]]) {
//        
//        viewController.navigationItem.leftBarButtonItems = targetVC.navigationItem.leftBarButtonItems;
//        viewController.navigationItem.rightBarButtonItems = targetVC.navigationItem.rightBarButtonItems;
//        viewController.navigationItem.title = targetVC.navigationItem.title;
//        viewController.navigationItem.titleView = targetVC.navigationItem.titleView;
//        
//    }
}
- (void)navigationController:(BaseNavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
}

@end

