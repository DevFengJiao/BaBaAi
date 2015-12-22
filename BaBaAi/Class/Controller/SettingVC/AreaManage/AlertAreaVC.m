//
//  AlertAreaVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "AlertAreaVC.h"
#import "MapSetting.h"
#import "TBChild.h"
#import "TBArea.h"
#import "DrawView.h"


#define kAdjustHeight 64

@interface AlertAreaVC ()<MAMapViewDelegate,DrawViewDelegate>{


    MAMapView *mapView;
    MAPolygon *polygon;
    ChildModel* childModel;
    AreaModel * aModel;
    BOOL isDrawing;
    NSMutableArray *drawPoints;
    NSMutableArray *drawCoordinations;
    NSMutableArray *areasPointsArray;
    NSMutableArray *areasArray;
    
    DrawView *drawView;
    
    CLLocationCoordinate2D currCoordinate;

}
@end

@implementation AlertAreaVC

-(void)loadView
{
    [super loadView];
  
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];
    
    UIBarButtonItem* drawItem = [[UIBarButtonItem alloc] initWithTitle:MLString(@"编辑") style:UIBarButtonItemStylePlain target:self action:@selector(createAlertArea:)];
    self.navigationItem.rightBarButtonItem = drawItem;
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
    
    self.title = MLString(@"电子栅栏");
    drawPoints = [NSMutableArray array];
    drawCoordinations = [NSMutableArray array];
    areasPointsArray = [NSMutableArray array];
    areasArray = [NSMutableArray array];
    isDrawing = NO;
    
    _bottomView.backgroundColor = [UIColor setAlertAreaBgColor];
    _sumbitButton.layer.cornerRadius = 5;
    _cancelButton.layer.cornerRadius = 5;
    _defaultLabel.text = MLString(@"电子栅栏已设定");
    _promptLabel.text = MLString(@"请在地图上划定一个区域");
    [_sumbitButton setTitle:MLString(@"确定") forState:UIControlStateNormal];
    [_cancelButton setTitle:MLString(@"重新设定") forState:UIControlStateNormal];
    
    [self showMap];
    //小孩的信息
    [self showPortraintView];
    //获得该小孩的区域信息
   [self getAreaPointsOfCurrentTracker];
    
}
#pragma mark - 初始化地图
/**
 * 初始化地图
 */
-(void)showMap{
    
     [MAMapServices sharedServices].apiKey = MAPID;
    mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-65)];
    mapView.delegate = self;
    mapView.language = [[MapSetting share] setlanguage];
    
    [self.view addSubview:mapView];
    [self.view addSubview:_bottomView];
    
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

#pragma mark - 设置小孩信息
/**
 * 小孩的信息
 */
-(void)showPortraintView{
    _portraintView.hidden = NO;
    _promptView.hidden = YES;
    _buttonsView.hidden = YES;
    //获得小孩信息
    childModel  = [[TBChild shareDB] getChildByImei:nil];
    //小孩头像
    self.portraint.image = [[FileManagerHelper share] getImageViewFromImage:childModel.llWearId];
    _nameLabel.text = childModel.sChildName;

}
/**
 * 获得该小孩的区域信息
 */
-(void)getAreaPointsOfCurrentTracker{
    
    [areasPointsArray removeAllObjects];
    [areasArray removeAllObjects];
    
    aModel = [[TBArea shareDB] getAreaByllWearId:childModel.llWearId];
    NSString* points = nil;
    points = aModel.sAreadata;
    //显示显示多变形点的集合数组
    areasPointsArray = [self getAreasPointsArray:points];
    if (areasPointsArray.count > 0){
        _defaultLabel.text = MLString(@"电子栅栏已设定");
    }else{
        [self zoomToFitMapAnnotations];
        _defaultLabel.text = MLString(@"电子栅栏未设定");
        return;
    }
    //显示集合点
    [self showAreasPoints:areasPointsArray];

}
/**
 * 字符串点转化成集合数组
 */
