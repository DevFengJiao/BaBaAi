//
//  DatetimePickerViewDelegate.h
//  kidsApp
//
//  Created by kingly on 15/7/23.
//  Copyright (c) 2015年 kingly. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DatetimeDelegate <NSObject>

- (void) finishSelectDatetime:(NSDate *)datetime withTag:(int)itag withIndexPath:(NSIndexPath *)indexPath;

- (void)cancelAction:(id)sender;

@end

@interface DatetimePickerViewDelegate : UIView

@property(nonatomic,weak) id<DatetimeDelegate> DatetimeDelegate;

@property(readwrite) int itag;

@property (nonatomic, retain) NSIndexPath *indexPath;
@end
