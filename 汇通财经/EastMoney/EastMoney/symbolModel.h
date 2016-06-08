//
//  symbolModel.h
//  EastMoney
//
//  Created by 千锋 on 16/6/2.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface symbolModel : NSObject

//金融代号
@property(nonatomic,copy) NSString *Code;

//金融品种名
@property(nonatomic,copy) NSString *Name;

//买入价
@property(nonatomic,assign) float Buy;

//卖出价
@property(nonatomic,assign) float Sell;

//最高价
@property(nonatomic,assign) float High;

//最低价
@property(nonatomic,assign) float Low;

//今日开盘价
@property(nonatomic,assign) float Open;

//昨日收盘价
@property(nonatomic,assign) float LastClose;

//成交量
@property(nonatomic,assign) float Volume;

@end
