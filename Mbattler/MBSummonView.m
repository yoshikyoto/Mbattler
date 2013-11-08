//
//  MBSummonView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/08.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBSummonView.h"

@implementation MBSummonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPlayer:(Player *)p{
    self = [super initWithPlayer:p];
    if(self){
        [self setTitle:@"名刺召喚"];
        // title.frame = CGRectMake(-5, 4, 310, 40);
        title.frame = CGRectMake(-310, 4, 310, 40);
        
        // カメラ起動ボタン CGRectMake(30, 80, 260, 40);
        _cameraButton = [MBButton buttonWithType:UIButtonTypeCustom];
        _cameraButton.frame = CGRectMake(320, 80, 260, 40);
        
        // 名刺撮影の注意書きラベル CGRectMake(15, 140, 300, 100)
        alert_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 500, 300, 100)];
        alert_label.numberOfLines = 5;
        [self addSubview:alert_label];
        
        // ここでカメラが起動できるデバイスか確認
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            if([player isMeishiFull]){
                // 名刺が一杯の場合
                [_cameraButton setColorType:2];
                [_cameraButton setTitle:@"名刺がいっぱいです" forState:UIControlStateNormal];
                alert_label.text = @"新たに名刺からバトラーを召喚したい場合は、Statusから、バトラーを解雇してください。";
            }else{
                [_cameraButton setColorType:0];
                [_cameraButton setTitle:@"カメラ起動" forState:UIControlStateNormal];
                // [_cameraButton addTarget:self action:@selector(launchCamera:)forControlEvents:UIControlEventTouchUpInside];
                alert_label.text = @"文字認識を行いますので、名刺をカメラと平行に持って、明るい場所で撮影してください。\n画像認識には少々時間がかかります。";
            }
        }else{
            [_cameraButton setColorType:2];
            [_cameraButton setTitle:@"カメラ非対応なデバイスです" forState:UIControlStateNormal];
            alert_label.text = @"お使いのデバイスはカメラががついていません。\n申し訳ありませんが名刺の召喚は行えません。";
        }
        [self addSubview:_cameraButton];

    }
    return self;
}

- (void)startAnimation{
    //アニメーションの対象となるコンテキスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //アニメーションを実行する時間
    [UIView setAnimationDuration:0.2];
    //アニメーションイベントを受け取るview
    [UIView setAnimationDelegate:self];
    //アニメーション終了後に実行される
    //[UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    title.frame = CGRectMake(-5, 4, 310, 40);
    _cameraButton.frame = CGRectMake(30, 80, 260, 40);
    alert_label.frame = CGRectMake(15, 140, 300, 100);
    
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
