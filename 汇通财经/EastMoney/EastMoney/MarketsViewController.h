//
//  MarketsViewController.h
//  EastMoney
//
//  Created by 千锋 on 16/5/24.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketsViewController : UIViewController

//金融类组合名称
@property(nonatomic,copy) NSString *portfolioName;

//tableView
@property(nonatomic,strong) UITableView *tableView;

@end
