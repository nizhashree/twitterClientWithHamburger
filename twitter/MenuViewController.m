//
//  MenuViewController.m
//  twitter
//
//  Created by Nizha Shree Seenivasan on 11/16/15.
//  Copyright © 2015 Nizha Shree Seenivasan. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *MenuTableView;

@end

@implementation MenuViewController
- (IBAction)buttonClick:(id)sender {
    [self.MenuTableView reloadData];
}

- (void)viewDidLoad {
    self.MenuTableView.dataSource = self;
    self.MenuTableView.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.MenuTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"hi";
    return cell;
}


@end
