//
//  UIBarButtonItem+util.m
//  NewLingYou
//
//  Created by Seven on 15/6/5.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import "UIBarButtonItem+util.h"

#define  NAVIGATIONBAR_TEXT_COLOR      MK_RGBCOLOR(255,255,255)

#define NAVIGATIONBAR_TEXT_OFFSET       CGSizeMake(0.5, -0.5)
#define NAVIGATIONBAR_TEXT_FONT         16


#define NAVIGATIONBAR_ITEM_BTN_TAG      103   //UIBarButtonItem按钮标志
#define NAVIGATIONBAR_ITEM_LAB_TAG      104   //UIBarButtonItem文字标志

#define NAVIGATIONBAR_SHARP_WIDTH   20.0  //尖角宽度

#define NAVIGATIONBAR_TOP_HEIGHT    4.0   //圆角高度
#define NAVIGATIONBAR_TOP_WIDTH     4.0   //圆角宽度

#define NAVIGATIONBAR_BUTTON_HEIGHT     44.0f  //默认按钮高度
#define NAVIGATIONBAR_MIN_WIDTH        26.0  //最小字宽度
#define NAVIGATIONBAR_MAX_WIDTH         90.0  //最大字宽度
#define NAVIGATIONBAR_LINE_ROUNDWIDTH        1.0   //文字距圆角边界的距离
#define NAVIGATIONBAR_LINE_SHARPWIDTH  3.0   //文字距尖角边界的距离





@implementation UIBarButtonItem (util)

