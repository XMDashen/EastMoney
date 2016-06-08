//
//  HomeViewController.m
//  EastMoney
//
//  Created by 千锋 on 16/5/24.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImageView+WebCache.h"
#import "headerModel.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "HeaderScrollView.h"
#import "ButtonScrollView.h"
#import "newsModel.h"
#import "NewsTableViewCell.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

//新闻请求地址
#define NEWSURL @"http://htmdata.fx678.com/fx678/16/news/top.php?s=ab2c201ddcddb748c4b373d0211698da&nid=0&time=1464421843&key=c3031cca4dcf41ceb9bb30b7505fe84e"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

//tableView
@property(nonatomic,strong)UITableView *newsTableView;

//新闻model数组
@property (nonatomic,strong)NSMutableArray *newsModelArray;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    //设置tabBar背景图片
    self.tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_bg@2x"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //搭建页面UI框架
    [self creatUI];
}


#pragma mark - 搭建UI框架
- (void)creatUI{
    
    //页面标题
    self.title=@"汇通财经";
    
    //创建新闻model
    [self creatModel];
    
    //创建tableView
    self.newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-47) style:UITableViewStylePlain];
    
    self.newsTableView.delegate=self;
    self.newsTableView.dataSource=self;
    [self.view addSubview:self.newsTableView];
    
    //添加头部滚动视图
    [self creatHeaderViewAndFooterView];
    
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
            [self.newsTableView reloadData];
        }];
    }];
    
    [task resume];
    
}

#pragma mark - creatHeaderViewAndFooterView
- (void)creatHeaderViewAndFooterView{
    
    //======创建headerScrollView=====
    HeaderScrollView *headerView=[[HeaderScrollView alloc] init];
    
    //======创建buttonScrollView=====
    ButtonScrollView *buttonScrollView=[[ButtonScrollView alloc] init];
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 380)];
    
    //添加到头部View面板上
    [view addSubview:headerView];
    [view addSubview:buttonScrollView];
    
    //添加view到tableView的headerView上
    self.newsTableView.tableHeaderView=view;
    
}

#pragma mark - 代理和数据源方法

//设置tableView的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsModelArray.count;

}

//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
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

#pragma - 懒加载
-(NSMutableArray *)newsModelArray{
    
    if (_newsModelArray==nil) {
        _newsModelArray=[[NSMutableArray alloc] init];
    }
    return _newsModelArray;
}

@end
