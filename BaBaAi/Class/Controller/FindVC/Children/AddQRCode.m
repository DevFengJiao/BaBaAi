//
//  AddQRCode.m
//  BabaGoing
//
//  Created by 冯大师 on 15/12/15.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "AddQRCode.h"
//#import "ZBarSDK.h"

@interface AddQRCode ()
//<ZBarReaderDelegate>
{
    NSTimer *timer;
    BOOL upOrdown;
    int num;
}
@property (nonatomic, strong) UIImageView * line;
@end

@implementation AddQRCode

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"扫码添加";
//    [self rightNavBarItemWithTitle:MLString(@"扫码") AndSel:@selector(AddChildWay:)];
}

/*

-(void)AddChildWay:(UIBarButtonItem *)sender{
    //初始化ZBar
    
    ZBarReaderViewController * reader = [[ZBarReaderViewController alloc]init];
    reader.view.frame = CGRectMake(0, kNavgationBarHeight, kScreenWidth, kScreenHeight-50);
    //设置代理
    reader.readerDelegate = self;
    //支持界面旋转
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.showsHelpOnFail = NO;
    //隐藏底部控制按钮
    reader.showsZBarControls = NO;
    
    reader.scanCrop = CGRectMake(0.12, 0.1, 0.7, 0.8);//扫描的感应框
    ZBarImageScanner * scanner = reader.scanner;
        [scanner setSymbology:ZBAR_I25
                       config:ZBAR_CFG_ENABLE
                           to:0];
    
    
    // zbar优化  据说能大大提升性能
    [scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
    [scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:1];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60)];
    view.backgroundColor = [UIColor navbackgroundColor];
    reader.cameraOverlayView = view;
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth-40, 40)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"请将二维码放入框内,即可自动扫描";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    image.frame = CGRectMake(20, 80, kScreenWidth-40, kScreenWidth-40);
    [view addSubview:image];
    
    //用于取消操作的button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.alpha = 0.4;
    [cancelButton setFrame:CGRectMake(20, kScreenHeight-50, kScreenWidth-40, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
    [reader.view addSubview:cancelButton];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, kScreenWidth-100, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [image addSubview:_line];
    //定时器，设定时间过1.5秒，
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animationed) userInfo:nil repeats:YES];
    
    [self presentViewController:reader animated:YES completion:^{
        
    }];

}
//取消button方法
- (void)dismissOverlayView:(id)sender{
    
    if (timer) {
        [timer invalidate];
        timer= nil;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)animationed
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(30, 10+2*num, kScreenWidth-100, 2);
        if (2*num == 260) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(30, 10+2*num, kScreenWidth-100, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [timer invalidate];
    _line.frame = CGRectMake(20, 10, kScreenWidth-40, 2);
    num = 0;
    upOrdown = NO;
    
    [picker removeFromParentViewController];
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [timer invalidate];
    _line.frame = CGRectMake(20, 10, kScreenWidth-40, 2);
    num = 0;
    upOrdown = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //初始化
        ZBarReaderController * read = [ZBarReaderController new];
        //设置代理
        read.readerDelegate = self;
        CGImageRef cgImageRef = image.CGImage;
        ZBarSymbol * symbol = nil;
        id <NSFastEnumeration> results = [read scanImage:cgImageRef];
        for (symbol in results)
        {
            break;
        }
        
        NSString * result;
        if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
            
        {
            result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        else
        {
            result = symbol.data;
        }
        
//        scanningURL = result;
        
        NSLog(@"%@",result);
        
    }];
    
//    TalentTripViewController *talent = [[TalentTripViewController alloc]init];
//    talent.wxCodeUrl = scanningURL;
//    [self.navigationController pushViewController:talent animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self navigationBarShow];
    [self tabbarHidden];
//    //所得小孩对象
//    userList = [self getAllChilds];
//
//    [self.myTableView reloadData];//刷新表格
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 */


@end
