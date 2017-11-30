//
//  ViewController.m
//  BRTextKit
//
//  Created by Archy on 2017/11/30.
//  Copyright © 2017年 Archy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *arrExample;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TextKit";
    self.arrExample = @[@"Configuration",@"Highlighting",@"Layout",@"Interaction"];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextKitCell" forIndexPath:indexPath];
    NSString *title = self.arrExample[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrExample.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *identifier = self.arrExample[indexPath.row];
    [self performSegueWithIdentifier:identifier sender:nil];
}

@end
