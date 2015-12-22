//
//  ContactManagerCell.h
//  BabaGoing
//
//  Created by 冯大师 on 15/11/20.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerModel.h"


@interface ContactManagerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageVIew;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *telphoneLab;

@property (nonatomic, strong) ManagerModel *model;


@end
