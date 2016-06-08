//
//  NaviScrollView.h
//  EastMoney
//
//  Created by 千锋 on 16/5/31.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarketsViewController;
@interface NaviScrollView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame andViewController:(MarketsViewController *)viewController;

@end
