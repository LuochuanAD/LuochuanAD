//
//  Scribble.h
//  LuochuanAD
//
//  Created by care on 2017/6/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "ScribbleMemento.h"
@interface Scribble : NSObject
{
    @private
    id<Mark>_parentMark;
    id<Mark>_incrementalMark;

}
- (void)addMark:(id<Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void)removeMark:(id<Mark>)aMark;
- (id)initWithMemento:(ScribbleMemento *)aMenmento;
+ (Scribble *)scribbleWithMemento:(ScribbleMemento *)aMemento;
- (ScribbleMemento *)scribbleMemento;
- (ScribbleMemento *)scribbleMementoWithCompleteSnashot:(BOOL)hasCompleteSnapshot;
- (void)attachStateFromMemento:(ScribbleMemento *)memento;
@end
