//
//  Test3DViewController.m
//  LuochuanAD
//
//  Created by care on 2018/1/31.
//  Copyright © 2018年 luochuan. All rights reserved.
//

#import "Test3DViewController.h"
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>

#define light_direction 0,1,-0.5
#define ambient_light 0.5

@interface Test3DViewController ()

@end

@implementation Test3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATransform3D perspective=CATransform3DIdentity;
    perspective.m34=-1.0/1000;
    
    perspective=CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective=CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.view.layer.sublayerTransform=perspective;
    
    CATransform3D transform=CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    
    transform=CATransform3DMakeTranslation(100, 0, 0);
    transform=CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    transform=CATransform3DMakeTranslation(0, -100, 0);
    transform=CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    transform=CATransform3DMakeTranslation(0, 100, 0);
    transform=CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    transform=CATransform3DMakeTranslation(-100, 0, 0);
    transform=CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    transform=CATransform3DMakeTranslation(0, 0, -100);
    transform=CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    
}
- (void)applyLightingToFace:(CALayer *)face{
    CALayer *layer=[CALayer layer];
    layer.frame=face.bounds;
    [face addSublayer:layer];
    
    CATransform3D transform=face.transform;
    GLKMatrix4 matrix4=*(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3=GLKMatrix4GetMatrix3(matrix4);
    
    GLKVector3 normal=GLKVector3Make(0, 0, 1);
    normal=GLKMatrix3MultiplyVector3(matrix3, normal);
    normal=GLKVector3Normalize(normal);
    
    GLKVector3 light=GLKVector3Normalize(GLKVector3Make(light_direction));
    float dotProduct = GLKVector3DotProduct(light, normal);
    
    CGFloat shadow=1+dotProduct-ambient_light;
    UIColor *color=[UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor=color.CGColor;
    
    
    
}


- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    UIView *face=self.faces[index];
    [self.view addSubview:face];
    
    CGSize containerSize=self.view.bounds.size;
    face.center=CGPointMake(containerSize.width/2.0, containerSize.height/2.0);
    face.layer.transform=transform;
    
    [self applyLightingToFace:face.layer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
