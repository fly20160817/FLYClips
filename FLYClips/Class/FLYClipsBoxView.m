//
//  FLYClipsBoxView.m
//  wangge
//
//  Created by fly on 2020/8/6.
//  Copyright © 2020 fly. All rights reserved.
//

#import "FLYClipsBoxView.h"
#import "FLYClipsLineView.h"
#import "Masonry.h"
#import "UIView+Frame.h"

#define k_GestureWidth 50 //手势区域的宽度

@interface FLYClipsBoxView ()
{
    CGRect _originalFrame;
    CGSize _minSize;
}
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * rightView;

@property (nonatomic, strong) UIView * topLeftView;
@property (nonatomic, strong) UIView * topRightView;
@property (nonatomic, strong) UIView * bottomLeftView;
@property (nonatomic, strong) UIView * bottomRightView;

@property (nonatomic, strong) FLYClipsLineView * lineView;

@end

@implementation FLYClipsBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:pan];
      
        [self initUI];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    // frame 不等于 Zero，并且 _originalFrame 等于空，说明是第一次给frame赋值，我们记录下来
    if ( !CGRectEqualToRect(frame, CGRectZero) && CGRectEqualToRect(_originalFrame, CGRectZero) )
    {
        _originalFrame = frame;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self).with.offset(0);
    }];
    
    
    
    CGFloat spacing = k_GestureWidth / 2.0;
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(-spacing);
        make.left.equalTo(self).with.offset(spacing);
        make.right.equalTo(self).with.offset(-spacing);
        make.height.mas_equalTo(k_GestureWidth);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(spacing);
        make.left.equalTo(self).with.offset(-spacing);
        make.bottom.equalTo(self).with.offset(-spacing);
        make.width.mas_equalTo(k_GestureWidth);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(spacing);
        make.right.equalTo(self).with.offset(-spacing);
        make.bottom.equalTo(self).with.offset(spacing);
        make.height.mas_equalTo(k_GestureWidth);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(spacing);
        make.right.equalTo(self).with.offset(spacing);
        make.bottom.equalTo(self).with.offset(-spacing);
        make.width.mas_equalTo(k_GestureWidth);
    }];
    
    [self.topLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(-spacing);
        make.left.equalTo(self).with.offset(-spacing);
        make.right.equalTo(self.topView.mas_left);
        make.bottom.equalTo(self.leftView.mas_top);
    }];
    
    [self.topRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(-spacing);
        make.right.equalTo(self).with.offset(spacing);
        make.left.equalTo(self.topView.mas_right);
        make.bottom.equalTo(self.rightView.mas_top);
    }];
    
    [self.bottomLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftView.mas_bottom);
        make.left.equalTo(self).with.offset(-spacing);
        make.bottom.equalTo(self).with.offset(spacing);
        make.right.equalTo(self.bottomView.mas_left);
    }];
    
    [self.bottomRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightView.mas_bottom);
        make.right.equalTo(self).with.offset(spacing);
        make.bottom.equalTo(self).with.offset(spacing);
        make.left.equalTo(self.bottomView.mas_right);
    }];
}

//处理超出区域点击无效的问题 (添加拖动手势的view，一半在父视图里边一半在外面，因为要保证边缘附近都能响应手势)
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //转换坐标
    CGPoint topPoint = [self.topView convertPoint:point fromView:self];
    CGPoint leftPoint = [self.leftView convertPoint:point fromView:self];
    CGPoint bottomPoint = [self.bottomView convertPoint:point fromView:self];
    CGPoint rightPoint = [self.rightView convertPoint:point fromView:self];
    CGPoint topLeftPoint = [self.topLeftView convertPoint:point fromView:self];
    CGPoint topRightPoint = [self.topRightView convertPoint:point fromView:self];
    CGPoint bottomLeftPoint = [self.bottomLeftView convertPoint:point fromView:self];
    CGPoint bottomRightPoint = [self.bottomRightView convertPoint:point fromView:self];
    
    //判断点击的点是否在按钮区域内
    if (CGRectContainsPoint(self.topView.bounds, topPoint))
    {
        //返回view
        return self.topView;
    }
    else if (CGRectContainsPoint(self.leftView.bounds, leftPoint))
    {
        return self.leftView;
    }
    else if (CGRectContainsPoint(self.bottomView.bounds, bottomPoint))
    {
        return self.bottomView;
    }
    else if (CGRectContainsPoint(self.rightView.bounds, rightPoint))
    {
        return self.rightView;
    }
    else if (CGRectContainsPoint(self.topLeftView.bounds, topLeftPoint))
    {
        return self.topLeftView;
    }
    else if (CGRectContainsPoint(self.topRightView.bounds, topRightPoint))
    {
        return self.topRightView;
    }
    else if (CGRectContainsPoint(self.bottomLeftView.bounds, bottomLeftPoint))
    {
        return self.bottomLeftView;
    }
    else if (CGRectContainsPoint(self.bottomRightView.bounds, bottomRightPoint))
    {
        return self.bottomRightView;
    }
    else
    {
        return [super hitTest:point withEvent:event];
    }
}



