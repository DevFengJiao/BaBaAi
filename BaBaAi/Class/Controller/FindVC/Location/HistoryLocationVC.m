//
//  HistoryLocationVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "HistoryLocationVC.h"
#import "MapSetting.h"


@interface HistoryLocationVC ()<MAMapViewDelegate>{
    
    MAMapView *mapView;
    CLLocationCoordinate2D currCoordinate;
   NSMutableArray *pointsArray;
}


@end

@implementation HistoryLocationVC

-(void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - loadCustomView
-(void)loadCustomView{
    
    self.title = MLString(@"历史位置");
    [self showMap];
  
}

#pragma mark - 初始化地图
/**
 * 初始化地图
 */
-(void)showMap{
    
    
    [MAMapServices sharedServices].apiKey = MAPID;
    mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    mapView.delegate = self;
    mapView.language = [[MapSetting share] setlanguage];
    
    [self.view addSubview:mapView];
    
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
    
    //  PositionInfo* positionInfo = [[DataAccessor sharedDBAccessor] getPositionInfoByImei:childModel.imei];
    MACoordinateRegion region;
    if (pointsArray.count == 0)
    {
        //设置地图默认显示的地区的经纬度
        region = MACoordinateRegionMake(currCoordinate,MACoordinateSpanMake(.025f,.025f));
        [mapView setRegion:region animated:YES];
        
    }else
    {
        NSArray* points = pointsArray[0];
        for (int i = 0; i < points.count; i++)
        {
            NSArray* point = points[i];
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, [point[0] doubleValue]);
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, [point[1] doubleValue]);
            
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, [point[0] doubleValue]);
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, [point[1] doubleValue]);
        }
        
        
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.15; // Add a little extra space on the sides
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.15; // Add a little extra space on the sides
        
        region = [mapView regionThatFits:region];
        
        if (region.span.latitudeDelta > 180)
            region.span.latitudeDelta = 180;
        else if (region.span.latitudeDelta < 0)
            region.span.latitudeDelta = 0;
        if (region.span.longitudeDelta > 360)
            region.span.longitudeDelta = 360;
        else if (region.span.longitudeDelta < 0)
            region.span.longitudeDelta = 0;
        
        [mapView setRegion:region animated:YES];
    }
    
    //加入这两行代码，解决地图越拉近，指定的坐标越偏右的问题。
    MAMapRect rect = MAMapRectForCoordinateRegion(region);
    [mapView setVisibleMapRect:rect animated:YES];
    
    
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

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MAPinAnnotationView *newAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.annotation = annotation;
        newAnnotationView.image = [UIImage imageNamed:@"ic_mark"];
//        [[SystemSupport share]imageOfFile:[NSString stringWithFormat:@"ic_mark"]];
        
        return newAnnotationView;
        
    }
    return nil;
}




@end
