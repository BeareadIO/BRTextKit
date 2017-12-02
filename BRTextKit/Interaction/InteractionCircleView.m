//
//  InteractionCircleView.m
//  BRTextKit
//
//  Created by Archy on 2017/12/1.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "InteractionCircleView.h"

@implementation InteractionCircleView

- (void)drawRect:(CGRect)rect {
    [self.tintColor setFill];
    [[UIBezierPath bezierPathWithOvalInRect:self.bounds] fill];
}

@end
