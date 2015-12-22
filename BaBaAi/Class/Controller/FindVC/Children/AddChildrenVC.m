//
//  AddChildrenVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/12.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "AddChildrenVC.h"
#import "AddChildrenCell.h"
#import "BirthdayPickerView.h"
#import "GenderPickerView.h"
#import "ChildrenListVC.h"

#import "PicturePreviewController.h"
#include <AssetsLibrary/AssetsLibrary.h>
#import "TBChild.h"


@interface AddChildrenVC ()<UIGestureRecognizerDelegate,AddChildrenCellDelegate,GenderPickerViewDelegate,BirthdayPickerViewDelegate,UINavigationBarDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,ITcpClient>{
    
    UIView *headerView;         //表头
    UIImageView *childLogo;     //小孩头像
    
    UIImage *selectPicture;//相机相册中选择的图片
    NSData *uploadImageData;//上传的图片数据
    
     NSMutableArray* groupArray;
     UITapGestureRecognizer *tapGes;//单击手势
    
    NSArray* pickerDataSource; //性别数组
    int genderIndex; //性别 0是男孩 1是女孩
   
    NSString* birthOfDate; //生日
    
    NSArray *relationshipArr; //亲属关系
    int shipIndex;            //亲属关系值
    
    UITextField *identifCodeTextFild;  //验证码
    UIView *footerView;         //表尾
    UIButton *sendCodeBtn;      //发送验证码按钮
    
    NSString *imeiString;       //imei 号
    NSString *sChildName;        //姓名
    NSString *sHeight;           //身高
    NSString *sWeight;           //体重
    NSString *sWatchphone;       //手表电话
    NSString *sPhone;            //本机电话号码
    
    ChildModel *childModel;     //新建小孩对象
    
    
}

@end

@implementation AddChildrenVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadCustomView];
    
     [self addHiddenKeyBoardGesture];//添加手势
}
/**
 * 添加隐藏键盘的手势
 */
-(void)addHiddenKeyBoardGesture
{
    tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];
    tapGes.delegate = self;
    [self.myTableView addGestureRecognizer:tapGes];
}

#pragma mark - UIGestureRecognizerDelegate
/**
 * 解决手势冲突问题
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    if (curType == kAreaTable || curType == kSchoolTable) {
//        // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//        if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
//            return NO;
//        }
//    }
    return  YES;
}


#pragma mark - hiddenKeyBoard
-(void)hiddenKeyBoard
{
    
    if (groupArray.count>0) {
        
        for (int i =0; i<groupArray.count; i++) {
            NSArray *arr = [groupArray objectAtIndex:i];
            for (int j=0; j<arr.count; j++) {
                AddChildrenCell *cell = (AddChildrenCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                
                [cell.nameTextField resignFirstResponder];

            }
        }
    }
    [identifCodeTextFild resignFirstResponder];
    [self viewDownward];//view下移
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:identifCodeTextFild]) {
        [self viewUpwardWithMargin:300];
    }else if(textField.tag >= 200){
          NSInteger h = 44*(textField.tag-200)+176;
        NSLog(@"hhhh:%ld",(long)h);
         [self viewUpwardWithMargin:h];
    }else{
    
        NSInteger h = 44*(textField.tag-100);
        NSLog(@"%ld",(long)h);
        [self viewUpwardWithMargin:h];
    }
}
-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    [self viewDownward];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self hiddenKeyBoard];
    return YES;
}

/**
 * 限制输入的字数
 */
-(IBAction)limitLength:(UITextField *)sender
{
    if(sender == identifCodeTextFild) {
        
        if (identifCodeTextFild.text.length > 4) {
            
            NSString *strNew = [NSString stringWithString:identifCodeTextFild.text];
            [identifCodeTextFild setText:[strNew substringToIndex:4]];
        }
    }
}

#pragma mark - 视图移动
/**
 * view上移
 */
-(void)viewUpwardWithMargin:(NSInteger )margin
{
    NSInteger keyBoardUpHeight = margin;
    
    if (self.myTableView.contentOffset.y != keyBoardUpHeight) {
        [UIView animateWithDuration:0.35f animations:^{
            self.myTableView.contentOffset = CGPointMake(self.myTableView.contentOffset.x, keyBoardUpHeight);
        }];
    }
}

