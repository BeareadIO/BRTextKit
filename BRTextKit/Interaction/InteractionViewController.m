//
//  InteractionViewController.m
//  BRTextKit
//
//  Created by Archy on 2017/12/1.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "InteractionViewController.h"
#import "InteractionCircleView.h"


@interface InteractionViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet InteractionCircleView *circleView;
@property (assign, nonatomic) CGPoint panOffset;

@end

@implementation InteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circleView.tintColor = [UIColor flatPlumColor];
    self.circleView.clipsToBounds = YES;
    [self.circleView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(circlePan:)]];
    [self updateExclusionPaths];

    self.textView.layoutManager.hyphenationFactor = 1.0;
}

- (void)updateExclusionPaths {
    CGRect ovalFrame = [self.textView convertRect:self.circleView.bounds fromView:self.circleView];
    
    ovalFrame.origin.x -= self.textView.textContainerInset.left;
    ovalFrame.origin.y -= self.textView.textContainerInset.top;
    
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:ovalFrame];
    self.textView.textContainer.exclusionPaths = @[ovalPath];
}

- (void)circlePan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan)
        _panOffset = [pan locationInView: self.circleView];
    
    CGPoint location = [pan locationInView: self.view];
    CGPoint circleCenter = self.circleView.center;
    
    circleCenter.x = location.x - _panOffset.x + self.circleView.frame.size.width / 2;
    circleCenter.y = location.y - _panOffset.y + self.circleView.frame.size.width / 2;
    self.circleView.center = circleCenter;
    
    [self updateExclusionPaths];
}

@end
