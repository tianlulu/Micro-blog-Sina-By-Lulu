//
//  TREmotionAttachment.m
//  露露微博
//
//  Created by lushuishasha on 15/10/12.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionAttachment.h"
#import "TREmotion.h"

@implementation TREmotionAttachment
- (void)setEmotion:(TREmotion *)emotion {
    
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
    
}

@end