/**
 * view下移
 */
-(void)viewDownward
{
    if (self.myTableView.contentOffset.y != 0) {
        [UIView animateWithDuration:0.35f animations:^{
            self.myTableView.contentOffset = CGPointMake(0, 0);
        }];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 自定义视图
 */
-(void)loadCustomView{
    
    self.title = MLString(@"添加小孩对象");
    
//    CGRect tableFrame = self.myTableView.frame;
//    tableFrame.origin.y = kNavgationBarHeight;
//    tableFrame.size.height = kScreenHeight;
//    self.myTableView.frame = tableFrame;
    
    [self rightNavBarItemWithTitle:MLString(@"保存") AndSel:@selector(submitAddChild:)];
    
    //表头
    headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderInSectionChild);
    childLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    childLogo.bounds = CGRectMake(0, 0, 70, 70);
    childLogo.layer.cornerRadius = childLogo.bounds.size.height/2;
    childLogo.clipsToBounds = YES;
    childLogo.contentMode = UIViewContentModeScaleAspectFill;
    childLogo.center = CGPointMake(kScreenWidth/2,kHeaderInSectionChild/2);
#warning 缺少图片
    childLogo.image = [UIImage imageNamed:@"default_icon"];
    UITapGestureRecognizer *tapPortrait = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addChildLogo:)];
    childLogo.userInteractionEnabled = YES;
    [childLogo addGestureRecognizer:tapPortrait];
    [headerView addSubview:childLogo];
    self.myTableView.tableHeaderView = headerView;

        //读取plist文件路径
    NSString *filePath = [[SystemSupport mainBundle] pathForResource:@"UserInfo" ofType:@"plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        groupArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    
    //性别
    pickerDataSource = [NSArray arrayWithObjects:MLString(@"男孩"),MLString(@"女孩"), nil];
    birthOfDate      = @"2015-01-01";
    relationshipArr  = [NSArray arrayWithObjects:MLString(@"爸爸"),MLString(@"妈妈"),MLString(@"爷爷"),MLString(@"奶奶"),MLString(@"叔叔"),MLString(@"阿姨"),MLString(@"伯父"),MLString(@"伯母"),MLString(@"其他"), nil];
    shipIndex = 1;
    
    //表尾
    footerView = [[UIView alloc] init];
    [footerView setBackgroundColor:[UIColor clearColor]];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderInSectionChild);
    
    UIView *identifCode = [[UIView alloc] initWithFrame:CGRectMake(12, 10, kScreenWidth/2-12, 30)];
    identifCode.backgroundColor = [UIColor whiteColor];
    
    identifCodeTextFild = [[UITextField alloc] initWithFrame:CGRectMake(2, 2,identifCode.frame.size.width-4, 26)];
    identifCodeTextFild.placeholder = MLString(@"验证码");
    identifCodeTextFild.delegate = self;
    identifCodeTextFild.backgroundColor = [UIColor clearColor];
    [identifCodeTextFild setClearButtonMode:UITextFieldViewModeAlways];
    [identifCodeTextFild setLeftViewMode:UITextFieldViewModeAlways];
    [identifCodeTextFild setKeyboardType:UIKeyboardTypeNumberPad];
    [identifCodeTextFild addTarget:self action:@selector(limitLength:) forControlEvents:UIControlEventEditingChanged];

    [identifCode addSubview:identifCodeTextFild];
    
    [footerView addSubview:identifCode];
    //发送验证码按钮
    sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendCodeBtn.frame = CGRectMake(identifCode.frame.origin.x + identifCode.frame.size.width + 10 , identifCode.frame.origin.y, kScreenWidth/2-12-10, identifCode.frame.size.height);
    [sendCodeBtn setTitle:MLString(@"获取验证码") forState:UIControlStateNormal];
    [sendCodeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [sendCodeBtn setBackgroundColor:[UIColor whiteColor]];
    [sendCodeBtn.layer setMasksToBounds:YES];
    [sendCodeBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [sendCodeBtn.layer setBorderWidth:1.0/kScreenScale]; //边框宽度
    [sendCodeBtn addTarget:self action:@selector(sendCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sendCodeBtn];
    
    self.myTableView.tableFooterView = footerView;
    
    childModel = [[ChildModel alloc] init];
}

#pragma mark - 提交保存小孩信息
/**
 * navigationBar右边按钮点击
 * 提交保存小孩信息
 */
-(void)submitAddChild:(UIBarButtonItem *)sender
{
    if ([self checkAddChild]) {
        
        NSDictionary *para  = @{@"validationCode":identifCodeTextFild.text
                                };
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
        
        childModel.simei = imeiString;
        childModel.sChildName   = sChildName;
        childModel.iGender      = genderIndex;
        if (birthOfDate.length==0) {
            birthOfDate = @"2015-01-01";
        }
        if (shipIndex==0) { //默认为爸爸
            shipIndex = 1;
        }
        childModel.sbirthdate   = birthOfDate;
        childModel.iHeight      = [sHeight intValue];
        childModel.fWeight      = [sWeight floatValue];
        childModel.iRelationship = shipIndex;
        childModel.iRelationshipPic = shipIndex;
        childModel.iMarkPicID   = 0;
        childModel.sPhone       = sPhone;
        childModel.sWatchphone  = sWatchphone;
        
        
        NSDictionary *wearer  = @{
                                  @"imei":imeiString,
                                  @"childrenName":sChildName,
                                  @"height":[NSNumber numberWithInt:[sHeight intValue]],
                                  @"weight":[NSNumber numberWithFloat:[sWeight floatValue]],
                                  @"gender":[NSNumber numberWithInt:genderIndex],
                                  @"birthDay":birthOfDate,
                                  @"relationShip":[NSNumber numberWithInt:shipIndex],
                                  @"relationShipPic":[NSNumber numberWithInt:shipIndex],
                                  @"markPicID":[NSNumber numberWithInt:0],
                                  @"mobile":sPhone,
                                  @"dialbackMobile":sWatchphone
                                  
                                };
   
        [mutableDictionary setObject:wearer forKey:@"children"];
        TcpClient *tcp = [TcpClient sharedInstance];
        [tcp setDelegate_ITcpClient:self];
        if(tcp.asyncSocket.isDisconnected)
        {
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
            return;
        }else if(tcp.asyncSocket.isConnected)
        {
            identifCodeTextFild.text  = @"";
            
            DataPacket *dataPacket    = [[DataPacket alloc] init];
            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
            dataPacket.sCommand       = @"C_CHILDREN2";
            dataPacket.paraDictionary = mutableDictionary;
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
            
        }else{
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
            return;
        }

        
    }
    
}
/**
 * 检查表单
 */
-(BOOL)checkAddChild{
    NSString *error;
    NSString *error2;
    for (int i =0; i<groupArray.count; i++) {
        NSArray *arr = [groupArray objectAtIndex:i];
        for (int j=0; j<arr.count; j++) {
        
            AddChildrenCell *cell = (AddChildrenCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            [cell.nameTextField resignFirstResponder];
            NSMutableArray *arr = [groupArray objectAtIndex:i];
            NSMutableDictionary *dis = [arr objectAtIndex:j];
            NSString *sValue = cell.nameTextField.text;
            if ([[dis objectForKey:@"viewName"] isEqualToString:@"childname"] == YES){
                if (!NULL_STR(sValue)) {
                    error = MLString(@"请输入宝贝的名字！");
   
                    break;
                }else if (sValue.length <= 2 || sValue.length>=20 ) {
                    error = MLString(@"名字只能在2~20个字符之间而且不能有空格 =w=");
                    break;
                }
                NSString *rangeString = @" ";
                if ([sValue rangeOfString:rangeString].location != NSNotFound) {
                    error = MLString(@"名字只能在2~20个字符之间而且不能有空格 =w=");
                    break;
                }else{
                
                    sChildName = sValue;
                }
            
            }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"height"] == YES){
                if (!NULL_STR(sValue)) {
                    error = MLString(@"请输入宝贝的身高！");
                    break;
                }else{
                    sHeight = sValue;
                }
                
            }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"weight"] == YES){
                if (!NULL_STR(sValue)) {
                    error = MLString(@"请输入宝贝的体重！");
                    break;
                }else{
                    sWeight = sValue;
                }
                
            }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"watchphone"] == YES){
                if (!NULL_STR(sValue)) {
                    
                    error2= MLString(@"请输入宝贝的手表电话号码！");
                    break;
                }else  if (sValue.length!=11) {
                    error2= MLString(@"请输入正确的电话号码格式！");
                    break;
                }else {
                    sWatchphone = sValue;
                }
                
            }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"phone"] == YES){
                if (!NULL_STR(sValue)) {
                    
                    error2= MLString(@"请输入本机电话号码！");
                    break;
                }else  if (sValue.length !=11) {
                    error2= MLString(@"请输入正确的电话号码格式！");
                    break;
                }else {
                    sPhone = sValue;
                }
                
            }else if ([[dis objectForKey:@"viewName"] isEqualToString:@"imei"] == YES){
                
                if (!NULL_STR(sValue)) {
                     error = MLString(@"请输入手表的IMEI号！");
                    break;
                }else{
                    imeiString = sValue;
                }
            }
            
        }
    }
    
    if (error.length!=0) {
        [SVProgressHUD showErrorWithStatus:error];
        return NO;
    }
    
    if (error2.length!=0) {
        [SVProgressHUD showErrorWithStatus:error2];
        return NO;
    }

    if (!NULL_STR(identifCodeTextFild.text)) {
        [SVProgressHUD showErrorWithStatus:MLString(@"请输入验证码！")];
        return NO;
    }
    
    
    return YES;
}
/**
 * 检查小孩的某一个信息
 */
