//
//  UIBarButtonItem+util.h
//  NewLingYou
//
//  Created by Seven on 15/6/5.
//  Copyright (c) 2015年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum _UIBarButtonItemNewStyle
{
    UIBarButtonItemNewStyleSharp, //尖角无字;
    UIBarButtonItemNewStyleSharpText,//尖角有字,类似返回按钮.
    UIBarButtonItemNewStyleRound, //圆角代图片的.
    UIBarButtonItemNewStyleText, //文字;
    UIBarButtonItemNewStyleBack,//返回按钮字样
    UIBarButtonItemNewStyleImage,//按钮包围图片
    UIBarButtonItemNewStyleOnlyImage //只有图片.
    
}UIBarButtonItemNewStyle;


@interface UIBarButtonItem (util)

//UIBarButtonItemNewStyleSharp
//UIBarButtonItemNewStyleSharpText
//UIBarButtonItemNewStyleRound
//UIBarButtonItemNewStyleText
//UIBarButtonItemNewStyleBack
- (id)initWithTitle:(NSString *)title
           newStyle:(UIBarButtonItemNewStyle) style
             target:(id)target
             action:(SEL)action;

//UIBarButtonItemNewStyleSharp
//UIBarButtonItemNewStyleBack
//UIBarButtonItemNewStyleImage
//UIBarButtonItemNewStyleOnlyImage
- (id)initWithImage:(UIImage*)image
           newStyle:(UIBarButtonItemNewStyle) style
             target:(id)target
             action:(SEL)action;

//UIBarButtonItemNewStyleBack
- (id)initBackItemTarget:(id)target action:(SEL)action;

//UIBarButtonItemNewStyleSharp
- (id)initsharpLeftItemTarget:(id)target action:(SEL)action;

- (id)initsharpLeftItemTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
