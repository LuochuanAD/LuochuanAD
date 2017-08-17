//
//  ScribbleMemento.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "ScribbleMemento.h"
#import "ScribbleMemento+Friend.h"
@implementation ScribbleMemento
- (NSData *)data{
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:_mark];
    return data;
}
+ (ScribbleMemento *)mementoWithData:(NSData *)data{
    id<Mark>retoredMark=(id<Mark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    ScribbleMemento *memento=[[ScribbleMemento alloc]initWithMark:retoredMark];
    return memento;

}
- (id)initWithMark:(id<Mark>)aMark{
    if (self=[super init]) {
        [self setMark:aMark];
    }
    return self;
}

@end