-(BOOL)checkAddchildImei{

    NSString *error;
    
    for (int i =0; i<groupArray.count; i++) {
        NSArray *arr = [groupArray objectAtIndex:i];
        for (int j=0; j<arr.count; j++) {
            AddChildrenCell *cell = (AddChildrenCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            [cell.nameTextField resignFirstResponder];
            NSMutableArray *arr = [groupArray objectAtIndex:i];
            NSMutableDictionary *dis = [arr objectAtIndex:j];
            NSString *sValue = cell.nameTextField.text;
            if ([[dis objectForKey:@"viewName"] isEqualToString:@"imei"] == YES){
                
                if (!NULL_STR(sValue)) {
                    error = MLString(@"请输入手表的IMEI号！");
                    break;
                }else{
                    imeiString = sValue;
                }
               
            }
        }
    }
    
    if (error.length!=0 || imeiString.length==0) {
        [SVProgressHUD showErrorWithStatus:error];
        return NO;
    }
    return YES;
    
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return kSectionVerSpace;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([groupArray count] == section+1) {
        return 0;
    }
    return kSectionVerSpace;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [groupArray count];//返回标题数组中元素的个数来确定分区的个数
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [groupArray objectAtIndex:section];
    return  [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier=@"AddChildrenCell";
    AddChildrenCell *cell=(AddChildrenCell *)[self.myTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nibs=[[SystemSupport mainBundle] loadNibNamed:@"AddChildrenCell" owner:self options:nil];
        for(id oneObject in nibs)
        {
            if([oneObject isKindOfClass:[AddChildrenCell class]])
            {
                cell=(AddChildrenCell *)oneObject;
            }
        }
    }else{
        //解決重影問題
        NSArray *cellSubs = cell.contentView.subviews;
        for (int i=0; i< [cellSubs count]; i++) {
            [[cellSubs objectAtIndex:i] removeFromSuperview];
        }
    }
    
    cell.indexPath = indexPath;
    cell.groupArr  = groupArray;
    cell.mydelegate = self;
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *arr = [groupArray objectAtIndex:indexPath.section];
    NSMutableDictionary *dis = [arr objectAtIndex:indexPath.row];
    if ([[dis objectForKey:@"name"] isEqualToString:@"性别"] == YES) {
        NSLog(@"sdsds");
    }
}
#pragma mark - AddChildrenCellDelegate
/**
 * 添加小孩 － 性别
 */
-(void)showUserSix:(NSIndexPath *)indexPath{
    [self hiddenKeyBoard];
    GenderPickerView* genderView = [[GenderPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    genderView.genderData = pickerDataSource;
    genderView.indexPath  = indexPath;
    genderView.genderPickerViewDelegate = self;
    [self.view addSubview:genderView];
}
/**
 * 显示生日
 */
-(void)showBirthPicker:(NSIndexPath *)indexPath{
    [self hiddenKeyBoard];
    BirthdayPickerView* bodView = [[BirthdayPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bodView.indexPath = indexPath;
    bodView.birthdayPickerViewDelegate = self;
    
    [self.view addSubview:bodView];

    
}
/**
 * 显示亲属关系
 */
-(void)showRelationship:(NSIndexPath *)indexPath{
    [self hiddenKeyBoard];
    UIAlertController *alerCtr = [UIAlertController alertControllerWithTitle:MLString(@"亲属关系") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    int i = 0;
    for (NSString *ship in relationshipArr) {
        
        UIAlertAction *shipAction = [UIAlertAction actionWithTitle:ship style:UIAlertActionStyleDefault handler:^(UIAlertAction *shipAction){
            shipIndex = i+1;
            AddChildrenCell *cell = (AddChildrenCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
            cell.nameTextField.text = relationshipArr[i];
        }];
         [alerCtr addAction:shipAction];
        
      i++;
    }
    [self presentViewController:alerCtr animated:YES completion:^{}];
}
#pragma mark - GenderPickerView Delegate
- (void) finishSelectGender:(int)selectedIndex withIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenKeyBoard];
    genderIndex = selectedIndex;
    
     AddChildrenCell *cell = (AddChildrenCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    cell.nameTextField.text = pickerDataSource[genderIndex];
  
}

#pragma mark -BirthdayPickerView Delegate
- (void) finishSelectBOD:(NSString*)bodString withIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"bodString:%@",bodString);
    [self hiddenKeyBoard];
    birthOfDate = bodString;
    AddChildrenCell *cell = (AddChildrenCell *)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    cell.nameTextField.text = bodString;

}
#pragma mark - 点击添加小孩头像
/**
 * 打开相册或相机 添加头像
 */
-(void)addChildLogo:(UITapGestureRecognizer *)sender
{
 
    [self hiddenKeyBoard];
    
    if (uploadImageData == nil) {
        /**
         * 当前选择图片为空时
         */

            UIAlertAction *camera = [UIAlertAction actionWithTitle:MLString(@"拍张照片") style:UIAlertActionStyleDefault handler:^(UIAlertAction *cameraAct){
                [self openCamera];
            }];
            UIAlertAction *album = [UIAlertAction actionWithTitle:MLString(@"上传照片") style:UIAlertActionStyleDefault handler:^(UIAlertAction *albumAct){
                [self openAlbum];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:MLString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction *cancelAct){
            }];
            UIAlertController *alerCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alerCtr addAction:camera];
            [alerCtr addAction:album];
            [alerCtr addAction:cancel];
            [self presentViewController:alerCtr animated:YES completion:^{}];
    
    }else{
        /**
         * 当前选择图片不为空时
         */
      
            UIAlertAction *camera = [UIAlertAction actionWithTitle:MLString(@"重拍一张照片") style:UIAlertActionStyleDefault handler:^(UIAlertAction *cameraAct){
                [self openCamera];
            }];
            UIAlertAction *album = [UIAlertAction actionWithTitle:MLString(@"重新上传照片") style:UIAlertActionStyleDefault handler:^(UIAlertAction *albumAct){
                [self openAlbum];
            }];
            UIAlertAction *preShow = [UIAlertAction actionWithTitle:MLString(@"预览") style:UIAlertActionStyleDefault handler:^(UIAlertAction *cameraAct){
                [self preShowPicture];
            }];
            UIAlertAction *deletePic = [UIAlertAction actionWithTitle:MLString(@"删除照片") style:UIAlertActionStyleDefault handler:^(UIAlertAction *albumAct){
                [self deletePicture];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:MLString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction *cancelAct){
            }];
            UIAlertController *alerCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alerCtr addAction:camera];
            [alerCtr addAction:album];
            [alerCtr addAction:preShow];
            [alerCtr addAction:deletePic];
            [alerCtr addAction:cancel];
            [self presentViewController:alerCtr animated:YES completion:^{}];
        
    }

    
}

/**
 * 打开相机
 */
-(void)openCamera
{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = NO;//设置不可编辑（无编辑框模式）
    picker.navigationBar.barStyle = UIBarStyleDefault;
    picker.navigationBar.barTintColor = [UIColor navbackgroundColor];
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:^{}];//进入照相界面
}

/**
 * 打开相册
 */
-(void)openAlbum
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    pickerImage.navigationBar.barTintColor = [UIColor navbackgroundColor];
    pickerImage.navigationBar.barStyle = UIBarStyleDefault;
    [self presentViewController:pickerImage animated:YES completion:^{}];
}
#pragma mark - 设置相机相册的状态栏
/**
 * 让 UIImagePickerController 显示后 的状态栏始终保持某一种风格.
 */
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)writeToFile:(NSData* )imgData{
    
    [imgData writeToFile:signturePath atomically:YES];
}
/**
 * 获取图片上传头像
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self setNeedsStatusBarAppearanceUpdate];//重设statusBar
    }];
    selectPicture = [info objectForKey:UIImagePickerControllerOriginalImage];
    childModel.selectPicture = selectPicture;
    NSLog(@"selectPicture size is %@",NSStringFromCGSize(selectPicture.size));
    
    [childLogo setImage:selectPicture];
    //处理png、jpeg格式的图片
    uploadImageData = UIImageJPEGRepresentation(selectPicture,0.1f);//原图压缩
    childModel.childLogoData = uploadImageData;
    
    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock:^(ALAsset *asset)
//     {
//         //处理gif格式的图片
//         ALAssetRepresentation *rep = [asset defaultRepresentation];
//         Byte *imageBuffer = (Byte*)malloc((unsigned long)rep.size);
//         NSUInteger bufferSize = [rep getBytes:imageBuffer fromOffset:0.0 length:(NSUInteger)rep.size error:nil];
//         uploadImageData = [NSData dataWithBytesNoCopy:imageBuffer length:bufferSize freeWhenDone:YES];
    
         
//         if (![[NSData sd_contentTypeForImageData:uploadImageData] isEqualToString:@"image/gif"]){
//             //处理png、jpeg格式的图片
//             uploadImageData = UIImageJPEGRepresentation(selectPicture,0.2f);//原图压缩(0...1.0)
//             NSLog(@"图片格式为jpg格式");
//         }else{
//             NSLog(@"图片格式为gif格式");
//         }
//     }failureBlock:^(NSError *error){
//         NSLog(@"couldn't get asset: %@", error);
//     }];
    
//    [self checkSendFeedCondition];//检查发送feed的条件
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
/**
 * 预览选中的图片
 */
