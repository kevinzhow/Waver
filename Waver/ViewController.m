//
//  ViewController.m
//  Waver
//
//  Created by kevinzhow on 14/12/14.
//  Copyright (c) 2014年 Catch Inc. All rights reserved.
//

#import "ViewController.h"
#import "Waver.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Waver * waver = [[Waver alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    waver.waverManLevelCallback = ^() {
        NSLog(@"Hello");
    };
    [self.view addSubview:waver];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
