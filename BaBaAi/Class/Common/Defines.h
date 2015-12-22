//
//  Defines.h
//  LingYou
//
//  Created by Seven on 15/5/18.
//  Copyright (c) 2015年 sky. All rights reserved.
//
/**
 *  Defines.h
 *
 *  @定义 一些宏去处理问题.(多用一些与设备,方法,坐标有关的宏)
 *
 *  @描述 MK代码APP.前缀 (Mate GUKE)
 */
#import <mach/mach_time.h>




//----------------------------------------------------------------------------
//系统相关设置
//----------------------------------------------------------------------------
#define MLString(str) NSLocalizedString(str, @"")   //多国语言

#define IOSDEVICE [[[UIDevice currentDevice]systemVersion]floatValue] //系统版本

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height //屏幕高度

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO) // 是否高清屏

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) // 是否iPad

#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location) // 是否模拟器

#define kSupport1XImage (([UIScreen mainScreen].scale) == 1)?YES:NO //屏幕是否支持@1x图片的分辨率

#define kSupport2XImage (([UIScreen mainScreen].scale) == 2)?YES:NO //屏幕是否支持@2x图片的分辨率

#define kSupport3XImage (([UIScreen mainScreen].scale) == 3)?YES:NO //屏幕是否支持@3x图片的分辨率

#define kScreenScale ([UIScreen mainScreen].scale) //屏幕一个屏幕点等于多少像素点（CGFloat）



//文件保存路径
#define PortraitPath    [((NSURL*)[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]).path stringByAppendingString:@"/Portrait"]
#define signturePath [NSString stringWithFormat:@"%@/qianming.png",PortraitPath]


//----------------------------------------------------------------------------
//屏幕尺寸
//----------------------------------------------------------------------------
#define kScreenWidth ([[UIScreen mainScreen]bounds].size.width)//屏幕宽度

#define kScreenHeight ([[UIScreen mainScreen]bounds].size.height)//屏幕高度

#define kStatusBarHeight ([[UIApplication sharedApplication]statusBarFrame].size.height)//状态栏高度

#define kNavgationBarHeight (64.0f) //NavgationBar的高度

#define kTabBarHeight (49.0f) //下方tabBar的高度

#define kToolBarHeight (44.0f) //下方toolBar的高度

#define kJiangTopScrollHeight (100.0f)    //酱厂页面顶部scrollview的高度

#define kOtherHeightForHeader 22.0f  //酱厂页面分类的高度

#define kTableViewCellLineHeight (1.0f/([UIScreen mainScreen].scale)) //仿tableview的cell的细线高度


#define kIphone4S ((kScreenHeight <= 480)?YES:NO)  //iPhone4s 以下

#define kScreenPx(px) (roundf((px)*0.3444))  //用户将px的像素长度转换为屏幕点

//----------------------------------------------------------------------------
//有关时间
//----------------------------------------------------------------------------

#define TimeFormat          @"yyyy-MM-dd HH:mm:ss"

#define DuanDateFormat      @"MM-dd"

#define DateFormat          @"yyyy-MM-dd"

#define DateFormat_MM_dd_yyyy          @"MM/dd/yyyy"

#define DateFormatToShow    @"LLL dd, yyyy"

#define DateFormatToShow2   @"LLL dd yyyy"

#define DateFormatToShowLong    @"E, LLL dd yyyy"

#define DateFormatToShowLong2   @"EEEE, LLL dd yyyy"

#define DateFormateForOmniture  @"dd/MM/YYYY HH:mm:ss"

#define BODDateFormat          @"yyyy-MM-dd"

#define TwelveDateFormat       @"yyMMddHHmmss"

#define DateFormatHH_MM        @"HH:mm"

#define DateFormatHHMM        @"HHmm"

#define DateFormatyyyyMMdd     @"yyyyMMdd"


//----------------------------------------------------------------------------
//主页TabScrollView的设置
//----------------------------------------------------------------------------
#define kDefaultTabbarHeight (34.0f)//上方滚动的tabBar高度

#define kDefaultTabbarBottomSpacing (0.0f)

#define kDefaultCacheCount (4.0f)

#define kInputTextViewMaxHeight (72.0f) //全局的文本输入框的最大高度

#define kvarSpace  kScreenPx(44.0f) //水平的空隙

#define kHerSpace  kScreenPx(44.0f) //垂直的空隙

#define kHeaderInSection  (14.0f)  //cell HeaderInSection 的高度

#define kHeaderInSectionChild  (88.0f)  //孩子界面cell HeaderInSection 的高度

#define kSectionVerSpace  (7.0f)   //cell InSection 的高度

//----------------------------------------------------------------------------
//登录，注册，忘记密码
//----------------------------------------------------------------------------
#define PasswordMinLength 6

#define PasswordMaxLength 20

#define EmailMaxLength 50

//----------------------------------------------------------------------------
//钥匙串keychain存储kChain_Key_name_server
//----------------------------------------------------------------------------
#define k_UUID_nameServer @"k_UUID_nameServer" //keychain-用户UUID-(存取服务器用户名)

#define HeartRateFrequent 30  //心跳时间

//----------------------------------------------------------------------------
// application的信息
//----------------------------------------------------------------------------
//#define kAppBundleName @"酱知" //个人主页-设置-关于我们-app名称
//
//#define kAppWebSite @"http://www.jiangzhi.la" //个人主页-设置-关于我们-app名称
//
//#define kAppContactQQGroup @"413286596" //个人主页-设置-关于我们-app名称
//
//#define kAppContactWechat @"酱知（jiangzhi_app）" //个人主页-设置-关于我们-app名称
//
//#define kAppContactWeibo @"@酱知" //个人主页-设置-关于我们-app名称
//
//#define kWeiboPublicUrl @"http://weibo.com/u/5565838436" //微博公众号链接

