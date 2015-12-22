//
//  ContactManagerCell.m
//  BabaGoing
//
//  Created by 冯大师 on 15/11/20.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "ContactManagerCell.h"

@implementation ContactManagerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ManagerModel *)model{
    _model = model;
    self.myImageVIew.layer.cornerRadius = self.myImageVIew.bounds.size.height/2;
    self.myImageVIew.clipsToBounds = YES;
    self.myImageVIew.contentMode = UIViewContentModeScaleAspectFill;
    self.myImageVIew.backgroundColor = [UIColor clearColor];
//    self.myImageVIew.image = [[FileManagerHelper share] getImageViewFromImage:model.nameImage];
    self.myImageVIew.image = [UIImage imageNamed:model.nameImage];
    self.nameLab.text = model.name;
    self.telphoneLab.text = model.telPhone;

}



@end