#pragma mark - UI

- (void)initUI
{
    _minSize = CGSizeMake(54, 54);
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.lineView];
    
    [self addSubview:self.topView];
    [self addSubview:self.leftView];
    [self addSubview:self.bottomView];
    [self addSubview:self.rightView];
    [self addSubview:self.topLeftView];
    [self addSubview:self.topRightView];
    [self addSubview:self.bottomLeftView];
    [self addSubview:self.bottomRightView];
}



#pragma mark - event handler

/******************** 实现思路 ********************
        
 外界初始化时，设置的frame就是最大的范围，放大、拖动操作也必须在这个范围内。
 
 判断是否超出范围：
 把范围看成一个大矩形，我们在大矩形里面拖动放大的是一个小矩形，
 判断小矩形是否超出大矩形的范围，只需要判断小矩形的任意两个对角，是否在大矩形相对应的两个对角内。
 
 比如判断 右上角 和 左下角，小矩形右上角的x轴可移动范围是 (大矩形的宽 - 小矩形的宽)，y轴的可移动范围是 (大矩形的高 - 小矩形的高)，超出这个范围说明就超出返回了，同理再把左下角判断一下，就可以确保这个小矩形在大矩形内。
 
*************************************************/

//拖动事件
- (void)panGestureAction:(UIPanGestureRecognizer *)pan
{
    //获取拖动中的偏移量 （pan.view获取拖动的view）
    CGPoint point = [pan translationInView:pan.view];
    
    if ( pan.view == self )
    {
        //移动
        self.transform = CGAffineTransformTranslate(self.transform, point.x, point.y);
        
        //让父视图绘制遮罩
        [self.superview setNeedsLayout];
        [self.superview layoutIfNeeded];
        
        
        //如果超出范围，则设置为极值
        if ( self.x <= _originalFrame.origin.x )
        {
            self.x = _originalFrame.origin.x;
        }
        else if ( self.x >= _originalFrame.size.width - self.width )
        {
            self.x = _originalFrame.size.width - self.width;
        }
        
        if ( self.y <= _originalFrame.origin.y )
        {
            self.y = _originalFrame.origin.y;
        }
        else if ( self.y >= _originalFrame.origin.y + (_originalFrame.size.height - self.height) )
        {
            self.y = _originalFrame.origin.y + (_originalFrame.size.height - self.height);
        }
        
    }
    else if ( pan.view == self.topView )
    {
        [self topViewPanGesture:point];
        
    }
    else if ( pan.view == self.leftView )
    {
        [self leftViewPanGesture:point];
    }
    else if ( pan.view == self.bottomView )
    {
        [self bottomViewPanGesture:point];
    }
    else if ( pan.view == self.rightView )
    {
        [self rightViewPanGesture:point];
    }
    else if ( pan.view == self.topLeftView )
    {
        [self topLeftViewPanGesture:point];
    }
    else if ( pan.view == self.topRightView )
    {
        [self topRightViewPanGesture:point];
    }
    else if ( pan.view == self.bottomLeftView )
    {
        [self bottomLeftViewPanGesture:point];
    }
    else if ( pan.view == self.bottomRightView )
    {
        [self bottomRightViewPanGesture:point];
    }
    
    
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
}



#pragma mark - public methods

- (void)topViewPanGesture:(CGPoint)point
{
    //往上拖变高，超出y轴的最小范围，就把它放设置成最小的y值
    if ( self.y + point.y <= _originalFrame.origin.y )
    {
        self.height = self.height + (self.y - _originalFrame.origin.y);
        self.y = _originalFrame.origin.y;
    }
    //往下拖变矮，如果高度大于最小值，就变矮，否则不变
    else
    {
        CGFloat height = self.height - point.y;
        if ( height >= _minSize.height )
        {
            self.y += point.y;
            self.height = height;
        }
    }
}

- (void)leftViewPanGesture:(CGPoint)point
{
    //往左拖变宽，超出x轴的最小范围，就把它放设置成最小的x值
    if ( self.x + point.x <= _originalFrame.origin.x )
    {
        self.width = self.width + (self.x - _originalFrame.origin.x);
        self.x = _originalFrame.origin.x;
    }
    //往右拖变窄，如果宽度大于最小值，就变窄，否则不变
    else
    {
        CGFloat width = self.width - point.x;
        if ( width >= _minSize.width )
        {
            self.width = width;
            
            self.x += point.x;
        }
    }
}

