//
//  Vertex.m
//  LuochuanAD
//
//  Created by 罗川 on 2017/6/7.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex
- (id)initWithlocation:(CGPoint)location{
    if (self=[super init]) {
        [self setLocation:location];
    }
    return self;
}
- (void)setColor:(UIColor *)color{}
- (UIColor *)color{ return nil;}
- (void)setSize:(CGFloat)size{}
- (CGFloat)size{ return 0.0;}

- (void)addMark:(id<Mark>)mark{}
- (void)removeMark:(id<Mark>)mark{}
- (id<Mark>)childMarkAtIndex:(NSUInteger)index{ return nil;}
- (id<Mark>)lastChild{return nil;}
- (NSUInteger)count{return 0;}
- (NSEnumerator *)enumerator{ return nil;}
- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor{
    [visitor visitMark:self];
}

- (id)copyWithZone:(NSZone *)zone{
    Vertex *vertexCopy=[[[self class] allocWithZone:zone]initWithlocation:_location];
    return vertexCopy;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _location=[(NSValue *)[aDecoder decodeObjectForKey:@"VertexLocation"]CGPointValue];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[NSValue valueWithCGPoint:_location] forKey:@"Vertexlocation"];
}
- (void)enumerateMarkUsingBlock:(void (^)(id<Mark>, BOOL *))block{}
- (void)drawWithContext:(CGContextRef)context{
    CGFloat x=self.location.x;
    CGFloat y=self.location.y;
    CGContextAddLineToPoint(context, x, y);
    
}
@end
