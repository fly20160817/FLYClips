//
//  ViewController.m
//  FLYClips
//
//  Created by fly on 2020/8/6.
//  Copyright © 2020 fly. All rights reserved.
//

#import "ViewController.h"
#import "FLYClipsView.h"

@interface ViewController ()

@property (nonatomic, strong) FLYClipsView * clipsView;

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIButton * button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.clipsView];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.button];
    
}



#pragma mark - setters and getters

- (void)buttonClick
{
    self.imageView.image = [self.clipsView clipsImage];
}



#pragma mark - setters and getters

-(FLYClipsView *)clipsView
{
    if ( _clipsView == nil )
    {
        _clipsView = [[FLYClipsView alloc] initWithFrame:self.view.bounds];
        _clipsView.image = [UIImage imageNamed:@"fei"];
        //_clipsView.imageUrl = [NSURL URLWithString:@"http://wx-phoenix.oss-cn-hangzhou.aliyuncs.com/20200806/1596695778_4180compression.jpg"];
    }
    return _clipsView;
}

-(UIImageView *)imageView
{
    if ( _imageView == nil )
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.view.bounds;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)button
{
    if( _button == nil )
    {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(100, 20, 100, 50);
        [_button setTitle:@"确认裁剪" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _button.backgroundColor = [UIColor orangeColor];
    }
    return _button;
}



@end
