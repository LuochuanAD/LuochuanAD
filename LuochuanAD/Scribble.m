//
//  Scribble.m
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "Scribble.h"
#import "ScribbleMemento+Friend.h"
#import "Stroke.h"

@interface Scribble()
@property (nonatomic) id<Mark>mark;
@end

@implementation Scribble
@synthesize mark=_parentMark;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _parentMark=[[Stroke alloc]init];
    }
    return self;
}
- (void)addMark:(id<Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark{
    [self willChangeValueForKey:@"mark"];
    if (shouldAddToPreviousMark) {
        [[_parentMark lastChild] addMark:aMark];
    }else{
        [_parentMark addMark:aMark];
        _incrementalMark=aMark;
    }
    [self didChangeValueForKey:@"mark"];

}
- (void)removeMark:(id<Mark>)aMark{
    if (aMark==_parentMark) {
        return;
    }
    [self willChangeValueForKey:@"mark"];
    [_parentMark removeMark:aMark];
    if (aMark ==_incrementalMark) {
        _incrementalMark=nil;
    }
    [self didChangeValueForKey:@"mark"];

}
- (id)initWithMemento:(ScribbleMemento *)aMenmento{
    if (self=[super init]) {
        if ([aMenmento hasCompleteSnapshot]) {
            [self setMark:[aMenmento mark]];
        }else{
            _parentMark=[[Stroke alloc]init];
            [self attachStateFromMemento:aMenmento];
        }
    }
    return self;

}
- (void)attachStateFromMemento:(ScribbleMemento *)memento{
    [self addMark:[memento mark] shouldAddToPreviousMark:NO];

}
- (ScribbleMemento *)scribbleMementoWithCompleteSnashot:(BOOL)hasCompleteSnapshot{
    id<Mark>mementoMark=_incrementalMark;
    if (hasCompleteSnapshot) {
        mementoMark=_parentMark;
    }else if(mementoMark==nil){
        return nil;
    }
    ScribbleMemento *memento=[[ScribbleMemento alloc]initWithMark:mementoMark];
    [memento setHasCompleteSnapshot:hasCompleteSnapshot];

    return memento;
}
- (ScribbleMemento *)scribbleMemento{
    return [self scribbleMementoWithCompleteSnashot:YES];

}
+ (Scribble *)scribbleWithMemento:(ScribbleMemento *)aMemento{
    Scribble *scribble=[[Scribble alloc]initWithMemento:aMemento];
    return scribble;

}




@end
