//
//  DrawView.m
//  mapdraw
//
//  Created by admin on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"

static float MIN_LENGTH_FOR_MOVE = 10;

@implementation DrawView
{
    bool mComplete;
    NSMutableArray* mPosArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mComplete = NO;
        mPosArray = [NSMutableArray array];
        int width = self.bounds.size.width;
        int height = self.bounds.size.height;
        data = malloc(width * height * 4);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        context = CGBitmapContextCreate(Nil, width, height, 8, 4 * width,
                                        colorSpace, kCGImageAlphaPremultipliedFirst);
        CGColorSpaceRelease(colorSpace);
        
        candraw = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.2];
        //[self clear];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextDrawImage(currentContext, rect, image);
    CGImageRelease(image);
    //CGContextRelease(currentContext);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    CGContextMoveToPoint(context, point.x, point.y);
    [mPosArray addObject:[NSValue valueWithCGPoint:point]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)evnet
{
    if (!mComplete)
    {
        CGPoint p = [[touches anyObject] locationInView:self];
        [self handleTouchMove:p];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!mComplete)
    {
        CGPoint firstPos = [mPosArray[0] CGPointValue];
        CGPoint lastPos = [mPosArray[mPosArray.count - 1] CGPointValue];
        int IntersectIdx = [self getIntersectPos:firstPos Position:lastPos LastLine:TRUE];
        [self rebuildPath];
        
        if (IntersectIdx == -1)
        {
            mComplete = true;
        } else
        {
            NSLog(@"================ Draw Cancel ================");
        }
        
        if ([_drawDelegate respondsToSelector:@selector(touchEndInDrawView:Points:)])
        {
            [_drawDelegate touchEndInDrawView:mComplete Points:mPosArray];
        }
    }
    
    [self setNeedsDisplay];
}

#pragma -
#pragma mark - Public Method
- (void) clearContext
{
    mComplete = NO;
    [mPosArray removeAllObjects];
     CGContextClearRect(context, self.frame);
    [self setNeedsDisplay];
}

#pragma -
#pragma mark - Private Methods
- (BOOL) handleTouchMove:(CGPoint)pos
{
    if (mPosArray.count == 0)
    {
        return false;
    }
    
    int posArraySize = mPosArray.count;
    CGPoint lastPos = [mPosArray[posArraySize - 1] CGPointValue];
    // 如果此次MOVE点跟上一个有效点的距离小于一定值，则忽略该点
//    if (fabsf(pos.x - lastPos.x) < MIN_LENGTH_FOR_MOVE
//        && fabsf(pos.y - lastPos.y) < MIN_LENGTH_FOR_MOVE) {
//        return false;
//    }
    if ([self distanceBetweenTwoPoints:pos Point:lastPos] < MIN_LENGTH_FOR_MOVE)
    {
        return false;
    }
    
    // 如果此次MOVE点跟倒数第二个有效点重合，则忽略该点
    if (posArraySize >= 2 && CGPointEqualToPoint(pos, [mPosArray[posArraySize - 2] CGPointValue]))
    {
        return false;
    }
    
    int IntersectIdx = [self getIntersectPos:pos Position:lastPos LastLine:false];
    
    if (IntersectIdx == -1)
    {
        // 新画的线段与之前所有线段都不相交
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, 3);
        CGContextMoveToPoint(context, lastPos.x, lastPos.y);
        CGContextAddQuadCurveToPoint(context, lastPos.x, lastPos.y, pos.x, pos.y);
        CGContextSetRGBStrokeColor(context,0,0,1,1);//要用RGB的
        CGContextStrokePath(context);
        [self setNeedsDisplay];
        
        [mPosArray addObject:[NSValue valueWithCGPoint:pos]];
    } else
    {
        // 新画的线段与之前的第IntersectIdx条线段相交
        int firstPositionIdx = IntersectIdx;
        // 删掉前面的IntersectIdx+1条线段
        for (int i = 0; i <= firstPositionIdx; i++)
        {
            [mPosArray removeObjectAtIndex:0];
        }
        
        // mPath.lineTo(firstPos.x, firstPos.y);
        [self rebuildPath];
        mComplete = true;
        if ([_drawDelegate respondsToSelector:@selector(touchEndInDrawView:Points:)])
        {
            [_drawDelegate touchEndInDrawView:mComplete Points:mPosArray];
        }
    }
    
    return true;
}

/**
 * 判断指定线段（传入的参数）与PosArray中的第几条线段相交
 *
 * @param a1
 *            指定线段的端点
 * @param a2
 *            指定线段的端点
 * @param isLastLine
 *            是否为最后一条线段（即用于闭合区域的那条线段），当需要判断最后一条线段是否与原线段交叉时，置为true
 * @return 返回-1，则表示指定线段与PosArray中的线段都不相交
 */
