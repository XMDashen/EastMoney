//
//  TabBarController.m
//  EastMoney
//
//  Created by 千锋 on 16/5/24.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "MarketsViewController.h"
#import "NewsViewController.h"
#import "CanlendarViewController.h"
#import "MeTradeViewController.h"


@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //搭建基本UI框架，添加导航控制器、视图控制器
    [self creatUI];
}

#pragma mark - 搭建基本UI框架，添加导航控制器、视图控制器
- (void)creatUI{
    
    //设置背景颜色
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置tabBar颜色
    self.tabBar.barTintColor=[UIColor whiteColor];
    
    //创建视图控制器
    HomeViewController *homeView=[[HomeViewController alloc] init];
    NewsViewController *newsView=[[NewsViewController alloc] init];
    CanlendarViewController *canlendarView=[[CanlendarViewController alloc] init];
    MarketsViewController *marketsView=[[MarketsViewController alloc] init];
    MeTradeViewController *meTradeView=[[MeTradeViewController alloc] init];
    
    //标题数组
    NSArray *titleArray=@[@"首页",@"行情",@"资讯",@"日历",@"我"];
    
    //图标名数组
    NSArray *imgArray=@[@"main",@"market",@"news",@"calendar",@"me"];
    
    //视图控制器数组
    NSArray *viewControllers=@[homeView,marketsView,newsView,canlendarView,meTradeView];
    
    for (int i=0; i<5; i++) {
        
        //获得图片名称
        NSString *imgNormal=[NSString stringWithFormat:@"tabbar_%@@2x",imgArray[i]];
        
        NSString *imgSelected=[NSString stringWithFormat:@"tabbar_%@_hover@2x",imgArray[i]];
        
        //获得对应的视图控制器
        UIViewController *vc=viewControllers[i];
        
        //将视图控制器添加为导航控制器的根视图控制器
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
        
        //设置navigationBar的颜色
        nav.navigationBar.backgroundColor=[UIColor whiteColor];
        
        //设置tabBar标题
        nav.tabBarItem.title=titleArray[i];
        
        //设置tabBar图片
        nav.tabBarItem.image=[UIImage imageNamed:imgNormal];
        
        nav.tabBarItem.selectedImage=[UIImage imageNamed:imgSelected];
        
        //添加导航控制器到tabBarController上
        [self addChildViewController:nav];
        
    }
    
}

@end
