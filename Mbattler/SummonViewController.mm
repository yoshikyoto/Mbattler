//
//  SummonViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "SummonViewController.h"
#import "MBAnimationView.h"
#import "MBStatusView.h"
#import "MBButton.h"

@interface SummonViewController ()

@end

@implementation SummonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setMeishi:(Meishi *)m{
    meishi = m;
    // 閉じるボタンの設置
    _close_button = [MBButton buttonWithType:UIButtonTypeRoundedRect];
    [_close_button setColorType:0];
    _close_button.frame = CGRectMake(100, 390, 120, 30);
    [_close_button setTitle:@"× とじる" forState:UIControlStateNormal];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"SummonViewController viewDidLoad");
    
    // 背景
    [[self view] setBackgroundColor:[UIColor blackColor]];

    // 魔法陣エフェクト準備
    effect1 = [[MBAnimationView alloc] init];
    [effect1 setAnimationImage:@"e_circle_240.png" :240 :240 :11];
    effect1.frame = CGRectMake(40, 160, 240, 240);
    effect1.animationDuration = 1;
    
    // 渦巻きエフェクト準備
    effect2 = [[MBAnimationView alloc] init];
    [effect2 setAnimationImage:@"e_appear_240.png" :94 :240 :12];
    effect2.frame = CGRectMake(113, 60, 94, 240);
    effect2.animationDuration = 1;
    
    // 魔法陣エフェクト発動
    [[self view] addSubview:effect1];
    [effect1 startAnimating];
    // タイマー
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(viewEffect2:)
                                   userInfo:nil
                                    repeats:false];
}

- (void)viewEffect2:(id)sender{
    NSLog(@"viewEffect2");
    // 渦巻きエフェクト発動
    [[self view] addSubview:effect2];
    [effect2 startAnimating];
    
    // タイマー
    [NSTimer scheduledTimerWithTimeInterval:0.4
                                     target:self
                                   selector:@selector(viewEffect3:)
                                   userInfo:nil
                                    repeats:false];
}

- (void)viewEffect3:(id)sender{
    NSLog(@"viewEffect3");
    // キャラ登場
    UIImageView *view = [meishi getCenterImage];
    view.frame = CGRectMake(136, 200, 48, 72);
    [[self view] addSubview:view];
    [[self view] addSubview:effect2];
    
    // タップレコグナイザー
    tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewStatus:)];
    [[self view] addGestureRecognizer:tgr];
}

- (void)viewStatus:(id)sender{
    [[self view] removeGestureRecognizer:tgr];
    MBStatusView *view = [[MBStatusView alloc] initWithMeishi:meishi];
    view.frame = CGRectMake(0, 30, 320, 390);
    // 戻るボタンを消す
    [view removeBackButton];
    [[self view] addSubview:view];
    // 代わりに画面閉じるボタンを設置
    //[backbutton addTarget:self action:@selector(close:)forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:_close_button];
}

- (void)close:(id)sender{
    NSLog(@"ダンジョン");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