- (int) getIntersectPos:(CGPoint) a1 Position:(CGPoint) a2  LastLine:(BOOL) isLastLine
{
    // 已有线段数量
    int lineCount = mPosArray.count - 1;
    int startPosIdx = isLastLine ? 1 : 0;
    int endPosIdx = isLastLine ? (lineCount - 2) : (lineCount - 1);
    
    for (int i = startPosIdx; i < endPosIdx; i++)
    {
        CGPoint b1 = [mPosArray[i] CGPointValue];
        CGPoint b2 = [mPosArray[i+1] CGPointValue];
        
        if ([self IsTwoLineIntersect:a1 CPoint:a2 CPoint:b1 CPoint:b2])
        {
            return i;
        }
    }
    
    return -1;
}

/**
 * 判断两条线是否相交
 *
 * @param u
 * @param v
 * @return
 */

// 判断点在有向直线的左侧还是右侧.
// 返回值:-1: 点在线段左侧; 0: 点在线段上; 1: 点在线段右侧
- (int) PointAtLineLeftRight:(CGPoint)ptStart CPoint:(CGPoint) ptEnd CPoint:(CGPoint) ptTest
{
    ptStart.x -= ptTest.x;
    ptStart.y -= ptTest.y;
    ptEnd.x -= ptTest.x;
    ptEnd.y -= ptTest.y;
    
    int nRet = ptStart.x * ptEnd.y - ptStart.y * ptEnd.x;
    if (nRet == 0)
        return 0;
    else if (nRet > 0)
        return 1;
    else if (nRet < 0)
        return -1;
    
    return 0;
}

// 判断两条线段是否相交
- (BOOL) IsTwoLineIntersect:(CGPoint)ptLine1Start CPoint:(CGPoint) ptLine1End CPoint:(CGPoint) ptLine2Start CPoint :(CGPoint)ptLine2End
{
    
    BOOL b = (MAX(ptLine1Start.x, ptLine1End.x) < MIN(ptLine2Start.x, ptLine2End.x))
    || (MAX(ptLine2Start.x, ptLine2End.x) < MIN(ptLine1Start.x, ptLine1End.x))
    || (MAX(ptLine1Start.y, ptLine1End.y) < MIN(ptLine2Start.y, ptLine2End.y))
    || (MAX(ptLine2Start.y, ptLine2End.y) < MIN(ptLine1Start.y, ptLine1End.y));

    if (b)
    {
        return !b;
    }
    
    int nLine1Start = [self PointAtLineLeftRight:ptLine2Start CPoint:ptLine2End CPoint:ptLine1Start];
    int nLine1End = [self PointAtLineLeftRight:ptLine2Start CPoint:ptLine2End CPoint:ptLine1End];
    if (nLine1Start * nLine1End > 0)
        return FALSE;
    
    int nLine2Start = [self PointAtLineLeftRight:ptLine1Start CPoint:ptLine1End CPoint:ptLine2Start];
    int nLine2End = [self PointAtLineLeftRight:ptLine1Start CPoint:ptLine1End CPoint:ptLine2End];
    
    if (nLine2Start * nLine2End > 0)
        return FALSE;
    
    return TRUE;
}

- (float) multiply:(CGPoint)p1 Position:(CGPoint) p2 Position:(CGPoint)p0
{
    return ((p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y));
}

/**
 * 根据新的Pos Array，重建Path
 */
- (void) rebuildPath
{
    int posCount = mPosArray.count;
    
    if (posCount == 0) {
        NSLog(@"mPosArray is empty");
    }
   
    CGContextClearRect(context, self.frame);
    // 将Path的超始点放在第一个坐标点上
    for (int i = 0; i < posCount; i++)
    {
        CGPoint prevPos = [mPosArray[i] CGPointValue];
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, 3);
        CGContextMoveToPoint(context, prevPos.x, prevPos.y);
        
        if (i == posCount - 1)
        {
            // 最后一个点直接连到起始点上
            CGPoint nextPos = [mPosArray[0] CGPointValue];
            CGContextAddQuadCurveToPoint(context, prevPos.x, prevPos.y, nextPos.x, nextPos.y);
        } else
        {
            // 采用简单的平滑
            CGPoint nextPos = [mPosArray[i+1] CGPointValue];
            CGContextAddQuadCurveToPoint(context, prevPos.x, prevPos.y, nextPos.x,
                                         nextPos.y);
        }
        CGContextSetRGBStrokeColor(context,0,0,1,1);//要用RGB的
        CGContextStrokePath(context);
        [self setNeedsDisplay];
    }
}

/**
 * 两坐标点之间的距离
 */

- (float) distanceBetweenTwoPoints:(CGPoint)point1 Point:(CGPoint)point2
{
    float d = sqrt(pow(point2.x-point1.x,2)+pow(point2.y-point1.y,2));
//    printf("距离:%lf\n",d);
    
    return d;
}

@end
