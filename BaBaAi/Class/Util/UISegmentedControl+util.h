//
//  UISegmentedControl+util.h
//  NewLingYou
//
//  Created by Seven on 15/5/21.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (util)

//默认加粗 16号字体.点亮时为:黑色白底,为选中为 白字蓝色 选中的index 为 0; style为.UISegmentedControlStyleBordered
- (id)init;
- (void)setDefaultSegment;
- (void)setTitleColor:(UIColor *)normalColor SelectTitleColor:(UIColor *)selectColor;
- (void)setTitleColor:(UIColor *)normalColor SelectTitleColor:(UIColor *)selectColor font:(UIFont *)font;
- (void)setTitleColor:(UIColor *)normalColor SelectTitleColor:(UIColor *)selectColor font:(UIFont *)font TintColor:(UIColor *)tintColor bgColor:(UIColor *)bgColor;

@end