- (id)initWithTitle:(NSString *)title
              image:(UIImage *)image
           newStyle:(UIBarButtonItemNewStyle) style
             target:(id)target
             action:(SEL)action
{
    CGFloat baseHeight = NAVIGATIONBAR_BUTTON_HEIGHT;
    CGFloat sharpWidth = NAVIGATIONBAR_SHARP_WIDTH;
    CGFloat topHeight =  NAVIGATIONBAR_TOP_HEIGHT; //圆角宽度
    CGFloat topWidth = NAVIGATIONBAR_TOP_WIDTH;   //圆角高度
    CGFloat lineSharp = NAVIGATIONBAR_LINE_SHARPWIDTH;//尖角字边距
    CGFloat lineRound = NAVIGATIONBAR_LINE_ROUNDWIDTH; //圆角字边距.
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:NAVIGATIONBAR_TEXT_FONT];
    label.numberOfLines = 1;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = NAVIGATIONBAR_TEXT_COLOR;
    label.tag = NAVIGATIONBAR_ITEM_LAB_TAG;
    CGFloat labWidth = [label.text sizeWithFont:label.font].width;
    if (labWidth < NAVIGATIONBAR_MIN_WIDTH) {
        labWidth = NAVIGATIONBAR_MIN_WIDTH;
    }
    
    if (labWidth > NAVIGATIONBAR_MAX_WIDTH) {
        labWidth = NAVIGATIONBAR_MAX_WIDTH;
    }
    
    
    UIButton *button = [[UIButton alloc] init];
    button.exclusiveTouch = YES;
    button.tag = NAVIGATIONBAR_ITEM_BTN_TAG;
    [button addSubview:label];
    button.titleLabel.tag = style;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (style == UIBarButtonItemNewStyleSharp) {
        [label removeFromSuperview];
        UIImage *sharpImage = [UIImage imageNamed:@"nav_sharp"];
        CGFloat btnWidth = 44.0f;
        button.frame = CGRectMake(0, 0, btnWidth, baseHeight);
        [button setImage:sharpImage forState:UIControlStateNormal];
        if (!SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        }
        
    }
    
    else if (style == UIBarButtonItemNewStyleSharpText)
    {
        UIImage *sharpImage = [UIImage imageNamed:@"nav_sharp"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:sharpImage];
        imageView.frame = CGRectMake(0, 0, sharpWidth, baseHeight);
        imageView.backgroundColor = [UIColor clearColor];
        [button addSubview:imageView];
        CGFloat btnWidth = 2 * lineSharp + sharpWidth + labWidth;
        button.frame = CGRectMake(0, 0, btnWidth, baseHeight);
        label.frame = CGRectMake(sharpWidth + lineSharp - 5, 0, labWidth, baseHeight);//5 为 图片多出来的空白.
    }
    
    else if (style == UIBarButtonItemNewStyleRound)
    {
        UIImage *roundImage = [UIImage imageNamed:@"nav_round_normal.png"];
        UIImage *lightRoundImage = [UIImage imageNamed:@"nav_round_press.png"];
        CGFloat btnwidth = 2 * topWidth + 2*lineRound + labWidth;
        button.frame = CGRectMake(0, 5, btnwidth, 34.0f);
        label.frame = CGRectMake(topWidth+lineRound, 0, labWidth, 34.0f);
        [button setBackgroundImage:[roundImage stretchableImageWithLeftCapWidth:topWidth topCapHeight:topHeight] forState:UIControlStateNormal];
        [button setBackgroundImage:[lightRoundImage stretchableImageWithLeftCapWidth:topWidth topCapHeight:topHeight] forState:UIControlStateHighlighted];
    }
    else if (style == UIBarButtonItemNewStyleText)
    {
        CGFloat btnWidth = 2 *lineRound + labWidth;
        button.frame = CGRectMake(0, 0, btnWidth, baseHeight);
        label.frame = CGRectMake(lineRound, 0, labWidth, baseHeight);
    }
    else if (style == UIBarButtonItemNewStyleBack)
    {
        [label removeFromSuperview];
        
        UIImage *backImage = [UIImage imageNamed:@"nav_back"];
        CGFloat btnWidth = backImage.size.width;
        [button setImage:backImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, btnWidth, baseHeight);
        if (!SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
        }
    }
    else if (style == UIBarButtonItemNewStyleImage && image)
    {
        [label removeFromSuperview];
        UIImage *roundImage = [UIImage imageNamed:@"nav_round_normal.png"];
        UIImage *lightRoundImage = [UIImage imageNamed:@"nav_round_press.png"];
        
        CGFloat btnWidth = 2*topWidth + 2 * lineRound + image.size.width;
        button.frame = CGRectMake(0, 0, btnWidth, 34.0f);
        [button setBackgroundImage:[roundImage stretchableImageWithLeftCapWidth:topWidth topCapHeight:topHeight] forState:UIControlStateNormal];
        [button setBackgroundImage:[lightRoundImage stretchableImageWithLeftCapWidth:topWidth topCapHeight:topHeight] forState:UIControlStateHighlighted];
        [button   setImage:image forState:UIControlStateNormal];
        
    }
    else if (style == UIBarButtonItemNewStyleOnlyImage)
    {
        [label removeFromSuperview];
        button.frame = CGRectMake(0, 0,34.0f, 34.0f);
        [button setImage:image forState:UIControlStateNormal];
    }
    
    
    id custonView = [self initWithCustomView:button];
    return custonView;
}


- (id)initWithTitle:(NSString *)title
           newStyle:(UIBarButtonItemNewStyle)style
             target:(id)target
             action:(SEL)action
{
    return [self initWithTitle:title image:nil newStyle:style target:target action:action];
}

- (id)initWithImage:(UIImage *)image
           newStyle:(UIBarButtonItemNewStyle)style
             target:(id)target
             action:(SEL)action
{
    return [self initWithTitle:nil image:image newStyle:style target:target action:action];
}

- (id)initBackItemTarget:(id)target action:(SEL)action
{
    return [self initWithTitle:nil image:nil newStyle:UIBarButtonItemNewStyleBack target:target action:action];
}

- (id)initsharpLeftItemTarget:(id)target action:(SEL)action
{
    return [self initWithTitle:nil image:nil newStyle:UIBarButtonItemNewStyleSharp target:target action:action];
}

- (id)initsharpLeftItemTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [self initWithTitle:title image:nil newStyle:UIBarButtonItemNewStyleSharpText target:target action:action];
}

@end
