//
//  MarketTableViewCell.m
//  EastMoney
//
//  Created by 千锋 on 16/6/2.
//  Copyright (c) 2016年 1000phone. All rights reserved.
//

#import "MarketTableViewCell.h"
#import "symbolModel.h"

@interface MarketTableViewCell()

//品种标签
@property(nonatomic,strong) UILabel *kindLabel;

//价格标签
@property(nonatomic,strong) UILabel *priceLabel;

//多功能标签
@property(nonatomic,strong) UILabel *mutiLabel;

//闪烁色
@property(nonatomic,strong) UIColor *currentColor;
@end

@implementation MarketTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //创建界面UI
        [self creatUI];
        
    }
    return self;
}

#pragma mark - 创建界面UI
- (void)creatUI{
    
    self.contentView.backgroundColor=[UIColor blackColor];
    
    //标签尺寸
    float margin=10;
    float labelY=margin;
    float labelWidth=[UIScreen mainScreen].bounds.size.width/3.0;
    float labelHeight=self.bounds.size.height-2*margin;
    
    //品种标签
    _kindLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, labelY, labelWidth, labelHeight)];
    _kindLabel.textColor=[UIColor whiteColor];
    _kindLabel.textAlignment=NSTextAlignmentLeft;
    _kindLabel.font=[UIFont boldSystemFontOfSize:20];
    
    [self.contentView addSubview:_kindLabel];
    
    //价格标签
    _priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(labelWidth, labelY, labelWidth, labelHeight)];
    _priceLabel.textColor=[UIColor whiteColor];
    _priceLabel.textAlignment=1;
    _priceLabel.font=[UIFont boldSystemFontOfSize:20];
    //倒圆角
    _priceLabel.clipsToBounds=YES;
    _priceLabel.layer.cornerRadius=5;
    
    [self.contentView addSubview:_priceLabel];
    
    //多功能标签
    _mutiLabel=[[UILabel alloc] initWithFrame:CGRectMake(2*labelWidth, labelY, labelWidth, labelHeight)];
    _mutiLabel.textColor=[UIColor whiteColor];
    _mutiLabel.textAlignment=NSTextAlignmentRight;
    _mutiLabel.font=[UIFont boldSystemFontOfSize:20];
    
    [self.contentView addSubview:_mutiLabel];
    
    
}

-(void)setModel:(symbolModel *)model{
    
    //懒加载创建
    if (_model==nil) {
        _model=[[symbolModel alloc] init];
    }
    
    _model=model;
    
    //价格价格颜色判断
    //当前价格颜色
    if (model.Buy>=model.Open) {
        _currentColor=[UIColor redColor];
    }else{
        _currentColor=[UIColor greenColor];
    }
    
    //多功能标签价格颜色
    if (model.High>=model.Open) {
        _mutiLabel.textColor=[UIColor redColor];
    }else{
        _mutiLabel.textColor=[UIColor greenColor];
    }
    
    //标签赋值
    _kindLabel.text=model.Name;
    _priceLabel.text=[NSString stringWithFormat:@"%.2f",model.Buy];
    _mutiLabel.text=[NSString stringWithFormat:@"%.2f",model.High];
    
    
    
    //价格标签颜色闪烁
    _priceLabel.backgroundColor=_currentColor;
    //价格标签文字变成白色
    _priceLabel.textColor=[UIColor whiteColor];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(flashFlagColor) userInfo:nil repeats:NO];
    
}

#pragma mark - 价格标签颜色闪烁
- (void)flashFlagColor{
    
    //价格标签颜色变为黑色
    _priceLabel.backgroundColor=[UIColor blackColor];
    //价格标签文字变为闪烁色
    _priceLabel.textColor=_currentColor;
    
}
@end
