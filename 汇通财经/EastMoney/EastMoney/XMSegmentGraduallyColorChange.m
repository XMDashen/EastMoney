
#import "XMSegmentGraduallyColorChange.h"

#define BUTTON_TAG 100

typedef void(^XMBlock)(UIButton *);

@interface XMSegmentGraduallyColorChange(){
    
    CGFloat buttonWidth;
    CGFloat buttonHeight;
}

//选中按钮背景
@property(nonatomic,strong) UIView *selectedView;

//文字视图面板
@property(nonatomic,strong) UIView *textView;

//文字标签数组
@property(nonatomic,strong) NSArray *titleArray;

//按钮点击事件
@property(nonatomic,strong) XMBlock clickBlock;

//按钮数组
@property(nonatomic,strong) NSMutableArray *buttonArray;

//标签数组
@property(nonatomic,strong) NSMutableArray *labelArray;

@end

@implementation XMSegmentGraduallyColorChange

#pragma mark - 添加滑块特效
- (instancetype)initWithFrame:(CGRect)frame ButtonWidth:(CGFloat)width buttonHeight:(CGFloat)height titleArray:(NSArray *)titleArray clickEvent:(void(^)(UIButton *button))clickBlock{
    
    if (self=[super init]) {
        
        self.frame=frame;
        
        _titleArray=[NSArray array];
        
        _clickBlock=clickBlock;
    }
    
    _titleArray=titleArray;
    
    //*************添加button***********
    
    //按钮尺寸
     buttonWidth=width;
     buttonHeight=height;
    
    _buttonArray=[NSMutableArray array];
    
    for (int i=0; i<_titleArray.count; i++) {
        
        //按钮类型
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        
        //按钮尺寸
        button.frame=CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight);
        
        //按钮文字
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        
        //按钮点击事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //按钮tag
        button.tag=BUTTON_TAG+i;
        
        //将按钮添加到按钮数组
        [_buttonArray addObject:button];
        
        [self addSubview:button];
    }
    
    //*************添加选中按钮背景特效selectedView***********
    //选中按钮的图片尺寸
    _selectedView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth,buttonHeight)];
    
    //设置圆角
    _selectedView.layer.cornerRadius=5;
    
    _selectedView.clipsToBounds=YES;
    
    [self addSubview:_selectedView];
    
    //************添加文字图层面板textView***********
    _textView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    _selectedView.clipsToBounds=YES;
    

    //************添加选中按钮时显示的标签文字lable***********
    
    _labelArray=[NSMutableArray array];
    
    for (int i=0; i<_titleArray.count; i++) {
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight)];
        
        label.text=_titleArray[i];
        
        label.textAlignment=1;
        
        label.clipsToBounds=YES;
        
        //将标签添加到标签数组
        [_labelArray addObject:label];
        
        [_textView addSubview:label];
        
    }
    
    //将选中文字层添加到选中背景层
    [_selectedView addSubview:_textView];
    
    return self;
}

#pragma mark - 布局子控件
-(void)layoutSubviews{
    
    //背景颜色
    self.backgroundColor=_backgroundColor;

    //选中按钮背景颜色
    _selectedView.backgroundColor=_selectedButtonColor;
    
    for (UIButton *button in _buttonArray) {
        
        //按钮颜色
        [button setBackgroundColor:_buttonColor];
        
        //按钮文字颜色
        [button setTitleColor:_titleColor forState:UIControlStateNormal];
        
        //按钮文字大小
        button.titleLabel.font=[UIFont systemFontOfSize:_fontOfSize];
    }
    
    for (UILabel *label in _labelArray) {
        
        label.textColor=_selectedTitleColor;
        
        label.font=[UIFont boldSystemFontOfSize:_fontOfSize];
    }
    
}

#pragma mark - 监听按钮点击事件
-(void)buttonClick:(UIButton *)button{
    
    //滑块滑动特效
    [UIView animateWithDuration:0.5 animations:^{
        
        //选中面板移动
        _selectedView.frame=CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
        
        //文字视图面板反向移动
        _textView.frame=CGRectMake(-(button.tag-BUTTON_TAG) * buttonWidth, 0, self.bounds.size.width, self.bounds.size.height);
        
    }];
    
    if (!_clickBlock) {
        _clickBlock(button);
    }

    
}



@end