- (void)bottomViewPanGesture:(CGPoint)point
{
    //往下拖的最大值
    CGFloat maxY = _originalFrame.origin.y + _originalFrame.size.height;
    //当前底部y轴的值
    CGFloat currentY = self.y + (self.height + point.y);
    
    //往下拖变高，超出最大值，则把高设置成最大
    if ( currentY >= maxY )
    {
        self.height = maxY - self.y;
    }
    //往下拖变矮，如果高度大于最小值，就变矮，否则不变
    else
    {
        CGFloat height = self.height + point.y;
        if ( height >= _minSize.height )
        {
            self.height = height;
        }
    }
}

- (void)rightViewPanGesture:(CGPoint)point
{
    //往右拖的最大值
    CGFloat maxX = _originalFrame.origin.x + _originalFrame.size.width;
    //当前右部x轴的值
    CGFloat currentX = self.x + (self.width + point.x);
    
    //往右拖变宽，超出最大值，则把宽度设置成最大
    if ( currentX >= maxX )
    {
        self.width = maxX - self.x;
    }
    //往左拖变窄，如果宽度大于最小值，就变窄，否则不变
    else
    {
        CGFloat width = self.width + point.x;
        if ( width >= _minSize.width )
        {
            self.width = width;
        }
    }
}

- (void)topLeftViewPanGesture:(CGPoint)point
{
    [self topViewPanGesture:point];
    [self leftViewPanGesture:point];
}

- (void)topRightViewPanGesture:(CGPoint)point
{
    [self topViewPanGesture:point];
    [self rightViewPanGesture:point];
}

- (void)bottomLeftViewPanGesture:(CGPoint)point
{
    [self bottomViewPanGesture:point];
    [self leftViewPanGesture:point];
}

- (void)bottomRightViewPanGesture:(CGPoint)point
{
    [self bottomViewPanGesture:point];
    [self rightViewPanGesture:point];
}



#pragma mark - setters and getters

-(UIView *)topView
{
    if ( _topView == nil )
    {
        _topView = [[UIView alloc] init];
        //_topView.backgroundColor = [UIColor blueColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_topView addGestureRecognizer:pan];
    }
    return _topView;
}

- (UIView *)leftView
{
    if( _leftView == nil )
    {
        _leftView = [[UIView alloc] init];
        //_leftView.backgroundColor = [UIColor blueColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_leftView addGestureRecognizer:pan];
    }
    return _leftView;
}

- (UIView *)bottomView
{
    if( _bottomView == nil )
    {
        _bottomView = [[UIView alloc] init];
        //_bottomView.backgroundColor = [UIColor blueColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_bottomView addGestureRecognizer:pan];
    }
    return _bottomView;
}

- (UIView *)rightView
{
    if( _rightView == nil )
    {
        _rightView = [[UIView alloc] init];
        //_rightView.backgroundColor = [UIColor blueColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_rightView addGestureRecognizer:pan];
    }
    return _rightView;
}

- (UIView *)topLeftView
{
    if( _topLeftView == nil )
    {
        _topLeftView = [[UIView alloc] init];
        //_topLeftView.backgroundColor = [UIColor yellowColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_topLeftView addGestureRecognizer:pan];
    }
    return _topLeftView;
}

- (UIView *)topRightView
{
    if( _topRightView == nil )
    {
        _topRightView = [[UIView alloc] init];
        //_topRightView.backgroundColor = [UIColor yellowColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_topRightView addGestureRecognizer:pan];
    }
    return _topRightView;
}

- (UIView *)bottomLeftView
{
    if( _bottomLeftView == nil )
    {
        _bottomLeftView = [[UIView alloc] init];
        //_bottomLeftView.backgroundColor = [UIColor yellowColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_bottomLeftView addGestureRecognizer:pan];
    }
    return _bottomLeftView;
}

- (UIView *)bottomRightView
{
    if( _bottomRightView == nil )
    {
        _bottomRightView = [[UIView alloc] init];
        //_bottomRightView.backgroundColor = [UIColor yellowColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        pan.maximumNumberOfTouches = 1;
        [_bottomRightView addGestureRecognizer:pan];
    }
    return _bottomRightView;
}

-(FLYClipsLineView *)lineView
{
    if ( _lineView == nil )
    {
        _lineView = [[FLYClipsLineView alloc] init];
    }
    return _lineView;
}

@end
