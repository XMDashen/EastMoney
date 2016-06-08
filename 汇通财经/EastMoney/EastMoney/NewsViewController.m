//
//  NewsViewController.m
//  EastMoney
//
//  Created by 千锋 on 16/5/24.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsNaviScrollView.h"
#import "NewsTableViewCell.h"
#import "newsModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define NEWSURL @"http://htmdata.fx678.com/15/fx678/news.php?s=ab2c201ddcddb748c4b373d0211698da&oid=1&nc=NEWS_YAO_WEN&nid=0&time=1465213202&key=0164eebe997c07efa565ee5419127b36"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

//新闻模型数组
@property(nonatomic,strong)NSMutableArray *newsModelArray;

@end

@implementation NewsViewController

-(void)viewWillAppear:(BOOL)animated{
    
    //设置tabBar背景图片
    self.tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_bg@2x"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //创建模型
    [self creatModel];
    
    //搭建UI
    [self creatUI];
    
}

#pragma mark - 搭建UI
-(void)creatUI{
    
    CGFloat scrollViewX=0;
    CGFloat scrollViewY=64;
    CGFloat scrollViewWidth=self.view.bounds.size.width;
    CGFloat scrollViewHeight=35;
    
    //滚动导航条
    NewsNaviScrollView *naviScrollView=[[NewsNaviScrollView alloc] initWithFrame:CGRectMake(scrollViewX, scrollViewY, scrollViewWidth, scrollViewHeight)];
    
    [self.view addSubview:naviScrollView];
    
    //tableView
    [self creatTableView];
    
    
}

#pragma mark - 创建新闻model
- (void)creatModel{
    
    //请求数据
    //创建请求
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:NEWSURL]];
    
    //创建会话模式
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建会话
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
    //创建任务
    
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        NSDictionary *tmpDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        NSArray *newsArray=tmpDict[@"news"];
        
        for (NSDictionary *dict in newsArray) {
            
            newsModel *model=[[newsModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.newsModelArray addObject:model];
            
        }
        
        //刷新数据(回到主线程)
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    
    [task resume];
    
}


#pragma mark - tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.newsModelArray.count;
}

#pragma mark - 创建Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //新闻cell
    static NSString *iden=@"NewsIden";
    
    NewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell==nil) {
        
        cell=[[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        
    }
    
    //加载cell数据
    
    cell.model = (newsModel *)self.newsModelArray[indexPath.row];
    
    return cell;
    
}

//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

#pragma mark - 懒加载
-(NSMutableArray *)newsModelArray{
    if (_newsModelArray==nil) {
        _newsModelArray=[NSMutableArray array];
    }
    return _newsModelArray;
}

#pragma mark - 创建tableView
-(void)creatTableView{
    
    CGFloat tableViewX=0;
    CGFloat tableViewY=20+44+35;
    CGFloat tableViewW=WIDTH;
    CGFloat tableViewH=HEIGHT-tableViewY-49;
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
}
@end
