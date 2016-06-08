//
//  URLModel.h
//  EastMoney
//
//  Created by 千锋 on 16/6/2.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLModel : NSObject

//自选
@property(nonatomic,copy) NSString *selfPortfolio;

//黄金
@property(nonatomic,copy) NSString *gold;

//外汇
@property(nonatomic,copy) NSString *foreignCurrency;

//股指
@property(nonatomic,copy) NSString *stock;

//COMEX
@property(nonatomic,copy) NSString *COMEX;

- (instancetype) initModel;

@end
