//
//  LayerLable.m
//  lcTestCADemo
//
//  Created by care on 2018/2/2.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "LayerLable.h"
#import <QuartzCore/QuartzCore.h>
@implementation LayerLable
+ (Class)layerClass{
    return [CATextLayer class];
}
- (CATextLayer *)textLayer{
    return (CATextLayer *)self.layer;
}
- (void)setUp{
    self.text=self.text;
    self.textColor=self.textColor;
    self.font=self.font;
    
    [self textLayer].alignmentMode=kCAAlignmentJustified;
    [self textLayer].wrapped=YES;
    [self.layer display];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib{
    [self setUp];
}
- (void)setText:(NSString *)text{
    super.text=text;
    [self textLayer].string=text;
}
- (void)setTextColor:(UIColor *)textColor{
    super.textColor=textColor;
    [self textLayer].foregroundColor=textColor.CGColor;
}
- (void)setFont:(UIFont *)font{
    super.font=font;
    CFStringRef fontName=(__bridge CFStringRef)font.fontName;
    CGFontRef fontRef=CGFontCreateWithFontName(fontName);
    [self textLayer].font=fontRef;
    [self textLayer].fontSize=font.pointSize;
    CGFontRelease(fontRef);
    
}

@end
