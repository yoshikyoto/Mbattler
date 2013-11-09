//
//  MBDungeonView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBDungeonView.h"

@implementation MBDungeonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPlayer:(Player *)p
{
    self = [super initWithPlayer:p];
    if (self) {
        NSLog(@"%s", __func__);
        [self setTitle:@"ダンジョン"];
        _dungeonListView = [[UIScrollView alloc] init];
        _dungeonListView.frame = CGRectMake(320, 50, 320, self.frame.size.height-50);
        [self addSubview:_dungeonListView];
    }
    return self;
}

- (void)startAnimation{
    //_dungeonListView.frame = CGRectMake(320, 50, 320, self.frame.size.height-50);
    
    CGRect list_frame = _dungeonListView.frame;
    list_frame.origin.x = 0;
    
    //アニメーションの対象となるコンテキスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //アニメーションを実行する時間
    [UIView setAnimationDuration:0.2];
    //アニメーションイベントを受け取るview
    [UIView setAnimationDelegate:self];
    //アニメーション終了後に実行される
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    title.frame = CGRectMake(-5, 4, 310, 40);
    _dungeonListView.frame = CGRectMake(0, 50, 320, self.frame.size.height-50);
    
    // アニメーション開始
    [UIView commitAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