-(NSMutableArray *)getAreasPointsArray:(NSString *)points{
    
    NSMutableArray *pointsArr = [NSMutableArray array];
    if (points.length > 0)
    {
        //Eliminate all coordinateions which beyond valid range
        NSArray* oneAreaPoints = [NSString coordinationStringTocoordinations:points];
        NSMutableArray* modifiedAreaPoints = [NSMutableArray array];
        for (int di = 0; di < [oneAreaPoints count]; di ++)
        {
            NSArray* point = oneAreaPoints[di];
            if (([point[0] doubleValue] >= -90 && [point[0] doubleValue] <= 90) && ([point[1] doubleValue] >= -180 && [point[1] doubleValue] <= 180))
            {
                [modifiedAreaPoints addObject:point];
            }else
            {
                NSLog(@"Invalid coordination latitude=%f, longitude=%f",[point[0] doubleValue],[point[1] doubleValue]);
            }
        }
        [pointsArr addObject:modifiedAreaPoints];
    }

    return pointsArr;
}

/**
 * 在地图上显示 显示集合点
 */
-(void)showAreasPoints:(NSMutableArray *)areasPointsArr{
    
    
    for (int i = 0; i < areasPointsArr.count; i++)
    {
        [self drawAlertAreaInMap:areasPointsArr[i]];
    }
    [self zoomToFitMapAnnotations];
}
/**
 * 在地图上绘制点
 */
-(void)drawAlertAreaInMap:(NSMutableArray*)points{

    CLLocationCoordinate2D *coords = malloc(points.count * sizeof(CLLocationCoordinate2D));
    for (int di = 0; di < [points count]; di ++)
    {
        NSArray* point = points[di];
        coords[di].latitude = [point[0] doubleValue];
        coords[di].longitude = [point[1] doubleValue];
    }
    polygon = [MAPolygon polygonWithCoordinates:coords count:points.count];
    [mapView addOverlay:polygon];
    free(coords);

}

