//
//  NewsTableViewCell.m
//  EastMoney
//
//  Created by 万晓 on 16/5/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "newsModel.h"
#import "UIImageView+WebCache.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface NewsTableViewCell()

//新闻图片框
@property (strong, nonatomic) UIImageView *newsImageView;

//新闻标题
@property (strong, nonatomic) UILabel *newsLabel;

//发布时间
@property (strong, nonatomic) UILabel *timeLable;

@end

@implementation NewsTableViewCell

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _newsImageView=[[UIImageView alloc] init];
        [self.contentView addSubview:_newsImageView];
        
        _newsLabel=[[UILabel alloc] init];
        [self.contentView addSubview:_newsLabel];

        
    }
    
        return self;
    
}

#pragma mark - 布局子控件
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self creatUI];
    
}

#pragma mark - 创建cellUI
- (void)creatUI{
    
    //新闻图片框
    CGFloat margin=10;
    
    CGFloat imageX=margin;
    CGFloat imageY=margin;
    CGFloat imageWidth=110;
    CGFloat imageHeight=imageWidth;
    
    _newsImageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    
    //新闻标题框
    CGFloat newsLabelX=imageX+imageWidth+margin * 2;
    CGFloat newsLabelY=0;
    CGFloat newsLabelWidth=WIDTH-newsLabelX-margin;
    CGFloat newsLabelHeight=imageHeight * 2 / 3;
    
    _newsLabel.frame = CGRectMake(newsLabelX, newsLabelY, newsLabelWidth, newsLabelHeight);
    _newsLabel.textColor=[UIColor blackColor];
    
    //让label多行显示文字
    _newsLabel.numberOfLines=0;
    
}

#pragma mark - 从网络获取数据
//- (void)loadDataWithModel:(newsModel *)model{
//    
//    //显示新闻标题
//    [_newsLabel setText:model.title];
//    
//    //下载图片()
//    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:model.picture]];
//}

- (void)setModel:(newsModel *)model {
    
    _model = model;
    
    [_newsLabel setText:model.title];
    
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:model.picture]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
