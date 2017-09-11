//
//  HPUpdaterService.m
//  LuochuanAD
//
//  Created by care on 2017/9/11.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "HPUpdaterService.h"

@implementation HPUpdaterService
- (void)updateUser:(HPUser *)user properties:(NSDictionary *)properties{
    @synchronized (user) {
        NSString *fn=[properties objectForKey:@"firstName"];
        if (fn!=nil) {
            user.firstName=fn;
        }
        NSString *ln=[properties objectForKey:@"lastName"];
        if (ln!=nil) {
            user.lastName=ln;
        }
    }

}
@end
