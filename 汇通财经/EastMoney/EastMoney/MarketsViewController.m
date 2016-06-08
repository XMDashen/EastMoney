//
//  MarketsViewController.m
//  EastMoney
//
//  Created by 千锋 on 16/5/24.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "MarketsViewController.h"
#import "NaviScrollView.h"
#import "MarketTableViewCell.h"
#import "symbolModel.h"
#import "URLModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MarketsViewController ()<UITableViewDataSource,UITableViewDelegate>

//金融品种的model数组
@property(nonatomic,strong) NSMutableArray *tradeArray;

@end

@implementation MarketsViewController

-(void)viewWillAppear:(BOOL)animated{
    
    //设置tabBar背景图片
    self.tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"tabbar_black@2x"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //关闭自动布局
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //初始金融组合名称
    self.portfolioName=@"selfPortfolio";
    
    //创建UI
    [self creatUI];
    
    //从网络获取数据，导入模型
    [self downLoadData];
    
    //定时刷新
    [self refresh];
}

#pragma mark - 创建UI界面
- (void)creatUI{
    
    //创建导航栏按钮
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem=leftBarButton;
    
    //创建滚动导航条
    CGFloat naviScrollHeight=35;
    NaviScrollView *naviScrollView=[[NaviScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, naviScrollHeight) andViewController:self];
    
        [self.view addSubview:naviScrollView];
    
    //=============创建tableView============
    CGFloat tableViewY=64+naviScrollHeight+35;
    CGFloat tableViewWidth=WIDTH;
    CGFloat tableViewHeight=HEIGHT-64-naviScrollHeight*2-49;
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, tableViewWidth, tableViewHeight) style:UITableViewStylePlain];
    
    _tableView.backgroundColor=[UIColor blackColor];
    
    //设置代理数据源
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    //==============创建表头===============
    [self creatLabelBar];
    
}

#pragma mark - 创建表头
- (void)creatLabelBar{
    
    CGFloat labelBarY=99;
    CGFloat labelBarHeight=35                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ;
    
    //创建标签条
    UIView *labelBarView=[[UIView alloc] initWithFrame:CGRectMake(0, labelBarY, WIDTH, labelBarHeight)];
    
    labelBarView.backgroundColor=[UIColor lightGrayColor];
    
    [self.view addSubview:labelBarView];
    
    //创建标签
    //品种标签
    CGFloat labelWidth=100;
    UILabel *labelKind=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, labelWidth, labelBarHeight)];
    labelKind.text=@"品种";
    labelKind.textColor=[UIColor whiteColor];
    [labelBarView addSubview:labelKind];

    //最新标签
    UILabel *labelNew=[[UILabel alloc] initWithFrame:CGRectMake(170, 0, labelWidth, labelBarHeight)];
    labelNew.text=@"最新";
    labelNew.textColor=[UIColor whiteColor];
    [labelBarView addSubview:labelNew];
    
}

#pragma mark - tableView代理方法
//设置tableView的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tradeArray.count;
}

//创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iden=@"iden";
    
    MarketTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell==nil) {
        cell=[[MarketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    //获取对应cell的模型
    symbolModel *model=_tradeArray[indexPath.row];
    
    //传入模型给标签赋值
    cell.model=model;
    
    return cell;
    
}

#pragma mark - 从网络获取数据，导入模型
- (void)downLoadData{
    
    URLModel *model=[[URLModel alloc] initModel];
    
    NSURL *url=[NSURL URLWithString:[model valueForKey:_portfolioName]];
    
    //创建请求
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    //创建会话模式
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建会话
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    
    //创建任务
    NSURLSessionTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSArray *dataArrayTmp=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //清空以前所有数组数据
        [self.tradeArray removeAllObjects];
        
        for (int i=0; i<dataArrayTmp.count; i++) {
            NSDictionary *dictTmp=dataArrayTmp[i];
            
            symbolModel *model=[[symbolModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dictTmp];
            
            [self.tradeArray addObject:model];
            
        }
        
        //刷新数据(回到主线程)
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }];
    
    //任务开始
    [task resume];
    
    
}

#pragma mark - 懒加载
- (NSMutableArray *)tradeArray{
    
    if (_tradeArray==nil) {
        _tradeArray=[NSMutableArray array];
    }
    return _tradeArray;
}

#pragma mark - 刷新
- (void)refresh{
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(downLoadData) userInfo:nil repeats:YES];
    
    [timer fire];
}

@end
