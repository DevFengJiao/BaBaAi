//
//  ChildrenListCell.m
//  LBKidsApp
//
//  Created by kingly on 15/8/17.
//  Copyright (c) 2015年 kingly. All rights reserved.
//

#import "ChildrenListCell.h"


@implementation ChildrenListCell



/**
 * 设置数据模型，刷新视图
 */
-(void)setCModel:(ChildModel *)cModel
{
    if (_cModel != cModel) {
        _cModel = nil;
        _cModel = cModel;
        
        //头像
        self.childLogoImageView.layer.cornerRadius = self.childLogoImageView.bounds.size.height/2;
        self.childLogoImageView.clipsToBounds = YES;
        self.childLogoImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.childLogoImageView.image = [[FileManagerHelper share] getImageViewFromImage:_cModel.llWearId];
        //名字
        self.childName.text = _cModel.sChildName;
        
    }
}

@end
