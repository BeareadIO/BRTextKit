//
//  UnderlineLayoutManager.m
//  BRTextKit
//
//  Created by Archy on 2017/12/1.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "UnderlineLayoutManager.h"

@implementation UnderlineLayoutManager

- (void)drawUnderlineForGlyphRange:(NSRange)glyphRange underlineType:(NSUnderlineStyle)underlineVal baselineOffset:(CGFloat)baselineOffset lineFragmentRect:(CGRect)lineRect lineFragmentGlyphRange:(NSRange)lineGlyphRange containerOrigin:(CGPoint)containerOrigin {
    
    CGFloat firstPosition = [self locationForGlyphAtIndex:glyphRange.location].x;
    CGFloat lastPosition;
    
    if (NSMaxRange(glyphRange) < NSMaxRange(lineGlyphRange)) {
        lastPosition = [self locationForGlyphAtIndex:NSMaxRange(glyphRange)].x;
    }
    else {
        lastPosition = [self lineFragmentUsedRectForGlyphAtIndex:NSMaxRange(glyphRange) - 1 effectiveRange:NULL].size.width;
    }
    
    lineRect.origin.x += firstPosition;
    lineRect.size.width = lastPosition - firstPosition;
    lineRect.size.height = 1;
    
    lineRect.origin.x += containerOrigin.x;
    lineRect.origin.y += containerOrigin.y + baselineOffset + 5;
    
//    [[UIColor flatGrayColor] set];
//    [[UIBezierPath bezierPathWithRect:lineRect] fill];
}


@end
