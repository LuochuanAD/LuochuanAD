//
//  Stroke.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "Stroke.h"

@implementation Stroke
- (instancetype)init
{
    self = [super init];
    if (self) {
        _children=[[NSMutableArray alloc]initWithCapacity:5];
    }
    return self;
}
- (void)setLocation:(CGPoint)location{

}
- (CGPoint)location{
    if ([_children count]>0) {
        return [(id<Mark>)[_children objectAtIndex:0] location];
    }
    return CGPointZero;

}
- (void)addMark:(id<Mark>)mark{
    [_children addObject:mark];
}
- (void)removeMark:(id<Mark>)mark{
    if ([_children containsObject:mark]) {
        [_children removeObject:mark];
    }else{
        [_children makeObjectsPerformSelector:@selector(removeMark:) withObject:mark];
    }

}
- (id<Mark>)childMarkAtIndex:(NSUInteger)index{
    if (index>=[_children count]) {
        return nil;
    }
    return [_children objectAtIndex:index];
}
- (id<Mark>)lastChild{
    return [_children lastObject];
}
- (NSUInteger)count{
    return [_children count];
}
- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor{
    for (id<Mark>dot in _children) {
        [dot acceptMarkVisitor:visitor];
    }
    [visitor visitStroke:self];

}
- (id)copyWithZone:(NSZone *)zone{
    Stroke *strokeCopy=[[[self class] allocWithZone:zone] init];
    [strokeCopy setColor:[UIColor colorWithCGColor:[self.color CGColor]]];
    [strokeCopy setSize:self.size];
    for (id<Mark>child in _children) {
        [strokeCopy addMark:child];
    }
    return strokeCopy;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.color=[aDecoder decodeObjectForKey:@"StrokeColor"];
        self.size=[aDecoder decodeFloatForKey:@"StrokeSize"];
        _children=[aDecoder decodeObjectForKey:@"StrokeChildren"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.color forKey:@"StrokeColor"];
    [aCoder encodeFloat:self.size forKey:@"StrokeSize"];
    [aCoder encodeObject:_children forKey:@"StrokeChildren"];

}
- (NSEnumerator *)enumerator{
    return [[MarkEnumerator alloc]initWithMark:self];
}
- (void)enumerateMarkUsingBlock:(void (^)(id<Mark>, BOOL *))block{
    BOOL stop=NO;
    NSEnumerator *enumerator=[self enumerator];
    for (id<Mark> mark in enumerator) {
        block (mark,&stop);
        if (stop) {
            break;
        }
    }
 
}
- (void)drawWithContext:(CGContextRef)context{
    CGContextMoveToPoint(context, self.location.x, self.location.y);
    for (id<Mark> mark in _children) {
        [mark drawWithContext:context];
    }
    CGContextSetLineWidth(context, self.size);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
    CGContextStrokePath(context);
}
@end
