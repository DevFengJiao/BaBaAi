//
//  GenderPickerView.h
//  kidsApp
//
//  Created by kingly on 15/7/23.
//  Copyright (c) 2015年 kingly. All rights reserved.

#import <UIKit/UIKit.h>

@protocol GenderPickerViewDelegate <NSObject>
- (void) finishSelectGender:(int)selectedIndex withIndexPath:(NSIndexPath *)indexPath;
@end

@interface GenderPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,weak) id<GenderPickerViewDelegate> genderPickerViewDelegate;
@property(nonatomic,strong) NSArray* genderData;
@property (nonatomic, retain) NSIndexPath *indexPath;
@end
