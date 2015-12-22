//
//  DrawView.h
//  mapdraw
//
//  Created by admin on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <CoreGraphics/CGImage.h>

@protocol DrawViewDelegate <NSObject>
- (void)touchEndInDrawView:(BOOL)areaAvailable Points:(NSArray*)points;
@end

@interface DrawView : UIView
{
    void *data;
    CGContextRef context;
    BOOL candraw;
}

@property(nonatomic,weak)id <DrawViewDelegate> drawDelegate;
- (void)clearContext;
@end
