//
//  LayoutTextStorage.m
//  BRTextKit
//
//  Created by Archy on 2017/12/1.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "LayoutTextStorage.h"

@interface LayoutTextStorage ()

@property (strong, nonatomic) NSTextStorage *storage;

@end

@implementation LayoutTextStorage

- (instancetype)init {
    self = [super init];
    if (self) {
        self.storage = [[NSTextStorage alloc] init];
    }
    return self;
}

#pragma mark - Get Info

- (NSString *)string {
    return self.storage.string;
}

- (NSDictionary<NSAttributedStringKey,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [self.storage attributesAtIndex:location effectiveRange:range];
}

#pragma makr - Set Info

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self.storage replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedAttributes | NSTextStorageEditedCharacters range:range changeInLength:(str.length - range.length)];
    
    static NSDataDetector *linkDetector;
    linkDetector = linkDetector ?: [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:NULL];
    
    NSRange paragraphRange = [self.string paragraphRangeForRange:self.editedRange];
    [self removeAttribute:NSLinkAttributeName range:paragraphRange];
    [self removeAttribute:NSUnderlineStyleAttributeName range:paragraphRange];
    
    [linkDetector enumerateMatchesInString:self.string options:0 range:paragraphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        [self addAttribute:NSLinkAttributeName value:result.URL range:result.range];    
        [self addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:result.range];
    }];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
    [self.storage setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}


@end
