//
//  PicturePreviewController.h
//  kidsApp
//
//  Created by kingly on 15/7/23.
//  Copyright (c) 2015年 kingly. All rights reserved.



@interface PicturePreviewController : BaseViewController
/**
 * 当前图片的坐标系
 */
@property (nonatomic,assign) CGRect curPhotoRect;
/**
 * 选中的图片
 */
@property (nonatomic,copy) UIImage *selectImage;

@end
