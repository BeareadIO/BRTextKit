//
//  ConfigurationViewController.m
//  BRTextKit
//
//  Created by Archy on 2017/11/30.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "ConfigurationViewController.h"
#import <Masonry.h>

@interface ConfigurationViewController ()

@property (weak, nonatomic) IBOutlet UITextView *topTextView;

@end

@implementation ConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTextStorage *topStorage = self.topTextView.textStorage;
    
    NSLayoutManager *leftLayoutManager = [NSLayoutManager new];
    [topStorage addLayoutManager:leftLayoutManager];
    
    NSTextContainer *leftTextContainer = [NSTextContainer new];
    [leftLayoutManager addTextContainer:leftTextContainer];
    
    UITextView *leftTextView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:leftTextContainer];
    leftTextView.translatesAutoresizingMaskIntoConstraints = YES;
    leftTextView.scrollEnabled = NO;
    [self.view addSubview:leftTextView];
    
    NSTextContainer *rightTextContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    [leftLayoutManager addTextContainer:rightTextContainer];
    
    UITextView *rightTextView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:rightTextContainer];
    rightTextView.translatesAutoresizingMaskIntoConstraints = YES;
    rightTextView.scrollEnabled = NO;
    [self.view addSubview:rightTextView];
    
    [leftTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topTextView.mas_bottom).with.offset(15);
        make.bottom.equalTo(self.view).with.offset(-15);
        make.left.equalTo(self.view).with.offset(15);
        make.right.equalTo(rightTextView.mas_left).with.offset(-15);
        make.width.equalTo(rightTextView);
    }];
    
    [rightTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(leftTextView);
        make.right.equalTo(self.view).with.offset(-15);
    }];
}

@end
