//
//  URLModel.m
//  EastMoney
//
//  Created by 千锋 on 16/6/2.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "URLModel.h"

@implementation URLModel

- (instancetype)initModel
{
    self = [super init];
    if (self) {
        
    _selfPortfolio=@"http://htmmarket.fx678.com/custom.php?excode=custom&code=WGJS%7CXAU,WGJS%7CXAG,NYMEX%7CCONC,WH%7CUSD,WH%7CUSDJPY,WH%7CEURUSD&time=1464861481&token=6a066cff07860a54000cf04ea53ebfe3&key=a7d48f82973fbc240e5ff17dc9112904";
        
    _gold=@"http://htmmarket.fx678.com/list.php?excode=WGJS&time=1464861478&token=6a066cff07860a54000cf04ea53ebfe3&key=71953d471dd3624b99c3e140b006a33e";
        
    _foreignCurrency=@"http://htmmarket.fx678.com/list.php?excode=WH&time=1464946107&token=6a066cff07860a54000cf04ea53ebfe3&key=76e57a9f3f07f455c448d2bfa70431ed";
        
    _stock=@"http://htmmarket.fx678.com/list.php?excode=GJZS&time=1464946246&token=6a066cff07860a54000cf04ea53ebfe3&key=448274cb1b5dabb069d4e8b3574b0e12";
        
    _COMEX=@"http://htmmarket.fx678.com/list.php?excode=COMEX&time=1464954341&token=6a066cff07860a54000cf04ea53ebfe3&key=85e62df323b867b9a9c8a5d99ddb246f";
        
    }
    return self;
}

@end
