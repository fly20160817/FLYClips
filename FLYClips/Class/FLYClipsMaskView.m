//
//  FLYClipsMaskView.m
//  wangge
//
//  Created by fly on 2020/8/6.
//  Copyright © 2020 fly. All rights reserved.
//

#import "FLYClipsMaskView.h"
#import "FLYClipsBoxView.h"
#import "UIView+Frame.h"

@interface FLYClipsMaskView ()

/**裁减的框*/
@property (nonatomic, strong) FLYClipsBoxView * boxView;

@end

@implementation FLYClipsMaskView

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
    

    CGRect rectBorder = self.boxView.frame;
    //填充色设置成透明色
    [[UIColor clearColor] setFill];
    //绘制这个Rect
    UIRectFill(rectBorder);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //drawRect:方法是系统自动调用，我们不能直接调用。我们可以调用setNeedsDisplay，调用setNeedsDisplay会自动调用drawRect:
    [self setNeedsDisplay];
}


#pragma mark - UI

- (void)initUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    [self addSubview:self.boxView];
}



#pragma mark - public methods

-(void)addBox:(CGRect)rect
{
    self.boxView.frame = rect;
}


#pragma mark - setters and getters

-(CGRect)currentBoxRect
{
    return self.boxView.frame;;
}

-(FLYClipsBoxView *)boxView
{
    if ( _boxView == nil )
    {
        _boxView = [[FLYClipsBoxView alloc] init];
    }
    return _boxView;
}

@end
