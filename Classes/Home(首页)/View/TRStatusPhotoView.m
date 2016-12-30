//
//  TRStatusPhotoView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/22.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
@interface TRStatusPhotoView()
@property (nonatomic, weak) UIImageView *giftView;
@end

@implementation TRStatusPhotoView
- (UIImageView *)giftView {
    if (!_giftView) {
        UIImageView *giftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:giftView];
        self.giftView = giftView;
    }
    return _giftView;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出imageView的部分剪切掉
        self.clipsToBounds = YES;
        
    }
   
    
//    UIViewContentModeScaleToFill        图片拉伸至整个imageView(可能会变形)
//    UIViewContentModeScaleAspectFit     将图片拉伸完全显示在imageView里面为止（图片不会被拉伸）
//    UIViewContentModeScaleAspectFill    将图片拉伸至宽度或者高度等于uiimageView的宽度或者高度为止（图片不会被拉伸，但是可能会超出imageView的范围，要跟self.clipsToBounds = YES配合使用）
//    UIViewContentModeRedraw,              调用了setNeedsDisplay方法时，就会将图片重新渲染
//    UIViewContentModeCenter,              居中显示
//    UIViewContentModeTop,
//    UIViewContentModeBottom,
//    UIViewContentModeLeft,
//    UIViewContentModeRight,
//    UIViewContentModeTopLeft,
//    UIViewContentModeTopRight,
//    UIViewContentModeBottomLeft,
//    UIViewContentModeBottomRight,

  //经验规律：凡是带有Scale单词的，图片都会被拉伸
  //凡是带有Aspect单词的，图片都会保持原来的宽高比，图片不会变形
    
    return self;
    
}




- (void)setPhoto:(TRPhoto *)photo {
    
    _photo = photo;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic]placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //如果后缀不是git的图片就隐藏
    self.giftView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}


- (void) layoutSubviews {
    [super layoutSubviews];
    self.giftView.x = self.width - self.giftView.width;
    self.giftView.y = self.height - self.giftView.height;
    
}
@end
