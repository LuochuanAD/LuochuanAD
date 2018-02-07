//
//  ReflectionView.m
//  lcTestCADemo
//
//  Created by care on 2018/2/5.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "ReflectionView.h"

@implementation ReflectionView

+ (Class)layerClass{
    
    return [CAReplicatorLayer class];
}
- (void)setUp{
    CAReplicatorLayer *layer=(CAReplicatorLayer *)self.layer;
    layer.instanceCount=2;
    CATransform3D transform=CATransform3DIdentity;
    
    CGFloat verticalOffect=self.bounds.size.height+2;
    transform=CATransform3DTranslate(transform, 0, verticalOffect, 0);
    transform=CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform=transform;
    layer.instanceAlphaOffset=-0.6;
    
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

@end
