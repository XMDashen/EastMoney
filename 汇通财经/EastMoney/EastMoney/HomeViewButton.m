//
//  HomeViewButton.m
//  EastMoney
//
//  Created by 千锋 on 16/5/31.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "HomeViewButton.h"

@implementation HomeViewButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.frame=frame;
        
        [self creatUI];
    }
    return self;
}

#pragma mark - 创建自定义buttonUI
- (void)creatUI{
    
    //创建图片区
    CGFloat imageViewWidth=self.bounds.size.width;
    CGFloat imageViewHeight=self.bounds.size.height*2/3;
    
    _imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewWidth,imageViewHeight)];
    
    [self addSubview:_imgView];
    
    //创建label区
    CGFloat labelX=0;
    CGFloat labelY=imageViewHeight;
    CGFloat labelWidth=imageViewWidth;
    CGFloat labelHeight=self.bounds.size.height/4;
    
    _label=[[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    _label.textColor=[UIColor blackColor];
    _label.font=[UIFont systemFontOfSize:12.0];
    _label.textAlignment=1;
    
    [self addSubview:_label];
    
}

@end
