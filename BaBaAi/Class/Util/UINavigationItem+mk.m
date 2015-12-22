//
//  UINavigationItem+mk.m
//  NewLingYou
//
//  Created by Seven on 15/5/22.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "UINavigationItem+mk.h"



@implementation UINavigationItem (mk)

- (void) setTitle:(NSString *)title
{
    UILabel* label = (UILabel*)self.titleView;
    if (label && [label isKindOfClass:[UILabel class]])
    {
        label.text = title;
        CGSize sizeIt = [title sizeWithFont:label.font];
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y,sizeIt.width,sizeIt.height);
        label.textColor = [UIColor navTitleColor];

    }
    else
    {
        UILabel* titleText = [[UILabel alloc]init];
        titleText.font = [UIFont boldSystemFontOfSize:NAVIGATIONBAR_TITLE_FONT];
        titleText.text = title;
        titleText.backgroundColor = [UIColor clearColor];
        CGSize sizeIt = [title sizeWithFont:titleText.font];
        titleText.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y,sizeIt.width,sizeIt.height);
        titleText.textColor = NAVIGATIONBAR_TITLE_COLOR;
        titleText.shadowColor = NAVIGATIONBAR_BACK_COLOR;
        titleText.shadowOffset = NAVIGATIONBAR_TEXT_OFFSET;
        [titleText setNumberOfLines:0];
        titleText.textAlignment = NSTextAlignmentCenter;
        self.titleView = titleText;
        self.titleView.userInteractionEnabled = YES;
    }
}


@end

