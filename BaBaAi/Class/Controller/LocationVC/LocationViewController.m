//
//  LocationViewController.m
//  BaBaAi
//
//  Created by 冯大师 on 15/12/7.
//  Copyright © 2015年 FengMaster. All rights reserved.
//

#import "LocationViewController.h"
#import "MapSetting.h"

@interface LocationViewController ()<MAMapViewDelegate>
{
    MAMapView *mapView;
    UIView *menuView;
    CLLocationCoordinate2D currCoordinate;
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCustomView];
    
    [self addObservers];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.isHeadView = YES;
    
    [self tabbarShow];
    
    [self navigationBarHidden];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];//注销观察者
}



#pragma mark - 自定义视图
/**
 * 自定义视图
 */
-(void)loadCustomView{
    
    [MAMapServices sharedServices].apiKey = MAPID;
    mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, kNavgationBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    mapView.delegate = self;
    //    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    //    _mapView.pausesLocationUpdatesAutomatically = NO; //指定定位是否会被系统自动暂停。默认为YES。只在iOS 6.0之后起作用。(后台运行)
    mapView.language = [[MapSetting share] setlanguage];
    //    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading; //跟随用户的位置和角度移动。
    
    //    [_mapView setZoomLevel:16.1 animated:YES];
    
    [self.view addSubview:mapView];
    
    
    //加载menu视图
    menuView = [[UIView alloc] init];
    menuView.backgroundColor = [UIColor clearColor];
    menuView.hidden = YES;
    [self.view addSubview:menuView];
    
    [self loadCurrCoordinate];
}

/**
 * 加载地址
 */
-(void)loadCurrCoordinate{
    
    if (self.currLatestData.fLatitude!=0 && self.currLatestData.fLongitude!=0) {
        currCoordinate = CLLocationCoordinate2DMake(self.currLatestData.fLatitude,self.currLatestData.fLongitude);
    }else{
        
        currCoordinate = CLLocationCoordinate2DMake(DEFAULT_LAT,DEFAULT_LON);
    }
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate =currCoordinate;
    mapView.centerCoordinate = currCoordinate;
    [self zoomToFitMapAnnotations];
    [mapView addAnnotation:pointAnnotation];
    
    
}


#pragma mark - MAMapViewDelegate
/**
 * 当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标
 */
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

//- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//    MAAnnotationView *view = views[0];
//
//    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
//    if ([view.annotation isKindOfClass:[MAUserLocation class]])
//    {
//        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
//        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
//        pre.image = [UIImage imageNamed:@"location.png"];
//        pre.lineWidth = 3;
//        pre.lineDashPattern = @[@6, @3];
//
//        [_mapView updateUserLocationRepresentation:pre];
//
//        view.calloutOffset = CGPointMake(0, 0);
//    }
//}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MAPinAnnotationView *newAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.annotation = annotation;
        newAnnotationView.image = [[SystemSupport share]imageOfFile:[NSString stringWithFormat:@"ic_mark"]];
        
        return newAnnotationView;
        
    }
    return nil;
}



#pragma mark - navViewClick
-(void)navViewClick:(UIButton *)sender{
    menuView = [self showMenuView:sender withView:menuView];
}

/**
 *  设置地图的 zoom
 */
-(void)zoomToFitMapAnnotations
{
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    MACoordinateRegion region;
    
    //设置地图默认显示的地区的经纬度
    region = MACoordinateRegionMake(currCoordinate,MACoordinateSpanMake(.025f,.025f));
    [mapView setRegion:region animated:YES];
    
    
    //加入这两行代码，解决地图越拉近，指定的坐标越偏右的问题。
    MAMapRect rect = MAMapRectForCoordinateRegion(region);
    [mapView setVisibleMapRect:rect animated:YES];
    
    
}

#pragma mark - Notification
/**
 * 接受小孩对象切换
 */
-(void)addObservers{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recvChildChangeNoti:) name:KReloadChildChangeInfoNotification object:nil];
    
}


/**
 * 收到小孩对象切换的通知
 * 进行界面刷新
 */
-(void)recvChildChangeNoti:(NSNotification *)note
{
    //重新加载顶部视图
    [self reloadNavData];
    
    //重新加载地图
    [self loadCurrCoordinate];
    
}



@end
