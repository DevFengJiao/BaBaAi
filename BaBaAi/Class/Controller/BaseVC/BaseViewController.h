//
//  BaseViewController.h
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTRequestCenter.h"
#import "ChildModel.h"
#import "LatestData.h"


@interface BaseViewController : UIViewController

@property(nonatomic,copy)NSString *pageTitle;
@property(nonatomic,assign)BOOL   isHideRightBarButtonItem;
//@property(nonatomic,assign)BOOL   isFrontViewControl;

-(void)pushViewController:(UIViewController *)myViewController;

/**
 *  弹窗,提示框
 */
- (void)showMyMessage:(NSString*)aInfo;

@property (nonatomic,assign) BOOL isHeadView;

/**
 * 当前小孩对象
 */
@property (nonatomic,strong) ChildModel *currChildModel;
/**
 * 最新终端信息
 */
@property (nonatomic,strong) LatestData *currLatestData;

/**
 * 是否是首页--首页隐藏返回箭头
 */
@property (nonatomic,assign) BOOL isHomePage;
/**
 * 用户登陆态
 */
@property (nonatomic,assign) BOOL isLogin;

/**
 * 键盘高度
 */
@property (nonatomic,assign) CGFloat keyBoardHeight;

/**
 * 当前是否有网络连接
 */
@property (nonatomic,assign) BOOL isNetworkConnect;

/**
 * 显示用户登陆页面
 */
-(void)showLoginViewInVc:(BaseViewController *)curVc;

/**
 * 显示主界面
 */
- (void)showTabBar:(BaseViewController *)curVc;

/**
 * 检查登录态
 */
-(BOOL)checkUserLogin;


/**
 * 显示alertCtr
 * remindText  提示内容
 */
-(void)showAlertText:(NSString *)remindText;
/**
 * 自定义navgationBar左边item（默认pop返回）
 * image item的图片
 */
-(void)leftNavBarItemWithImage:(NSString *)image;
/**
 * 自定义navgationBar左边item
 * 纯文字类型
 */
-(void)leftNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector;

/**
 * 自定义navgationBar左边item
 * image item的普通状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)image AndSel:(SEL)selector;
/**
 * 自定义navgationBar左边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)leftNavBarItemWithImage:(NSString *)norImage SelectImage:(NSString *)selImage AndSel:(SEL)selector;

/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage AndSel:(SEL)selector;

/**
 * 自定义navgationBar右边item
 * norImage item的普通状态图片
 * selImage item的选中状态图片
 * selector 动态方法
 */
-(void)rightNavBarItemWithImage:(NSString *)norImage HlImage:(NSString *)hlImage AndSel:(SEL)selector;

/**
 * 自定义左边的NavigationBarItem
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSel:(SEL)selector;

/**
 * 自定义右边的NavigationBarItem
 * 文字类型的item (分为普通标题和选中的标题)
 */
-(void)rightNavBarItemWithTitle:(NSString *)title AndSelTitle:(NSString *)selTitle AndSel:(SEL)selector;

/**
 * 显示navigationBar
 */
-(void)navigationBarShow;
/**
 * 隐藏navigationBar
 */
-(void)navigationBarHidden;

/**
 * 显示tabBar
 */
-(void)tabbarShow;

/**
 * 隐藏tabBar
 */
-(void)tabbarHidden;

/**
 * 显示自定义导航
 */
-(void)navCustomViewShow;

/**
 * 隐藏自定义导航
 */
-(void)navCustomViewHidden;

/**
 * 检查Socket请求回调block中返回信息response是否为错误字符串
 */
-(BOOL)checkSocketRespClass:(id)response;
/**
 * 获得解析的指令
 */
-(NSString *)getCommod;
/**
 * 获得错误信息
 */
-(NSString *)getError;
/**
 * 获得错误信息
 */
-(NSDictionary *)getParaDic;
/**
 * 加载数据
 */
-(void)reloadNavData;

/**
 * 显示 menuView
 */
-(UIView *)showMenuView:(UIButton *)sender withView:(UIView *)mView;

@end
