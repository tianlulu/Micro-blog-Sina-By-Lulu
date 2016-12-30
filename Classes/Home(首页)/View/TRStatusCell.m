//
//  TRStatusCell.m
//  露露微博
//
//  Created by lushuishasha on 15/8/18.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRStatusCell.h"
#import "TRStatus.h"
#import "TRStatusFrame.h"
#import "TRUser.h"
#import "UIImageView+WebCache.h"
#import "TRPhoto.h"
#import "TRStatusToolBar.h"
#import "NSString+Extension.h"
#import "TRStatusPhotosView.h"
#import "TRIconView.h"
@interface TRStatusCell()
@property (nonatomic, weak) UIView *orginalView;
@property (nonatomic, weak) TRIconView *iconView;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) TRStatusPhotosView *photosView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIView *retweetView;
@property (nonatomic, weak) TRStatusToolBar *toolBar;

/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;

/** 转发配图 */
@property (nonatomic, weak) TRStatusPhotosView *retweetPhotosView;
@end


@implementation TRStatusCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
   
    static NSString *Cell = @"Cell";
    TRStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell ];
    if (!cell) {
        cell = [[TRStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cell];
    }
    return cell;    
}


/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpOriginal];
        [self setUpRetweet];
        [self setUpToolBar];
        
    }
    return  self;
}


- (void)setUpRetweet {
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.font = TRStatusCellRetweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    self.retweetContentLabel = retweetContentLabel;
    
    TRStatusPhotosView *retweetPhotosView = [[TRStatusPhotosView alloc]init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}



- (void)setUpOriginal {
    UIView *orginalView = [[UIView alloc]init];
    orginalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:orginalView];
    self.orginalView = orginalView;
    
    TRIconView *iconView = [[TRIconView alloc]init];
    [orginalView addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *vipView = [[UIImageView alloc]init];
    [orginalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    TRStatusPhotosView *photosView = [[TRStatusPhotosView alloc]init];
    [orginalView addSubview:photosView];
    self.photosView = photosView;
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = TRStatusCellNameFont;
    [orginalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = TRStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [orginalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = TRStatusCellSourceFont;
    [orginalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = TRStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [orginalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
  }


- (void) setUpToolBar {
    TRStatusToolBar *toolBar = [TRStatusToolBar toolbar];
   // toolBar.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}


- (void) setStatusFrame:(TRStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    TRStatus *status = statusFrame.status;
    TRUser *user = status.user;
    
    self.orginalView.frame = statusFrame.originalViewF;
    //头像
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
  
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewfF;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    
    
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + TRStarusCellBorderw;
    CGSize timeSize = [time sizeWithFont:TRStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    CGFloat sourcrX = CGRectGetMaxX(self.timeLabel.frame) + TRStarusCellBorderw;
    CGFloat sourceY = timeY;
    CGSize  sourceSize = [status.source sizeWithFont:TRStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourcrX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    

    //如果有转发的微博
    if (status.retweeted_status) {
        TRStatus *retweeted_status = status.retweeted_status;
        TRUser *retweeted_status_user = retweeted_status.user;
        self.retweetView.hidden = NO;
        //被转发的微博整体
        self.retweetView.frame = statusFrame.retweetViewF;
        
        //被转发微博正文
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        //被转发微博的图片
        if (status.retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotoViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    }else {
        self.retweetView.hidden = YES;
    }
    
    self.toolBar.frame = statusFrame.toolBarF;
    self.toolBar.status = status;
}


- (void) setFrame:(CGRect)frame {
    frame.origin.y += TRStatusCellMargin;
    [super setFrame:frame];
}
@end
