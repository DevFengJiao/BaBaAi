//
//  FeedbackVC.m
//  LBKidsApp
//
//  Created by kingly on 15/8/9.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "FeedbackVC.h"


@interface FeedbackVC ()<UITextViewDelegate,UITextFieldDelegate,ITcpClient>{
    
    UILabel *suggestPlaceHolder;//默认文本
    
}

@end

@implementation FeedbackVC

-(void)loadView
{
    [super loadView];
    [self navigationBarShow];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rightNavBarItemWithTitle:@"提交" AndSel:@selector(itemAction:)];
    
    [self loadCustomView];
    
    //     [self checkSendSuggestionCondition];
    
    [self addHiddenKeyBoardGesture];//添加手势
    
    [self addObserVeforInput];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/**
 * 注册观察者 监听输入字符变化
 */
-(void)addObserVeforInput
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputTextChange) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputTextChange) name:UITextFieldTextDidChangeNotification object:nil];
}
/**
 * 接受通知刷新UI
 * 设置提交按钮是否可点击
 */
-(void)inputTextChange
{
    [self checkSendSuggestionCondition];//检查提交意见的条件
}

/**
 * 添加隐藏键盘的手势
 */
-(void)addHiddenKeyBoardGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];
    
    [self.view addGestureRecognizer:tap];
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
    
    //    [self.phoneTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];`
    
    UIColor *color = [UIColor lightGrayColor];
    _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:MLString(@"请输入您的联系电话") attributes:@{NSForegroundColorAttributeName: color}];
    
    _phoneTextField.text = [[UserHandle standardHandle] sMemberID];
    
    
    //textview实现类textfield的placeholder
    suggestPlaceHolder = [[UILabel alloc]initWithFrame:CGRectMake(10,5, _feedBackTextView.frame.size.width - 10, 20)];
    suggestPlaceHolder.font = [UIFont systemFontOfSize:16];
    suggestPlaceHolder.numberOfLines = 1;
    suggestPlaceHolder.textColor = [UIColor lightGrayColor];
    suggestPlaceHolder.text = MLString(@"请输入您的意见或遇到的问题");
    suggestPlaceHolder.enabled = NO;
    suggestPlaceHolder.backgroundColor = [UIColor clearColor];
    
    [_feedBackTextView addSubview:suggestPlaceHolder];
    
    [_feedBackTextView becomeFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 提交意见反馈
/**
 * navigationBar右边按钮点击
 * 提交意见建议
 */
-(void)itemAction:(UIBarButtonItem *)sender
{
    [self hiddenKeyBoard];
    
    NSLog(@"text: %@",self.feedBackTextView.text);
    
    if (NULL_STR(self.feedBackTextView.text)){
        
        [SVProgressHUD showErrorWithStatus:MLString(@"请输入您的意见或遇到的问题")];
        return;
    }else{
        [SVProgressHUD showSuccessWithStatus:MLString(@"感谢您的宝贵意见，我们会尽快处理！")];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
//    NSDictionary *para  = @{@"contact":_phoneTextField.text,
//                            @"content":_feedBackTextView.text};
//    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:para];
//    TcpClient *tcp = [TcpClient sharedInstance];
//    [tcp setDelegate_ITcpClient:self];
//    if(tcp.asyncSocket.isDisconnected)
//    {
//        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络有异常，请检查网络设置！")];
//        return;
//    }else if(tcp.asyncSocket.isConnected)
//    {
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//        
//        
//        DataPacket *dataPacket    = [[DataPacket alloc] init];
//        dataPacket.timestamp      = [DateUtil stringFormateWithYYYYMMDDHHmmssSSS:[NSDate date]];
//        dataPacket.sCommand       = @"C_FDB";
//        dataPacket.paraDictionary = mutableDictionary;
//        dataPacket.iType          = 0;
//        [tcp sendContent:dataPacket];
//        
//    }else{
//        [SVProgressHUD showErrorWithStatus:MLString(@"当前网络异常，请检查网络设置后重试！")];
//        return;
//    }
//    
}

/**
 * 检查是否满足提交建议的条件
 */
-(void)checkSendSuggestionCondition
{
    NSLog(@"text: %@",self.phoneTextField.text);
    if (!NULL_STR(self.feedBackTextView.text)||!NULL_STR(self.phoneTextField.text)) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}
#pragma mark - UITextViewDelegate
/**
 * 设置默认的提示文字
 */
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        suggestPlaceHolder.text =  MLString(@"请输入您的意见或遇到的问题");
    }else{
        suggestPlaceHolder.text = @"";
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textFieldDidBeginEditing");
    if ([textView isEqual:self.feedBackTextView]){
        //[self viewUpwardWithMargin:20];//视图上移
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self viewDownward];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void) textFieldDidEndEditing:(UITextField *)textField{
    
}


#pragma mark - hiddenKeyBoard
-(void)hiddenKeyBoard
{
    [self.feedBackTextView resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    
    [self viewDownward];//view下移
}

#pragma mark - 视图移动
/**
 * view上移
 */
-(void)viewUpwardWithMargin:(int)margin
{
    int keyBoardUpHeight = 0;
    if (margin == 20) {
        keyBoardUpHeight = 20;
    }else{
        if (kIphone4S){
            keyBoardUpHeight = margin;
        }else{
            keyBoardUpHeight = 45;
        }
    }
    
    if (self.myScrollView.contentOffset.y != keyBoardUpHeight) {
        [UIView animateWithDuration:0.35f animations:^{
            self.myScrollView.contentOffset = CGPointMake(self.myScrollView.contentOffset.x, keyBoardUpHeight);
        }];
    }
}

/**
 * view下移
 */
-(void)viewDownward
{
    if (self.myScrollView.contentOffset.y != 0) {
        [UIView animateWithDuration:0.35f animations:^{
            self.myScrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
}

#pragma mark ITcpClient
/**发送到服务器端的数据*/
-(void)OnSendDataSuccess:(NSString*)sendedTxt{
    
    NSLog(@"发送到服务器端的数据");
}

/**收到服务器端发送的数据*/
-(void)OnReciveData:(NSDictionary *)recivedTxt{
    NSLog(@"收到意见反馈,%@",recivedTxt);
    [self.navigationController popViewControllerAnimated:YES];
    if ([self checkSocketRespClass:recivedTxt]){
        
        [SVProgressHUD showSuccessWithStatus:MLString(@"感谢你的宝贵意见和建议")];
        
    }else{
        [SVProgressHUD showErrorWithStatus:[self getError]];
        return;
    }
}

/**socket连接出现错误*/
-(void)OnConnectionError:(NSError *)err{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"socket连接出现错误");
    
}


@end
