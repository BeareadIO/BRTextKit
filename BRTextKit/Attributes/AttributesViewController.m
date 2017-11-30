//
//  AttributesViewController.m
//  BRTextKit
//
//  Created by Archy on 2017/11/30.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "AttributesViewController.h"
#import "AttributesTextStorage.h"

@interface AttributesViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) AttributesTextStorage *storage;


@end

@implementation AttributesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *content = self.textView.text;
    self.storage = [[AttributesTextStorage alloc] init];
    [self.storage addLayoutManager:self.textView.layoutManager];
    [self.storage replaceCharactersInRange:NSMakeRange(0, 0) withString:content];
}

@end
