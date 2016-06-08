//
//  NewsNaviScrollView.m
//  EastMoney
//
//  Created by 千锋 on 16/6/3.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "NewsNaviScrollView.h"
#import "XMSegmentGraduallyColorChange.h"

#define BUTTON_TAG 200

@interface NewsNaviScrollView(){
    
    float buttonWidth;
    float buttonHeight;
    
}

@property(nonatomic,strong)NSArray *titleArray;

//标签选中视图
@property(nonatomic,strong) UIView *selectedView;

//标签选中文字视图
@property(nonatomic,strong) UIView *textView;

@end


@implementation NewsNaviScrollView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self= [super initWithFrame:frame]) {
        
        self.frame=frame;
        
        [self creatUI];
        
    }
    return self;
}

#pragma mark - 搭建UI
- (void)creatUI{
    
    //contentView尺寸
    CGFloat contentViewWidth=2*self.bounds.size.width;
    CGFloat contentViewHeight=self.bounds.size.height;
    
    self.contentSize=CGSizeMake(contentViewWidth, contentViewHeight);
    
    self.backgroundColor=[UIColor whiteColor];
    
    self.showsHorizontalScrollIndicator=NO;
    self.showsVerticalScrollIndicator=NO;
    
    _titleArray=@[@"要闻",@"推送",@"直播",@"外汇",@"金银"];
    
    //添加滑块特效按钮
    XMSegmentGraduallyColorChange *segment=[[XMSegmentGraduallyColorChange alloc] initWithFrame:CGRectMake(0, 0, contentViewWidth, contentViewHeight) ButtonWidth:50 buttonHeight:self.bounds.size.height titleArray:_titleArray clickEvent:^(UIButton *button) {
        NSLog(@"%@",button.currentTitle);
    }];
    
    segment.backgroundColor=[UIColor whiteColor];
    
    segment.buttonColor=[UIColor whiteColor];
    
    segment.titleColor=[UIColor grayColor];
    
    segment.selectedButtonColor=[UIColor blackColor];
    
    segment.selectedTitleColor=[UIColor whiteColor];
    
    segment.fontOfSize=16;
    
    [self addSubview:segment];
}

@end
