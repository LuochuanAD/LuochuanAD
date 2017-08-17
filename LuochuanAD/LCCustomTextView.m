//
//  LCCustomTextView.m
//  LuochuanAD
//
//  Created by care on 17/5/25.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCCustomTextView.h"

@implementation LCCustomTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint touchPoint=[touch locationInView:self];
    touchPoint.y -=10;
    NSInteger characterIndex=[self.layoutManager characterIndexForPoint:touchPoint inTextContainer:self.textContainer fractionOfDistanceBetweenInsertionPoints:0];
    if (characterIndex!=0) {
        NSRange start=[self.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] options:NSBackwardsSearch range:NSMakeRange(0, characterIndex)];
        NSRange stop=[self.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] options:NSCaseInsensitiveSearch range:NSMakeRange(characterIndex, self.text.length-characterIndex)];
        int length=stop.location -start.location;
        NSLog(@"%d",length);
        //此处长度最大值不超过屏幕宽度一行能显示的多少字母/数字37
        if (length>1&&length<37) {
            NSString *fullWord=[self.text substringWithRange:NSMakeRange(start.location, length)];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"clicked word" message:fullWord delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        }
       
    }
    [super touchesBegan:touches withEvent:event];
}
@end
