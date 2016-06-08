//
//  newsModel.h
//  EastMoney
//
//  Created by 万晓 on 16/5/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsModel : NSObject

//新闻图片
@property(nonatomic,copy) NSString *picture;

//新闻标题
@property(nonatomic,copy) NSString *title;


-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
