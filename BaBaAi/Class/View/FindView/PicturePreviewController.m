//
//  PicturePreviewController.m
//  kidsApp
//
//  Created by kingly on 15/7/23.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "PicturePreviewController.h"

#define kWidthdevHeight (3264.0f/2448.0f) //图片的宽高比，原图显示
#define kMaxZoom 3.0 //视图最大缩放

@interface PicturePreviewController ()<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;//滚动视图
    UIImageView *picView;//图片视图
    CGFloat currentScale;//当前的缩放比例
    BOOL isTwiceTaping;//双击
    BOOL isDoubleTapingForZoom;//两次点击
    CGFloat _offsetY;//y偏移
    CGFloat touchX;//手势位置x
    CGFloat touchY;//手势位置y
}
@end

@implementation PicturePreviewController
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.0;//全透明
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPictureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 加载自定义图片展示视图
 */
-(void)loadPictureView
{
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:myScrollView];
    myScrollView.delegate = self;
    myScrollView.maximumZoomScale = 5.0;
    CGFloat ratio = kScreenHeight /(kWidthdevHeight*kScreenWidth);
    CGFloat min = MIN(ratio, 1.0);
    myScrollView.minimumZoomScale = min;
    
    CGFloat height = kWidthdevHeight * kScreenWidth;
    picView = [[UIImageView alloc] initWithFrame:CGRectMake(myScrollView.contentOffset.x+(kScreenWidth - 10)/2, myScrollView.contentOffset.y+(kScreenHeight - 10)/2, 10, 10)];
    picView.image = self.selectImage;
    
    CGFloat y = (kScreenHeight - height)/2.0;
    _offsetY = 0.0-y;
    myScrollView.contentSize = CGSizeMake(kScreenWidth, height);
    [myScrollView addSubview:picView];
    myScrollView.contentOffset = CGPointMake(0, 0.0-y);
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         picView.frame = CGRectMake(0, 0, kScreenWidth, height);
                         self.view.alpha = 1.0f;//渐变为不透明
                     }
                     completion:^(BOOL finished){
                     }
     ];
    
    
    UITapGestureRecognizer *tapImgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backGesture)];
    tapImgView.numberOfTapsRequired = 1;
    tapImgView.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapImgView];
    
    UITapGestureRecognizer *tapImgViewTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewHandleTwice:)];
    tapImgViewTwice.numberOfTapsRequired = 2;
    tapImgViewTwice.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapImgViewTwice];
    [tapImgView requireGestureRecognizerToFail:tapImgViewTwice];
}

/**
 * 返回手势
 */
-(void)backGesture
{
    if(isTwiceTaping){
        return;
    }
    NSLog(@"tap once");
    
    [self backAnimation];//返回动画
}
/**
 * 视图消失的动画
 */
-(void)backAnimation
{
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         picView.frame = CGRectMake(myScrollView.contentOffset.x+(kScreenWidth - 10)/2, myScrollView.contentOffset.y+(kScreenHeight - 10)/2, 10, 10);
                         self.view.alpha = 0.0f;//渐变透明
                     }
                     completion:^(BOOL finished){
                         [self dismissViewControllerAnimated:NO completion:^{}];
                     }
     ];
}
/**
 * 图片放大缩小的方法
 */
-(void)tapImgViewHandleTwice:(UIGestureRecognizer *)sender{
    touchX = [sender locationInView:sender.view].x;
    touchY = [sender locationInView:sender.view].y;
    if(isTwiceTaping){
        return;
    }
    isTwiceTaping = YES;
    
    NSLog(@"tap twice");
    
    if(currentScale > 1.0){
        currentScale = 1.0;
        [myScrollView setZoomScale:1.0 animated:YES];
    }else{
        isDoubleTapingForZoom = YES;
        currentScale = kMaxZoom;
        [myScrollView setZoomScale:kMaxZoom animated:YES];
    }
    isDoubleTapingForZoom = NO;
    //延时做标记判断，使用户点击3次时的单击效果不生效。
    [self performSelector:@selector(twiceTaping) withObject:nil afterDelay:0.65];
}
/**
 * 标记单击3次的单击效果不生效
 */
-(void)twiceTaping{
    isTwiceTaping = NO;
}

#pragma mark - UIScrollViewDelegate zoom
/**
 * 视图停止缩放后
 */
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    currentScale = scale;
    NSLog(@"current scale:%f",scale);
}
/**
 * 视图缩放的图片
 */
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return picView;
}
/**
 * 视图缩放时
 */
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    if (scrollView.zoomScale < 0.6){
        [self dismissViewControllerAnimated:NO completion:^{}];
        return;
    }
    //当捏或移动时，需要对center重新定义以达到正确显示未知
    CGFloat xcenter = scrollView.center.x,ycenter = scrollView.center.y;
    NSLog(@"adjust position,x:%f,y:%f",xcenter,ycenter);
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width?scrollView.contentSize.width/2 :xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height/2 : ycenter;
    //双击放大时，图片不能越界，否则会出现空白。因此需要对边界值进行限制。
    if(isDoubleTapingForZoom){
        NSLog(@"taping center");
        xcenter = kMaxZoom*(kScreenWidth - touchX);
        ycenter = kMaxZoom*(kScreenHeight - touchY);
        if(xcenter > (kMaxZoom - 0.5)*kScreenWidth){//放大后左边超界
            xcenter = (kMaxZoom - 0.5)*kScreenWidth;
        }else if(xcenter <0.5*kScreenWidth){//放大后右边超界
            xcenter = 0.5*kScreenWidth;
        }
        if(ycenter > (kMaxZoom - 0.5)*kScreenHeight){//放大后左边超界
            ycenter = (kMaxZoom - 0.5)*kScreenHeight +_offsetY*kMaxZoom;
        }else if(ycenter <0.5*kScreenHeight){//放大后右边超界
            ycenter = 0.5*kScreenHeight +_offsetY*kMaxZoom;
        }
        NSLog(@"adjust postion sucess, x:%f,y:%f",xcenter,ycenter);
    }
    [picView setCenter:CGPointMake(xcenter, ycenter)];
}

@end
