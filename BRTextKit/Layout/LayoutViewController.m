//
//  LayoutViewController.m
//  BRTextKit
//
//  Created by Archy on 2017/12/1.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "LayoutViewController.h"
#import "LayoutTextStorage.h"
#import "UnderlineLayoutManager.h"

@interface LayoutViewController () <NSLayoutManagerDelegate>

@property (strong, nonatomic) LayoutTextStorage *storage;

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.storage = [[LayoutTextStorage alloc] init];
    
    UnderlineLayoutManager *underlineManager = [[UnderlineLayoutManager alloc] init];
    [self.storage addLayoutManager:underlineManager];
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(0, 0)];
    [underlineManager addTextContainer:container];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:container];
    textView.translatesAutoresizingMaskIntoConstraints = YES;
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    textView.backgroundColor = [UIColor flatSandColor];
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.right.equalTo(self.view).with.offset(-15);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(15);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).with.offset(-15);
    }];
    
    underlineManager.delegate = self;
}

#pragma mark - NSLayoutManagerDelegate


- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex {
    NSRange range;
    NSURL *linkURL = [layoutManager.textStorage attribute:NSLinkAttributeName atIndex:charIndex effectiveRange:&range];
    
    // Do not break lines in links unless absolutely required
    if (linkURL && charIndex > range.location && charIndex <= NSMaxRange(range))
        return NO;
    else
        return YES;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    return 10;
}

- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager paragraphSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    return 10;
}



@end
