//
//  ButtonScrollView.m
//  EastMoney
//
//  Created by 万晓 on 16/5/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "ButtonScrollView.h"
#import "HomeViewButton.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

@implementation ButtonScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    
    if (self=[super init]) {
        
        CGFloat buttonScrollViewY=200;
        CGFloat buttonScrollViewHeight=180.0;
        
        ButtonScrollView *buttonScrollView=[[ButtonScrollView alloc] initWithFrame:CGRectMake(0, buttonScrollViewY, WIDTH, buttonScrollViewHeight)];
        
        //内容物大小
        buttonScrollView.contentSize=CGSizeMake(WIDTH * 2, buttonScrollViewHeight);
        
        //打开分页效果
        buttonScrollView.pagingEnabled=YES;
        
        //关闭弹性边界
        buttonScrollView.bounces=NO;
        
        //button尺寸
        CGFloat buttonMargin=35;
        CGFloat buttonWidth=(2*WIDTH-10*buttonMargin)/8;
        CGFloat buttonHeight=80;
        
        
        NSArray *labelTitle=@[@"财经快讯",@"A股直播",@"行业动态",@"交易商",@"模拟交易",@"论坛",@"金店报价",@"常用工具",@"实时解盘",@"报刊杂志",@"邮币行情",@"汇通问吧",@"预警消息",@"K线角斗士",@"美元指数",@"微盘"];
        
        NSArray *labelImg=@[@"kxzb",@"agzb",@"dzhy",@"portal",@"mnjy",@"lt",@"jdbj",@"cygj",@"spjp",@"dyzx",@"ybkxq",@"htdy",@"yj",@"kline",@"usd",@"weipan"];
        
         //创建BUTTON
        for (int i=0; i<2; i++) {
            for (int j=0; j<8; j++) {
                
                //标签尺寸位置
                HomeViewButton *button;
                //第二页第一列标签坐标
                if (j>=4) {
                button=[[HomeViewButton alloc] initWithFrame:CGRectMake(2*buttonMargin+(buttonWidth+buttonMargin)*j, buttonMargin/2+buttonHeight*i, buttonWidth, buttonHeight)];
                }else{
                button=[[HomeViewButton alloc] initWithFrame:CGRectMake(buttonMargin+(buttonWidth+buttonMargin)*j, buttonMargin/2+buttonHeight*i, buttonWidth, buttonHeight)];
                }
                
                //标签图片
                NSString *imgName=[NSString stringWithFormat:@"APP_icon_%@.png",labelImg[j+8*i]];
                button.imgView.image=[UIImage imageNamed:imgName];
                
                //标签标题
                button.label.text=labelTitle[j+8*i];
                
                [buttonScrollView addSubview:button];
            
            }
        }
        
        return buttonScrollView;
        
    }
    return self;
}

@end
