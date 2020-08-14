//
//  FLYClipsLineView.m
//  wangge
//
//  Created by fly on 2020/8/10.
//  Copyright © 2020 fly. All rights reserved.
//

#import "FLYClipsLineView.h"
#import "Masonry.h"

@interface FLYClipsLineView ()

//四个角
@property (nonatomic, strong) UIView * topLeftHorLineView;
@property (nonatomic, strong) UIView * topLeftVerLineView;
@property (nonatomic, strong) UIView * topRightHorLineView;
@property (nonatomic, strong) UIView * topRightVerLineView;
@property (nonatomic, strong) UIView * bottomLeftHorLineView;
@property (nonatomic, strong) UIView * bottomLeftVerLineView;
@property (nonatomic, strong) UIView * bottomRightHorLineView;
@property (nonatomic, strong) UIView * bottomRightVerLineView;

@end

@implementation FLYClipsLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    [[UIColor colorWithWhite:1 alpha:0.7] setFill];

    //绘制竖线1
    CGRect verticalLine1Rect = CGRectMake(rect.size.width / 3.0, 0, 1, rect.size.height);
    UIRectFill(verticalLine1Rect);

    //绘制竖线2
    CGRect verticalLine2Rect = CGRectMake(rect.size.width / 3.0 * 2, 0, 1, rect.size.height);
    UIRectFill(verticalLine2Rect);

    //绘制横线1
    CGRect horizontalLine1Rect = CGRectMake(0, rect.size.height / 3.0, rect.size.width, 1);
    UIRectFill(horizontalLine1Rect);

    //绘制横线2
    CGRect horizontalLine2Rect = CGRectMake(0, rect.size.height / 3.0 * 2, rect.size.width, 1);
    UIRectFill(horizontalLine2Rect);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self.topLeftHorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(-2);
        make.left.equalTo(self).with.offset(-2);
        make.size.mas_equalTo(CGSizeMake(20, 4));
    }];
    
    [self.topLeftVerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(-2);
        make.left.equalTo(self).with.offset(-2);
        make.size.mas_equalTo(CGSizeMake(4, 20));
    }];
    
    [self.topRightHorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(-2);
        make.right.equalTo(self).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(20, 4));
    }];
    
    [self.topRightVerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(-2);
        make.right.equalTo(self).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(4, 20));
    }];
    
    [self.bottomLeftHorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(-2);
        make.bottom.equalTo(self).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(20, 4));
    }];
    
    [self.bottomLeftVerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(-2);
        make.bottom.equalTo(self).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(4, 20));
    }];
    
    [self.bottomRightHorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(2);
        make.bottom.equalTo(self).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(20, 4));
    }];
    
    [self.bottomRightVerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(2);
        make.bottom.equalTo(self).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(4, 20));
    }];
}



#pragma mark - UI

- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    self.layer.borderWidth = 2;
    
    [self addSubview:self.topLeftHorLineView];
    [self addSubview:self.topLeftVerLineView];
    [self addSubview:self.topRightHorLineView];
    [self addSubview:self.topRightVerLineView];
    [self addSubview:self.bottomLeftHorLineView];
    [self addSubview:self.bottomLeftVerLineView];
    [self addSubview:self.bottomRightHorLineView];
    [self addSubview:self.bottomRightVerLineView];
}



#pragma mark - setters and getters

- (UIView *)topLeftHorLineView
{
    if( _topLeftHorLineView == nil )
    {
        _topLeftHorLineView = [[UIView alloc] init];
        _topLeftHorLineView.backgroundColor = [UIColor whiteColor];
    }
    return _topLeftHorLineView;
}

- (UIView *)topLeftVerLineView
{
    if( _topLeftVerLineView == nil )
    {
        _topLeftVerLineView = [[UIView alloc] init];
        _topLeftVerLineView.backgroundColor = [UIColor whiteColor];
    }
    return _topLeftVerLineView;
}

- (UIView *)topRightHorLineView
{
    if( _topRightHorLineView == nil )
    {
        _topRightHorLineView = [[UIView alloc] init];
        _topRightHorLineView.backgroundColor = [UIColor whiteColor];
    }
    return _topRightHorLineView;
}

- (UIView *)topRightVerLineView
{
    if( _topRightVerLineView == nil )
    {
        _topRightVerLineView = [[UIView alloc] init];
        _topRightVerLineView.backgroundColor = [UIColor whiteColor];
    }
    return _topRightVerLineView;
}

- (UIView *)bottomLeftHorLineView
{
    if( _bottomLeftHorLineView == nil )
    {
        _bottomLeftHorLineView = [[UIView alloc] init];
        _bottomLeftHorLineView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLeftHorLineView;
}

- (UIView *)bottomLeftVerLineView
{
    if( _bottomLeftVerLineView == nil )
    {
        _bottomLeftVerLineView = [[UIView alloc] init];
        _bottomLeftVerLineView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomLeftVerLineView;
}

- (UIView *)bottomRightHorLineView
{
    if( _bottomRightHorLineView == nil )
    {
        _bottomRightHorLineView = [[UIView alloc] init];
        _bottomRightHorLineView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomRightHorLineView;
}

- (UIView *)bottomRightVerLineView
{
    if( _bottomRightVerLineView == nil )
    {
        _bottomRightVerLineView = [[UIView alloc] init];
        _bottomRightVerLineView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomRightVerLineView;
}



@end
