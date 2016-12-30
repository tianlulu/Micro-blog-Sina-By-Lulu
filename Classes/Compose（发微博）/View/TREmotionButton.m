//
//  TREmotionButton.m
//  露露微博
//
//  Created by lushuishasha on 15/9/29.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionButton.h"
#import "TREmotion.h"
#import "NSString+Emoji.h"

@implementation TREmotionButton
//当文件不是从xib，storyboard创建时候，就会调用这个方法
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}



//当文件是从xib，storyboard中创建时，就会调用这个方法
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

//避免长按时按钮出现灰色的
//- (void)setHighlighted:(BOOL)highlighted {
//    
//}


- (void)setup {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    
    //按钮高亮的时候，不要去调整图片（不要调整图片为灰色）
    self.adjustsImageWhenHighlighted = NO;
}

//这个方法会在initWithCoder方法后面调用
- (void)awakeFromNib {
    
}


//所有的表情按钮的显示
- (void)setEmotion:(TREmotion *)emotion {
        _emotion = emotion;
            if (emotion.png) {
                [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
            }else if (emotion.code) {
                //是emoji表情
                [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}
@end
