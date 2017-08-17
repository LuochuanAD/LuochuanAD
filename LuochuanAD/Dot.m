//
//  Dot.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//


#import "Dot.h"
@implementation Dot

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor{
    [visitor visitDot:self];

}
- (id)copyWithZone:(NSZone *)zone{
    Dot *dotCopy=[[[self class] allocWithZone:zone] initWithlocation:self.location];
    [dotCopy setColor:[UIColor colorWithCGColor:[self.color CGColor]]];
    [dotCopy setSize:self.size];
    return dotCopy;

}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        self.color=[aDecoder decodeObjectForKey:@"DotColor"];
        self.size=[aDecoder decodeFloatForKey:@"DotSize"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.color forKey:@"DotColor"];
    [aCoder encodeFloat:self.size forKey:@"DotSize"];

}
- (void)drawWithContext:(CGContextRef)context{
    CGFloat x=self.location.x;
    CGFloat y=self.location.y;
    CGFloat frameSize=self.size;
    CGRect frame=CGRectMake(x-frameSize/2.0, y-frameSize/2.0, frameSize, frameSize);
    CGContextSetFillColorWithColor(context, [self.color CGColor]);
    CGContextFillEllipseInRect(context, frame);
    
}
@end
