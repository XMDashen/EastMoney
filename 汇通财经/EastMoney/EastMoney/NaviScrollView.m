//
//  NaviScrollView.m
//  EastMoney
//
//  Created by 千锋 on 16/5/31.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "NaviScrollView.h"
#import "MarketsViewController.h"
#import "XMSegmentGraduallyColorChange.h"

#define BUTTON_TAG 100

@interface NaviScrollView(){
    
    CGFloat buttonWidth;
    CGFloat buttonHeight;
}

//行情页控制器
@property(nonatomic,strong) MarketsViewController *viewController;

//
@property(nonatomic,strong) NSArray *tradeTypeArray;

//标签选中视图
@property(nonatomic,strong) UIView *selectedView;

//标签选中文字视图
@property(nonatomic,strong) UIView *textView;

@end

@implementation NaviScrollView

- (instancetype)initWithFrame:(CGRect)frame andViewController:(MarketsViewController *)viewController{
    
    if (self=[super initWithFrame:frame]) {
        
        self.frame=frame;
        
        //传入行情页面控制器
        _viewController=viewController;
        
        //创建界面
        [self creatUI];
        
    }
    
    return self;
}

#pragma mark - 创建界面
- (void)creatUI{
    
    CGFloat scrollViewWidth=2*[UIScreen mainScreen].bounds.size.width;
    CGFloat scrollViewHeight=self.bounds.size.height;
    
    self.backgroundColor=[UIColor blackColor];
    
    self.contentSize=CGSizeMake(scrollViewWidth, scrollViewHeight);
    
    self.showsHorizontalScrollIndicator=NO;
    self.showsVerticalScrollIndicator=NO;
    
    //创建scrollView上的button
    //标签名称
    _tradeTypeArray=@[@"自选",@"黄金",@"外汇",@"股指",@"COMEX"];
    
    //添加滑块特效
    [self addSlideMode];
    
}

#pragma mark - 添加滑块特效
- (void)addSlideMode{
    XMSegmentGraduallyColorChange *segment=[[XMSegmentGraduallyColorChange alloc] initWithFrame:self.bounds ButtonWidth:60 buttonHeight:35 titleArray:_tradeTypeArray clickEvent:^(UIButton *button) {
        
        //组合名称数组
        NSArray *portfolioArray=@[@"selfPortfolio",@"gold",@"foreignCurrency",@"stock",@"COMEX"];
        
        //更改金融组合的名称
        _viewController.portfolioName=portfolioArray[button.tag-BUTTON_TAG];
 
        //重新刷新获取数据
        [_viewController performSelector:@selector(downLoadData) withObject:nil afterDelay:0];

    }];
    
    segment.backgroundColor=[UIColor blackColor];
    
    segment.buttonColor=[UIColor blackColor];
    
    segment.titleColor=[UIColor whiteColor];
    
    segment.selectedButtonColor=[UIColor whiteColor];
    
    segment.selectedTitleColor=[UIColor grayColor];
    
    segment.fontOfSize=16;
    
    [self addSubview:segment];
}

@end
