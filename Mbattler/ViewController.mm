//
//  ViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/03/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "ViewController.h"
#import "Meishi.h"
#import "Player.h"
#import "MBViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // タイトル
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(60, 30, 200, 50);
    title.font = [UIFont systemFontOfSize:24];
    title.text = @"名刺バトラー";
    title.textAlignment = NSTextAlignmentCenter;
    [[self view] addSubview:title];

    UILabel *touchstart = [[UILabel alloc] init];
    touchstart.frame = CGRectMake(60, 160, 200, 50);
    touchstart.text = @"TOUCH START";
    touchstart.textAlignment = NSTextAlignmentCenter;
    [[self view] addSubview:touchstart];
    
    // タッチ検知
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(start:)];
    [[self view] addGestureRecognizer:tgr];
}

- (void)start:(UITapGestureRecognizer *)sender{
    MBViewController *mbvc = [[MBViewController alloc] init];
    [self presentViewController:mbvc animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


