//
//  FindPwdVC.h
//  LBKidsApp
//
//  Created by kingly on 15/8/6.
//  Copyright (c) 2015年 kingly. All rights reserved.
//



@interface FindPwdVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIView *xLineView;
@property (weak, nonatomic) IBOutlet UIView *sLineView;
@property (weak, nonatomic) IBOutlet UILabel *NoteLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
- (IBAction)onClickSendBtn:(id)sender;
- (IBAction)OnClickSendHighted:(id)sender;

@end
