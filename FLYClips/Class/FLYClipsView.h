//
//  FLYClipsView.h
//  wangge
//
//  Created by fly on 2020/8/10.
//  Copyright © 2020 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYClipsView : UIView

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSURL * imageUrl;

- (UIImage *)clipsImage;

@end

NS_ASSUME_NONNULL_END