#pragma mark - submitAction
- (IBAction) submitAction:(id)sender{

    NSLog(@"%@",drawCoordinations);
     //请求服务器
    [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
    [self.navigationController popViewControllerAnimated:YES];
//    [self requestAlertAreaData];
}

#pragma mark - cancelAction
- (IBAction) cancelAction:(id)sender
{
    _portraintView.hidden = YES;
    _promptView.hidden = NO;
    _buttonsView.hidden = YES;
    
    [drawView clearContext];
}
#pragma mark - createAlertArea 右侧
- (void) createAlertArea:(UIBarButtonItem *)sender{

    if (isDrawing)
    {
        //删除多边形覆盖物
        if (polygon != nil)
        {
            [mapView removeOverlay:polygon];
            polygon=nil;
        }
        [self removeDrawView];
         sender.title = MLString(@"编辑");
        [self getAreaPointsOfCurrentTracker];
        
        _portraintView.hidden = NO;
        _promptView.hidden = YES;
        _buttonsView.hidden = YES;
        
        [mapView setScrollEnabled:YES];
        [mapView setZoomEnabled:YES];
        
        isDrawing = NO;
    }else
    {
       sender.title = MLString(@"取消");
        //删除多边形覆盖物
        if (polygon != nil)
        {
            [mapView removeOverlay:polygon];
            polygon=nil;
        }
        _portraintView.hidden = YES;
        _promptView.hidden = NO;
        _buttonsView.hidden = YES;
        
        [self createDrawView];
      
        [mapView setScrollEnabled:NO];
        [mapView setZoomEnabled:NO];
        
        isDrawing = YES;
    }
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
- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonView* polygonView = [[MAPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =2.0;
        return polygonView;
    }
    return nil;
}
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


#pragma mark - DrawViewDelegate
- (void)touchEndInDrawView:(BOOL)areaAvailable Points:(NSArray*)points
{
    if (areaAvailable)
    {
        [drawPoints removeAllObjects];
        [drawPoints addObjectsFromArray:points];
        [drawCoordinations removeAllObjects];
        for (int di = 0; di < [drawPoints count]; di ++)
        {
            CGPoint po = [[drawPoints objectAtIndex:di] CGPointValue];
            CLLocationCoordinate2D coo = [mapView convertPoint:po toCoordinateFromView:mapView];
            NSArray* point = [NSArray arrayWithObjects:[NSNumber numberWithDouble:coo.latitude],[NSNumber numberWithDouble:coo.longitude], nil];
            [drawCoordinations addObject:point];
        }
        
        _portraintView.hidden = YES;
        _promptView.hidden = YES;
        _buttonsView.hidden = NO;
    }else
    {
        _portraintView.hidden = YES;
        _promptView.hidden = NO;
        _buttonsView.hidden = YES;
        
        [drawView clearContext];
    }
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
    if (areasPointsArray.count == 0)
    {
//        CLLocationCoordinate2D coor;
//        coor = currCoordinate;
//        CLLocation* annotation = [[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude];
//        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
//        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
//        
//        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
//        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        
        //设置地图默认显示的地区的经纬度
       region = MACoordinateRegionMake(currCoordinate,MACoordinateSpanMake(.025f,.025f));
        [mapView setRegion:region animated:YES];

    }else
    {
        NSArray* points = areasPointsArray[0];
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


/**
 * 删除画布
 */
- (void) removeDrawView
{
    if (drawView)
    {
        if (drawView)
        {
            [drawView removeFromSuperview];
            drawView = nil;
        }
    }
}
/**
 * 创建画布
 */
- (void) createDrawView
{
    if (drawView)
    {
        return;
    }
    if (drawView == nil)
    {
        drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
        drawView.drawDelegate = self;
        [self.view addSubview:drawView];
        [drawView setFrame:mapView.frame];
    }
    
}
/**
 * 完成更新多边形
 */
- (void) finishUpdateAlertArea
{
    _portraintView.hidden = NO;
    _promptView.hidden = YES;
    _buttonsView.hidden = YES;
    
    _defaultLabel.text = MLString(@"电子栅栏已设定");
    self.navigationItem.rightBarButtonItem.title = MLString(@"设定");
    [self removeDrawView];
    
    [mapView setScrollEnabled:YES];
    [mapView setZoomEnabled:YES];
    
    isDrawing = NO;
    [self getAreaPointsOfCurrentTracker];
}

#pragma mark - 请求服务器
/**
 * 向服务器发送请求
 */
-(void)requestAlertAreaData{
    

    NSDictionary *para  = @{@"childrenID":[NSNumber numberWithLongLong:childModel.llWearId]};
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
    NSArray *fenceAreas = @[@{@"name":childModel.sChildName,
                              @"points":drawCoordinations}];
    [mutableDictionary setObject:fenceAreas forKey:@"fenceAreas"];
    TcpClient *tcp = [TcpClient sharedInstance];
    [tcp setDelegate_ITcpClient:self];
    if(tcp.asyncSocket.isDisconnected)
    {
        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
        return;
    }else if(tcp.asyncSocket.isConnected)
    {
        DataPacket *dataPacket    = [[DataPacket alloc] init];
        dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
        dataPacket.sCommand       = @"C_FENCE_AREA";
        dataPacket.paraDictionary = mutableDictionary;
        dataPacket.iType          = 0;
        [tcp sendContent:dataPacket];
        
    }else{
        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
        return;
    }

}
#pragma mark ITcpClient
/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt{
    
    NSLog(@"发送到服务器端的数据");
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSDictionary *)recivedTxt{
    if ([self checkSocketRespClass:recivedTxt]){
        
        if ([self getCommod]!=nil) {
            
            if ([[self getCommod] isEqualToString:@"R_C_FENCE_AREA"] == YES) {
                
                AreaModel *ct = [[AreaModel alloc]init];
                ct.llWearId   = childModel.llWearId;
                ct.simei      = childModel.simei;
                ct.sAreadata  = [NSString coordinationsToString:drawCoordinations];
                [[TBArea shareDB] insertArea:ct];
                [SVProgressHUD showSuccessWithStatus:MLString(@"设置电子围栏成功")];
            }
        }
    }else{
        [SVProgressHUD showErrorWithStatus:[self getError]];
    }
    
    [self finishUpdateAlertArea];

}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    
    NSLog(@"socket连接出现错误");
    
}



@end
