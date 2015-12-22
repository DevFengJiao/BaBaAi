//
//  AddContactManagerVC.h
//  BabaGoing
//
//  Created by 冯大师 on 15/11/20.
//  Copyright © 2015年 kingly. All rights reserved.
//


#import "ManagerModel.h"
#import "ContactManagerCell.h"

@interface AddContactManagerVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIScrollView    *mainScrollView;
    UITableView     *mainTableView;
    NSMutableArray  *mainArrays;
    NSMutableArray  *subArryas;
    ManagerModel    *model;
    UILabel         *belowLab;
    
    UITableView     *sencondTableView;
    
}
@end
