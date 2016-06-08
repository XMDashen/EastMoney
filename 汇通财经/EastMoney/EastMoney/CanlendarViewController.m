//
//  CanlendarViewController.m
//  EastMoney
//
//  Created by 千锋 on 16/5/25.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "CanlendarViewController.h"

@interface CanlendarViewController ()

@end

@implementation CanlendarViewController

-(void)viewWillAppear:(BOOL)animated{
    
    //设置tabBar背景图片
    self.tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_bg@2x"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
