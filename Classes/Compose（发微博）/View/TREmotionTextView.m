//
//  TREmotionTextView.m
//  露露微博
//
//  Created by lushuishasha on 15/10/9.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionTextView.h"
#import "NSString+Emoji.h"
#import "TREmotion.h"
#import "UITextView+Extension.h"
#import "TREmotionAttachment.h"

@implementation TREmotionTextView
- (void)insertEmotion:(TREmotion *)emotion {
    if (emotion.code) {
        // insertText : 将文字插入到光标所在的位置
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        //加载图片
        TREmotionAttachment *attach = [[TREmotionAttachment alloc]init];
        
        //传递模型
        attach.emotion = emotion;
        //attach.image = [UIImage imageNamed:emotion.png];
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        //根据附件创建属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        //插入属性文字到光标位置
        [self insertAttributeText:imageStr];
    }
}

- (NSString *)fullString{
    
    NSMutableString *fullText = [NSMutableString string];
    
    //遍历所有的属性文字并将不同类型的属性文字分段截取
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary * attrs, NSRange range, BOOL * stop) {
       TREmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {//是图片
            [fullText appendString:attach.emotion.chs];
        }else{  //emoji，普通的文本
            //取出textViw中所有的属性文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    return fullText;
}
@end
