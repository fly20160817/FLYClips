//
//  FLYClipsView.m
//  wangge
//
//  Created by fly on 2020/8/10.
//  Copyright © 2020 fly. All rights reserved.
//

#import "FLYClipsView.h"
#import "FLYClipsMaskView.h"
#import "Masonry.h"

#define k_Margin 40

@interface FLYClipsView ()

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) FLYClipsMaskView * clipsMaskView;

@end

@implementation FLYClipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(k_Margin);
        make.left.equalTo(self).with.offset(k_Margin);
        make.bottom.equalTo(self).with.offset(-k_Margin);
        make.right.equalTo(self).with.offset(-k_Margin);
    }];
    
    [self.clipsMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(k_Margin);
        make.left.equalTo(self).with.offset(k_Margin);
        make.bottom.equalTo(self).with.offset(-k_Margin);
        make.right.equalTo(self).with.offset(-k_Margin);
    }];
    
    
    //给裁剪框设置范围大小
    CGRect rect = [self getImageFrameForImageView];
    [self.clipsMaskView addBox:rect];
}



#pragma mark - UI

- (void)initUI
{
    self.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.imageView];
    [self addSubview:self.clipsMaskView];
}



#pragma mark - public methods

- (UIImage *)clipsImage
{
    /**
    原始的裁剪框 : 现在的裁剪框 = 原始的图片 : 裁剪后的图片
    
    我们不能直接用 裁剪框的frame 对 图片 进行裁剪，
    因为裁剪框的frame是按照屏幕算的，而image的大小可能比屏幕还大，
    拿屏幕上的frame当参数去裁剪图片，实际裁剪的部分会比实际的小，
    所以要用比例计算出需要裁剪的rect。
    */
    
    
    
    //获取裁剪框初始的frame
    CGRect originalBoxRect = [self getImageFrameForImageView];
    //获取裁剪框现在的frame
    CGRect nowBoxRect = self.clipsMaskView.currentBoxRect;
    //减去多余的x、y值  (让现在frame的x、y值，以初始frame的x、y值为原点来计算新值)
    nowBoxRect.origin.x -= originalBoxRect.origin.x;
    nowBoxRect.origin.y -= originalBoxRect.origin.y;
    
    
    //计算 现在frame的x、y、width、height 占 初始frame的比例
    CGFloat xRatio = nowBoxRect.origin.x / originalBoxRect.size.width;
    CGFloat yRatio = nowBoxRect.origin.y / originalBoxRect.size.height;
    CGFloat wRatio = nowBoxRect.size.width / originalBoxRect.size.width;
    CGFloat hRatio = nowBoxRect.size.height / originalBoxRect.size.height;
    
    
    //用比例计算需要裁剪image的rect (裁剪框现在的frame 换算成 image 上的 frame)
    CGFloat x = xRatio * self.imageView.image.size.width;
    CGFloat y = yRatio * self.imageView.image.size.height;
    CGFloat w = wRatio * self.imageView.image.size.width;
    CGFloat h = hRatio * self.imageView.image.size.height;
    CGRect clipsRect = CGRectMake(x, y, w, h);
    
    
    //根据 clipsRect 从 image 裁剪出新图片
    CGImageRef sourceImageRef = [self.imageView.image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, clipsRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];

    return newImage;
}



#pragma mark - private methods

//获取image在imageView中的frame
-(CGRect)getImageFrameForImageView
{
    UIImage * image = self.imageView.image;
    UIImageView * imageView = self.imageView;
    
    if ( !image )
    {
        return CGRectZero;
    }
    
    float hfactor = image.size.width / imageView.frame.size.width;
    float vfactor = image.size.height / imageView.frame.size.height;
    
    float factor = fmax(hfactor, vfactor);
    
    float newWidth = image.size.width / factor;
    float newHeight = image.size.height / factor;
    
    float leftOffset = (imageView.frame.size.width - newWidth) / 2;
    float topOffset = (imageView.frame.size.height - newHeight) / 2;
    
    return CGRectMake(leftOffset, topOffset, newWidth, newHeight);
}



#pragma mark - setters and getters

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

-(void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;
    
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
}

-(UIImageView *)imageView
{
    if ( _imageView == nil )
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

-(FLYClipsMaskView *)clipsMaskView
{
    if ( _clipsMaskView == nil )
    {
        _clipsMaskView = [[FLYClipsMaskView alloc] init];
    }
    return _clipsMaskView;
}

@end
