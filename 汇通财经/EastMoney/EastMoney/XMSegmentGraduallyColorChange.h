//
//  XMSegmentGraduallyColorChange.h
//  EastMoney
//
//  Created by 千锋 on 16/6/7.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMSegmentGraduallyColorChange : UIView

//按钮文字颜色
@property(nonatomic,strong) UIColor *titleColor;

//选中文字颜色
@property(nonatomic,strong) UIColor *selectedTitleColor;

//背景框颜色
@property(nonatomic,strong) UIColor *backgroundColor;

//按钮颜色
@property(nonatomic,strong) UIColor *buttonColor;

//选中按钮颜色
@property(nonatomic,strong) UIColor *selectedButtonColor;

//字体大小
@property(nonatomic,assign) CGFloat fontOfSize;

/**
 *  初始化及界面搭建
 *
 *  @param frame      背景框
 *  @param width      按钮宽
 *  @param height     按钮高
 *  @param titleArray 按钮标题文字
 *  @param clickBlock 按钮点击事件
 *
 */
- (instancetype)initWithFrame:(CGRect)frame ButtonWidth:(CGFloat)width buttonHeight:(CGFloat)height titleArray:(NSArray *)titleArray clickEvent:(void(^)(UIButton *button))clickBlock;

@end
