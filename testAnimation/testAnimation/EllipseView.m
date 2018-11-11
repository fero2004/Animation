//
//  EllipseView.m
//  testAnimation
//
//  Created by 罗祖根 on 2018/11/11.
//  Copyright © 2018年 罗祖根. All rights reserved.
//

#import "EllipseView.h"

@implementation EllipseView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *ellipsePath = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = ellipsePath.CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.strokeColor = [UIColor blueColor].CGColor;
    shape.lineWidth = 2.0f;
    [self.layer addSublayer:shape];
}


@end
