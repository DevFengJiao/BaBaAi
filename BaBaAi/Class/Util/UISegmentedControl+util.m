//
//  UISegmentedControl+util.m
//  NewLingYou
//
//  Created by Seven on 15/5/21.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "UISegmentedControl+util.h"

@implementation UISegmentedControl (util)

- (id)init
{
    if (self = [super init]) {
        self.layer.cornerRadius = 8;
        self.selectedSegmentIndex = 0;
    }
    return self;
}

- (void)setDefaultSegment
{
    [self setTitleColor:[UIColor whiteColor] SelectTitleColor:[UIColor navbackgroundColor]];
}

- (void)setTitleColor:(UIColor *)normalColor SelectTitleColor:(UIColor *)selectColor
{
    [self setTitleColor:normalColor SelectTitleColor:selectColor font:[UIFont boldSystemFontOfSize:16.0]];
}

- (void)setTitleColor:(UIColor *)normalColor SelectTitleColor:(UIColor *)selectColor font:(UIFont *)font
{
    
    UIColor *tintColor = [UIColor whiteColor];
    UIColor *bgColor = [UIColor colorFromHexString:@"#32bbf2"];
    [self setTitleColor:normalColor SelectTitleColor:selectColor font:font TintColor:tintColor bgColor:bgColor];
}

- (void)setTitleColor:(UIColor *)normalColor SelectTitleColor:(UIColor *)selectColor font:(UIFont *)font TintColor:(UIColor *)tintColor bgColor:(UIColor *)bgColor
{
    self.layer.cornerRadius = 8;
    self.selectedSegmentIndex = 0;
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:font,
                                             NSForegroundColorAttributeName: selectColor};
    [self setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:font,
                                               NSForegroundColorAttributeName: normalColor};
    [self setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    self.tintColor = tintColor;
    self.backgroundColor = bgColor;
    self.segmentedControlStyle = UISegmentedControlStyleBordered;
    
    
}


@end
