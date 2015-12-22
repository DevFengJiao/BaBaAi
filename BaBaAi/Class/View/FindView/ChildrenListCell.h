//
//  ChildrenListCell.h
//  LBKidsApp
//
//  Created by kingly on 15/8/17.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kChildrenListCell @"kChildrenListCell"

@interface ChildrenListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *childLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *childName;

@property (weak, nonatomic) ChildModel *cModel;


@end
