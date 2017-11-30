//
//  AttributesTextStorage.m
//  BRTextKit
//
//  Created by Archy on 2017/11/30.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "AttributesTextStorage.h"

@interface AttributesTextStorage ()

@property (strong, nonatomic) NSTextStorage *storage;

@end

@implementation AttributesTextStorage
{
    NSMutableAttributedString *_imp;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _imp = [NSMutableAttributedString new];
    }
    
    return self;
}

#pragma mark - Get Info

- (NSString *)string {
    return _imp.string;
}

- (NSDictionary<NSAttributedStringKey,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [_imp attributesAtIndex:location effectiveRange:range];
}

#pragma mark - Set Info

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [_imp replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedAttributes | NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
}

- (void)setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range {
    [_imp setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

#pragma mark - While Editing
- (void)processEditing {
    static NSRegularExpression *iExp;
    static NSRegularExpression *highlightExp;
    static NSRegularExpression *underlineExp;
    static NSRegularExpression *strikethroughExp;
    iExp = iExp ?: [NSRegularExpression regularExpressionWithPattern:@"i[\\p{Alphabetic}&&\\p{Uppercase}][\\p{Alphabetic}]+" options:0 error:NULL];
    highlightExp = highlightExp ?: [NSRegularExpression regularExpressionWithPattern:@"高亮" options:0 error:NULL];
    underlineExp = underlineExp ?: [NSRegularExpression regularExpressionWithPattern:@"下划线" options:0 error:NULL];
    strikethroughExp = strikethroughExp ?: [NSRegularExpression regularExpressionWithPattern:@"删除线" options:0 error:NULL];
    
    
    NSRange paragraphRange = [self.string paragraphRangeForRange:self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragraphRange];
    
    [self addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:paragraphRange];
    [iExp enumerateMatchesInString:self.string options:0 range:paragraphRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor flatGreenColor] range:result.range];
    }];
    
    [highlightExp enumerateMatchesInString:self.string options:0 range:paragraphRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor flatBlueColor] range:result.range];
    }];
    
    [underlineExp enumerateMatchesInString:self.string options:0 range:paragraphRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:result.range];
    }];
    
    [strikethroughExp enumerateMatchesInString:self.string options:0 range:paragraphRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:result.range];
    }];
    [super processEditing];
}

@end
