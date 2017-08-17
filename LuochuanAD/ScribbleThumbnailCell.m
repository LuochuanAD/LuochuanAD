//
//  ScribbleThumbnailCell.m
//  LuochuanAD
//
//  Created by care on 2017/6/13.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "ScribbleThumbnailCell.h"

@implementation ScribbleThumbnailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (NSInteger)numberOfPalaceholders{
    return 3;
}
- (void)addThumbnailView:(UIView *)thumbnailView atIndex:(NSInteger)index{
    if (index==0) {
        for (UIView *view in [[self contentView] subviews]) {
            [view removeFromSuperview];
        }
    }
    if (index<[ScribbleThumbnailCell numberOfPalaceholders]) {
        CGFloat x=index*90 +(index +1)*12;
        CGFloat y=10;
        CGFloat width=90;
        CGFloat height=130;
        [thumbnailView setFrame:CGRectMake(x, y, width, height)];
        [self.contentView addSubview:thumbnailView];
    }

}

@end
