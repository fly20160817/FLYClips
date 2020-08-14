//
//  FLYClipsMaskView.h
//  wangge
//
//  Created by fly on 2020/8/6.
//  Copyright © 2020 fly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYClipsMaskView : UIView

/**裁剪框当前的frame*/
@property (nonatomic, assign, readonly) CGRect currentBoxRect;

/**添加裁剪框*/
- (void)addBox:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
