//
//  ViewController.m
//  TestOpenGLES
//
//  Created by lurong on 15/1/29.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)buildLayout
{
//    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    OpenGLView *view = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    view = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
