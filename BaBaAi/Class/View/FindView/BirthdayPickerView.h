//
//  BirthdayPickerView.h
//  kidsApp
//
//  Created by kingly on 15/7/23.
//  Copyright (c) 2015年 kingly. All rights reserved.

#import <UIKit/UIKit.h>
#define kDefaultBirdOfDate @"2015-01-01"
@protocol BirthdayPickerViewDelegate <NSObject>
- (void) finishSelectBOD:(NSString*)bodString withIndexPath:(NSIndexPath *)indexPath;
@end

@interface BirthdayPickerView : UIView
@property(nonatomic,weak) id<BirthdayPickerViewDelegate> birthdayPickerViewDelegate;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property(nonatomic,weak) NSString *defaultBirdOfDate;

@end
