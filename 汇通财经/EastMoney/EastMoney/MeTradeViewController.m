//
//  MeTradeViewController.m
//  EastMoney
//
//  Created by 千锋 on 16/5/24.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "MeTradeViewController.h"

@interface MeTradeViewController ()

@end

@implementation MeTradeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    //设置tabBar背景图片
    self.tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_bg@2x"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
