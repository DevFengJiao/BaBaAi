//
//  BaseViewController.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<ITcpClient>
{

    UIImageView *headImgV;
    UILabel     *messageLab;
}
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.observeNetStateForRightBarItem = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //在7.0系统才可执行
    if([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
//    [self setBackgroundAndNavbar];
    // 左返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    UIImage *image = [[UIImage imageNamed:@"nav_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 52, 0, -30)];
    [item setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = item;
    
    
    if (_isHideRightBarButtonItem)
    {
        //有了跳过按钮就把返回按钮隐藏
        self.navigationItem.rightBarButtonItem = nil;
    }
   
}

-(void)drawTopView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    headView.backgroundColor = [UIColor navbackgroundColor];
    [self.view addSubview:headView];
    
    headImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 22, 42, 42)];
    headImgV.backgroundColor = [UIColor clearColor];
    headImgV.image = [UIImage imageNamed:@"default_icon"];
    headImgV.userInteractionEnabled = YES;
    [headView addSubview:headImgV];
    
    UIView *labView = [[UIView alloc]initWithFrame:CGRectMake(0, 33, 42, 9)];
    labView.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:100.0/255.0 blue:107/255.0 alpha:0.6];
    [headImgV addSubview:labView];
    
    messageLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 42, 9)];
    messageLab.text = @"0%";
    messageLab.font = [UIFont systemFontOfSize:9];
    messageLab.textAlignment = NSTextAlignmentRight;
    messageLab.textColor = [UIColor whiteColor];
    messageLab.backgroundColor = [UIColor clearColor];
    [labView addSubview:messageLab];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ( [_pageTitle length] > 0 ) {
        UILabel* titleText = [[UILabel alloc]init];
        titleText.font = [UIFont boldSystemFontOfSize:NAVIGATIONBAR_TITLE_FONT];
        titleText.text = _pageTitle;
        titleText.backgroundColor = [UIColor clearColor];
        CGSize sizeIt = [_pageTitle sizeWithFont:titleText.font];
        titleText.frame = CGRectMake(0, 0, sizeIt.width, sizeIt.height);
        titleText.textColor = NAVIGATIONBAR_TITLE_COLOR;
        titleText.shadowColor = NAVIGATIONBAR_BACK_COLOR;
        titleText.shadowOffset = NAVIGATIONBAR_TEXT_OFFSET;
        [titleText setNumberOfLines:0];
        titleText.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = titleText;
    }
    self.view.backgroundColor = [UIColor backgroundColor];
    [self navigationBarShow];
    [self tabbarHidden];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
    //画顶部的view
    if (self.isHeadView == YES) {
        [self drawTopView];
    }

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

#pragma -mark AllNavBarSelection

-(void)navCustomViewHidden{
    [self tabbarHidden];
//    [self navigationBarHidden];
}

-(void)leftNavBarItemWithImage:(NSString *)image{
    
}
/**
 * 自定义navgationBar左边item
 * 纯文字类型
 */
-(void)leftNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector{

}

/**
 * 自定义navgationBar左边item
 * image item的普通状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)image AndSel:(SEL)selector{

}
/** 自定义navgationBar左边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)norImage SelectImage:(NSString *)selImage AndSel:(SEL)selector{

}

/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage AndSel:(SEL)selector{
    
}

/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage HlImage:(NSString *)hlImage AndSel:(SEL)selector{

}

/**
 * 自定义左边的NavigationBarItem
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = item;
}



/**
 * 自定义右边的NavigationBarItem
 * 文字类型的item (分为普通标题和选中的标题)
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSelTitle:(NSString *)selTitle AndSel:(SEL)selector{

}

/**
 * 检查Socket请求回调block中返回信息response是否为错误字符串
 */
-(BOOL)checkSocketRespClass:(id)response{
    return YES;
}
/**
 * 获得解析的指令
 */
-(NSString *)getCommod{
    return nil;
}
/**
 * 获得错误信息
 */
-(NSString *)getError{
    NSString *error = nil;
    return error;
}
/**
 * 获得错误信息
 */
-(NSDictionary *)getParaDic{
    return nil;
}
/**
 * 加载数据
 */
-(void)reloadNavData{

}



#pragma -mark

- (void)setBackgroundAndNavbar
{
    UIImage *image = [[UIImage imageNamed:@"nav_bg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self setDefaultLeftButtonItemWithAction:nil];
}

-(void)pushViewController:(UIViewController *)myViewController{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myViewController animated:YES];
}

//提示框
- (void)showMyMessage:(NSString*)aInfo {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:aInfo
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    
    
    [alertView show];
    
}

#pragma mark---展示TabBar

-(void)tabbarShow{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)tabbarHidden{
    self.tabBarController.tabBar.hidden = YES;
}


#pragma mark----

-(void)navigationBarShow{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)navigationBarHidden{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(UIView *)showMenuView:(UIButton *)sender withView:(UIView *)mView{
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    myView.backgroundColor = NAVIGATIONBAR_BACK_COLOR;
    [self.view addSubview:myView];
    return myView;
}


- (void)didReceiveMemoryWarning {
    if (self.isViewLoaded && ![self.view window]) {
        
    }
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