-(void)preShowPicture
{
    PicturePreviewController *picPreView = [[PicturePreviewController alloc]init];
    picPreView.selectImage = selectPicture;
    [self.navigationController presentViewController:picPreView animated:NO completion:^{}];
}
/**
 * 删除选中的图片
 */
-(void)deletePicture
{
    uploadImageData = nil;
    childLogo.image = [UIImage imageNamed:@"default_icon"];
    
}

#pragma mark -  发送获取验证码
-(void)sendCodeBtnAction:(id)sender{
    if ([self checkAddchildImei]) {
        
        NSDictionary *para  = @{@"imei":imeiString};
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
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
            dataPacket.sCommand       = @"G_TVC";
            dataPacket.paraDictionary = mutableDictionary;
            dataPacket.iType          = 0;
            [tcp sendContent:dataPacket];
            
        }else{
            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
            return;
        }
        

    }
}

#pragma mark ITcpClient
/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt{
    
    NSLog(@"发送到服务器端的数据");
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSDictionary *)recivedTxt{
    
    NSLog(@"收到服务器端发送的数据,%@",recivedTxt);
    

    if ([self checkSocketRespClass:recivedTxt]){
        
        if ([self getCommod]!=nil) {
            
            if ([[self getCommod] isEqualToString:@"R_G_TVC"] == YES) {
                //获取验证码
               
                [SVProgressHUD showSuccessWithStatus:MLString(@"发送验证码成功")];
                
            }else if ([[self getCommod] isEqualToString:@"R_C_CHILDREN2"] == YES) {
                NSDictionary *bodyInfo = [self getParaDic];
               
                
                NSDictionary *wearer   = [NSString isNullObjwithNSDictionary:[bodyInfo objectForKey:@"children"]];
                
                NSLog(@"bodyInfo:%@ \n wearer:%@",bodyInfo,wearer);
                
                BOOL succ = NO;
                unsigned long long wearID;
                if (wearer!=Nil) {
                    wearID  = [NSString isNullObjwithUnsignedlonglong:[wearer objectForKey:@"childrenID"]];
                    if (wearID>0) {
                        succ = YES;
                    }
                }
                if (succ == YES) {
                    
                    //设置当前操作对象为这个小孩
                    [[NSUserDefaults standardUserDefaults]setObject:childModel.simei forKey:[NSString stringWithFormat:@"%@_%@",[[UserHandle standardHandle] sMemberID],KUser_simei]];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                  
                    childModel.llWearId = wearID;
                    childModel.sCreatedTime = [NSString isNullObjwithNSString:[wearer objectForKey:@"createdTime"]];
                    
                    if (childModel.childLogoData!=Nil) { //当有头像是的时候
                        //被注释
//                        childModel.sPicturePath = [NSData  writeToChildLogo:childModel.childLogoData withiWearId:childModel.llWearId];
                        childModel.iChildLogoLenght = childModel.childLogoData.length;
                        childModel.sFileType = @"jpg";
                      //执行生产图片命令
                        NSDictionary *para  = @{@"childrenID":[NSNumber numberWithLongLong:childModel.llWearId],@"fileType":childModel.sFileType};
                        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
                        TcpClient *tcp = [TcpClient sharedInstance];
                        [tcp setDelegate_ITcpClient:self];
                        if(tcp.asyncSocket.isDisconnected)
                        {
//                            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
                           
                        }else if(tcp.asyncSocket.isConnected)
                        {
                            DataPacket *dataPacket    = [[DataPacket alloc] init];
                            dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
                            dataPacket.sCommand       = @"U_CHILDREN_AVATAR";
                            dataPacket.paraDictionary = mutableDictionary;
                            dataPacket.iType          = 1;
                            dataPacket.dataContent    = childModel.childLogoData;
                            [tcp sendContent:dataPacket];
                            
                        }else{
//                            [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
//                            return;
                        }
                        
                    }
                    
                    //写入数据库
                    [[TBChild shareDB] insert:childModel];
                    
                    for (UIViewController *temp in self.navigationController.viewControllers) {
                        if ([temp isKindOfClass:[ChildrenListVC class]]) {
                            
                            
                            [self.navigationController popToViewController:temp animated:YES];
                        }
                    }
                    
                   
                    
                    if (_mydelegate && [_mydelegate respondsToSelector:@selector(addChildren:)]) {
                        [_mydelegate addChildren:childModel];
                    }


                    //添加小孩对象
                    [SVProgressHUD showSuccessWithStatus:MLString(@"添加小孩对象成功！")];
                }else{
                
                    [SVProgressHUD showErrorWithStatus:MLString(@"添加小孩对象失败，可能是网络原因，请重试！")];
                }
                
            }else if ([[self getCommod] isEqualToString:@"R_U_CHILDREN_AVATAR"] == YES) {
                //上传小孩头像成功
                NSLog(@"上传小孩头像成功");
            
            }else{
                
                NSLog(@"其他的命令：%@",recivedTxt);
            }
        }
        
    }else{
        [SVProgressHUD showErrorWithStatus:[self getError]];
        return;
    }
    
    
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    
    NSLog(@"socket连接出现错误");
    
}




@end