#define kApplication_AppleId @"1004244118" //appleID


//----------------------------------------------------------------------------
//NSUserDefaults本地数据存储
//----------------------------------------------------------------------------
#define KUser_MemberID @"KUser_MemberID"//用户信息-用户id（NSInteger）
#define KUser_sToken   @"KUser_sToken"  //用户使用的sToken
#define KUser_sUsername   @"KUser_sUsername"  //用户账号
#define KUser_sPassword   @"KUser_sPassword"  //用户密码
#define KUser_simei   @"KUser_simei"          //当前小孩

#define UserDefault_Set_GuideDidView(isGuide)  [[NSUserDefaults standardUserDefaults]setObject:isGuide forKey:@"GuidKey"];[[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefault_Get_GuideDidView()          [[NSUserDefaults standardUserDefaults] objectForKey:@"GuidKey"]

#define UserDefault_Set_MemberID(MemberID)       [[NSUserDefaults standardUserDefaults] setObject:isLogin forKey:KUser_MemberID];[[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefault_Get_MemberID()          [[NSUserDefaults standardUserDefaults] objectForKey:KUser_MemberID]
#define UserDefault_Remove_MemberID()  [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUser_MemberID];

#define UserDefault_Set_KUser_sToken(sToken)       [[NSUserDefaults standardUserDefaults] setObject:isLogin forKey:KUser_sToken];[[NSUserDefaults standardUserDefaults] synchronize]
#define UserDefault_Get_KUser_sToken()          [[NSUserDefaults standardUserDefaults] objectForKey:KUser_sToken]
#define UserDefault_Remove_KUser_sToken()  [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUser_sToken]




//----------------------------------------------------------------------------
// 第三方登陆等key , bugly 质量分析的key以及第三方分享平台key
//----------------------------------------------------------------------------
#define kSinaWeiboKey @"2633336075" //登陆-新浪微博登陆的key

#define kSinaRedirectURI @"http://www.jiangzhi.la"  //新浪微博回调的url，微信分享回调的url,以及跳转链接

#define kQQloginKey @"1103418498" //登陆-QQ登陆的key

#define KUmengAppkey @"55c0505267e58eb28b0018be" //umeng key

#define KWechatKey  @"wx776e21460cda5a2b" //微信AppId

#define KWechatAppSecret @"02de1ec310c9e77d62ebd68f0db64472" //微信appSecret

#define KShareURL @"www.jiangzhi.la"         //回调URl （微信）

#define KQQAppId  @"1103991344" //@"1103991344"        //手机QQ 的AppId

#define KQQAPPKEY @"sjNKIPh99BUaRL4M" //@"sjNKIPh99BUaRL4M"  //手机QQ 的Appkey


//----------------------------------------------------------------------------
// 手表对象设置
//----------------------------------------------------------------------------
#define CHILDREN_LIMIT_NUM 8            //最多8个对象
#define HeightOfKeyboard 216
#define K_SHOWMENU_TAG  77777


#define DEFAULT_LAT 22.55523f
#define DEFAULT_LON 113.950471f

#define KReloadChildChangeInfoNotification   @"KReloadChildChangeInfoNotification" //重新加载数据






//修改系统log，使其在release状态下不输出
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

//判断空字符串
#define NULL_STR(str)   (str == nil || (NSNull *)str == [NSNull null] || str.length == 0)






#define SHOW_MESSAGE_VIEW(__title, __message, __cancelButtonTitle,__confirmButtonTitle)  { \
UIAlertView* alert = [[UIAlertView alloc] initWithTitle:__title message:__message delegate:nil cancelButtonTitle:__cancelButtonTitle otherButtonTitles:__confirmButtonTitle]; \
[alert show]; \
}

#define SCREEN_WIDTH     ([UIScreen mainScreen].bounds.size.width)//屏幕宽度
#define SCREEN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)//屏幕高


#define APPLICATION_NO_NAV       ([UIScreen mainScreen].bounds.size.height - 64)  //无导航和状态栏的高度

//是retina屏幕吗
#define MK_ISRETINA    ([UIScreen mainScreen].scale == 2)

//判断系统版本是否低于某个值(字符串类型)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

//获得当前版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

//定义控件在不同系统版本下偏移量。
#define VIEWOFFSET IOS7 ? 64:0

//比例
#define PROPORTION ([UIScreen mainScreen].bounds.size.width)/320.0f

//判断手机型号.注意模拟器下可能不准确.
#define iPhone3GS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1336), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) : NO)

//计算代码运行时间, 使用方法举例:
//LY_TIME_DURATION_BEGIN(@"code name")
//....//此处是任意代码
//LY_TIME_DURATION_END//即可打印出上面代码执行时间
#ifdef DEBUG
#define MK_TIME_DURATION_BEGIN(name)        {\
                                            NSString *tdName = [NSString stringWithFormat:@"%@",(name)];\
                                            NSDate *tdBeginDate = [NSDate date];
#define MK_TIME_DURATION_END                NSTimeInterval tdInterval = [[NSDate date]timeIntervalSinceDate:tdBeginDate];\
                                            NSLog(@"\"%@\"的运行时间:%f毫秒",tdName,tdInterval*1000.0f);\
}
#else
#define MK_TIME_DURATION_BEGIN(name)
#define MK_TIME_DURATION_END
#endif


