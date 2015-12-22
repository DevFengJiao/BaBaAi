//
//  UINavigationController+Extension.h
//  drug
//
//  Created by tongqing on 15-4-20.
//  Copyright (c) 2015年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UINavigationControllerShouldPop <NSObject>

- (BOOL)navigationControllerShouldPop:(UINavigationController *)nav;
- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)nav;

@end

@interface UINavigationController (Extension) <UIGestureRecognizerDelegate>

@end
