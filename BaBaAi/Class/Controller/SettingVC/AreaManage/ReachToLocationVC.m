//
//  ReachToLocationVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "ReachToLocationVC.h"

@interface ReachToLocationVC ()
{
    double angle;
    
}
@end

@implementation ReachToLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];

    [self addObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self navigationBarShow];
    [self tabbarHidden];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}
-(void)loadCustomView{
    self.explainLab.numberOfLines = 0;
    CGSize size = [self.explainLab sizeThatFits:CGSizeMake(self.explainLab.frame.size.width, 1000.0)];
    self.explainLab.frame = CGRectMake(self.explainLab.frame.origin.x, self.explainLab.frame.origin.y, self.explainLab.frame.size.width, size.height);
    
    self.centerImageView.layer.cornerRadius = self.centerImageView.bounds.size.height/2;
    self.centerImageView.clipsToBounds = YES;
    self.centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    
  
    [self startAnimation];

}

-(void)startAnimation{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.02];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.bgImageView2.transform = CGAffineTransformMakeRotation(angle * (M_PI / 360.0f));
    [UIView commitAnimations];
}
-(void)endAnimation
{
    angle += 10;
    [self startAnimation];
}

- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)addObserver{

}
- (IBAction)outBtnAction:(UIButton *)sender {
    [self pauseLayer:self.bgImageView2.layer];
    self.bgImageView2.hidden = YES;
}

@end
