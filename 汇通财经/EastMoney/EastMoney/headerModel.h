//
//  headerModel.h
//  EastMoney
//
//  Created by 千锋 on 16/5/25.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface headerModel : NSObject

//标题
@property(nonatomic,copy) NSString *title;

//图片地址
@property(nonatomic,copy) NSString *picture;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
