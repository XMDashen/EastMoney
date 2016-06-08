//
//  HeaderScrollView.m
//  EastMoney
//
//  Created by 万晓 on 16/5/28.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "HeaderScrollView.h"
#import "headerModel.h"
#import "UIImageView+WebCache.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

//滚动新闻图片请求地址
#define HEADERURL @"http://htmdata.fx678.com/15/fx678/top.php?s=ab2c201ddcddb748c4b373d0211698da&time=1464351463&key=ee12188eba52e1bfa3642e75406554ec"

@interface HeaderScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *headerModelArray;

@property(nonatomic,strong) NSTimer *timer;
@end

@implementation HeaderScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 重写init方法
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.delegate=self;
    //头部新闻图片栏数据请求
    [self headerNewsRequest];
        
        
    }
        return self;
}

#pragma mark - 懒加载
- (NSMutableArray *)headerModelArray{
    
    if (_headerModelArray==nil) {
        _headerModelArray=[NSMutableArray array];
        
    }
    return _headerModelArray;
}

#pragma mark - 头部新闻图片栏数据请求
- (void)headerNewsRequest{
    
    //用URL创建请求
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:HEADERURL]];
    
    //创建会话模式
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建会话
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
    //创建任务
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //接收到的数据数组
        NSArray *newsArray=[NSArray arrayWithObject:dict[@"news"]];
        
        for (int i=0; i<3; i++) {
            
            NSDictionary *dictNews=[NSDictionary dictionary];
            
            dictNews=newsArray[0][i];
            
            
            headerModel *model=[[headerModel alloc] init];
            
            
            //用接收到的字典给model赋值
            [model setValuesForKeysWithDictionary:dictNews];
            
            //将模型添加到数组中
            [self.headerModelArray addObject:model];
            
            
        }
        
        //======创建广告栏scrollView======
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self creatHeaderScrollView];
        }];
        
        
    }];
    
    [task resume];
}

//创建广告栏scrollView
- (void)creatHeaderScrollView{
    //scrollView尺寸
    CGFloat scrollViewY=0;
    CGFloat scrollViewHeight=200.0;
    
    CGFloat labelHeight=20;
    CGFloat labelY=scrollViewHeight-labelHeight;
    
    self.frame=CGRectMake(0, scrollViewY, WIDTH, scrollViewHeight);
    
    
    //内容物大小
    self.contentSize=CGSizeMake(WIDTH * 3, scrollViewHeight);
    
    //打开分页效果
    self.pagingEnabled=YES;
    
    //关闭弹性边界
    self.bounces=NO;
    
    //加入页面指示器
    UIPageControl *pageControll=[[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH-50, labelY, 50, labelHeight)];
    
    pageControll.numberOfPages=3;
    
    pageControll.currentPage=1;
    
    [self addSubview:pageControll];
    
    //创建imageView滚动图片
    for (int i=0; i<3; i++) {
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(i * WIDTH, 0, WIDTH, scrollViewHeight)];
        
        //从网络加载图片
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:((headerModel *)_headerModelArray[i]).picture]];
        
        [self addSubview:imageView];
        
        //添加图片文字标签
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, labelY, WIDTH, labelHeight)];
        
        label.text=((headerModel *)_headerModelArray[i]).title;
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:13.0];
        [imageView addSubview:label];
        
    }
    
    //自动滚动timer
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    [timer fire];
   
    self.timer=timer;
}

//自动滚动
- (void)autoScroll{
    
    [UIView animateWithDuration:1 animations:^{
        if (self.contentOffset.x+WIDTH>=self.contentSize.width) {
            self.contentOffset=CGPointMake(0, self.contentOffset.y);
        }
        else{
            self.contentOffset=CGPointMake(self.contentOffset.x+WIDTH, self.contentOffset.y);
        }
    }];

}

//停止自动滚动
-(void)stopAutoScroll{
    
    [self.timer invalidate];
    self.timer=nil;
    
}

#pragma mark - 拖动图片时停止timer
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopAutoScroll];
}

#pragma mark - 拖动结束后启动timer
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //自动滚动timer
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    [timer fire];
    
    self.timer=timer;
}
@end
