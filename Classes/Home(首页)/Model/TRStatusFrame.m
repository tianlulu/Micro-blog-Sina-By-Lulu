//
//  TRStatusFrame.m
//  露露微博
//
//  Created by lushuishasha on 15/8/18.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRStatusFrame.h"
#import "TRUser.h"
#import "TRStatus.h"
#import "NSString+Extension.h"
#import "TRStatusPhotosView.h"

@implementation TRStatusFrame
- (void)setStatus:(TRStatus *)status {
    _status = status;
    TRUser *user = status.user;
    
   //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //设置头像
    CGFloat iconWH = 35;
    CGFloat iconX = TRStarusCellBorderw;
    CGFloat iconY = TRStarusCellBorderw;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + TRStarusCellBorderw;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:TRStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    //会员图标
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + TRStarusCellBorderw;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipH, vipW);
    }
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + TRStarusCellBorderw;
    CGSize timeSize = [status.created_at sizeWithFont:TRStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + TRStarusCellBorderw;
    CGFloat sourcrY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:TRStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourcrY},sourceSize};
    
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY =MAX(CGRectGetMaxY(self.timeLabelF), CGRectGetMaxY(self.iconViewF)) + TRStarusCellBorderw ;
    CGFloat maxW = cellW - 2* TRStarusCellBorderw;
    CGSize contentSize = [status.text sizeWithfont:TRStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    
    //配图
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + TRStarusCellBorderw;
        CGSize photosSize = [TRStatusPhotosView sizeWithCount:(int)status.pic_urls.count];
        self.photosViewfF = (CGRect){{photoX,photoY},photosSize};
        originalH = CGRectGetMaxY(self.photosViewfF) + TRStarusCellBorderw;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelF) + TRStarusCellBorderw;
    }
    
    CGFloat orginalX = 0;
    CGFloat originalY = TRStatusCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(orginalX, originalY, originalW, originalH);
    
    

    CGFloat toolBarY = 0;
    //被转发微博
    if (status.retweeted_status) {
        TRStatus *retweet_status = status.retweeted_status;
         TRUser *retweeted_status_user = retweet_status.user;
        
        CGFloat retweetContentX = TRStarusCellBorderw;
        CGFloat retweetContentY = TRStarusCellBorderw;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweet_status.text];
        CGSize retweetContentSize = [retweetContent sizeWithfont:TRStatusCellContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        //被转发微博配图
        CGFloat retweetH = 0;
        if (retweet_status.pic_urls.count) {
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + TRStarusCellBorderw;
            CGSize retweetPhotosSize = [TRStatusPhotosView sizeWithCount:(int)retweet_status.pic_urls.count];
            self.retweetPhotoViewF = (CGRect){{retweetPhotoX,retweetPhotoY},retweetPhotosSize};
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + TRStarusCellBorderw;
        } else {
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + TRStarusCellBorderw;
        }
    
    //被转发微博整体
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
    CGFloat retweetW = cellW;
    self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        toolBarY = CGRectGetMaxY(self.retweetViewF);
    }else {
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    //工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW= cellW;
    CGFloat toolBarH= 35;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    self.cellHeight = CGRectGetMaxY(self.toolBarF) + TRStatusCellMargin;
}
@end
