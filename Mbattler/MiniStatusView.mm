//
//  MiniStatusView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/13.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MiniStatusView.h"
#import "Meishi.h"

@implementation MiniStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        meishi = nil;
        
        // アイコン描写
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 54, 54)];
        [self addSubview:icon];
        
        // 名前
        name = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 80, 30)];
        [name setBackgroundColor:[UIColor clearColor]];
        [self addSubview:name];
        
        // 各種ステータスのラベル
        hlabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 40, 30)];
        [hlabel setBackgroundColor:[UIColor clearColor]];
        hlabel.text = @"HP";
        [self addSubview:hlabel];
        alabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 40, 30)];
        [alabel setBackgroundColor:[UIColor clearColor]];
        alabel.text = @"攻撃";
        [self addSubview:alabel];
        blabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 65, 40, 30)];
        [blabel setBackgroundColor:[UIColor clearColor]];
        blabel.text = @"防御";
        [self addSubview:blabel];
        clabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, 40, 30)];
        [clabel setBackgroundColor:[UIColor clearColor]];
        clabel.text = @"特攻";
        [self addSubview:clabel];
        dlabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 35, 40, 30)];
        [dlabel setBackgroundColor:[UIColor clearColor]];
        dlabel.text = @"特防";
        [self addSubview:dlabel];
        slabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 65, 60, 30)];
        [slabel setBackgroundColor:[UIColor clearColor]];
        slabel.text = @"素早さ";
        [self addSubview:slabel];
        
        // 各種ステータスの値
        hvalue = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 40, 30)];
        [hvalue setBackgroundColor:[UIColor clearColor]];
        [self addSubview:hvalue];
        
        avalue = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 40, 30)];
        [avalue setBackgroundColor:[UIColor clearColor]];
        [self addSubview:avalue];
        
        bvalue = [[UILabel alloc] initWithFrame:CGRectMake(110, 65, 40, 30)];
        [bvalue setBackgroundColor:[UIColor clearColor]];
        [self addSubview:bvalue];
        
        cvalue = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 40, 30)];
        [cvalue setBackgroundColor:[UIColor clearColor]];
        [self addSubview:cvalue];
        
        dvalue = [[UILabel alloc] initWithFrame:CGRectMake(210, 35, 40, 30)];
        [dvalue setBackgroundColor:[UIColor clearColor]];
        [self addSubview:dvalue];
        
        svalue = [[UILabel alloc] initWithFrame:CGRectMake(210, 65, 40, 30)];
        [svalue setBackgroundColor:[UIColor clearColor]];
        [self addSubview:svalue];
    }
    return self;
}

//外部向けメソッド

- (void)setMeishi:(Meishi *)m{
    NSLog(@"setMeishi at MiniStatusView");
    meishi = m;
    
    icon.image = [meishi getIcon];
    name.text = [meishi getName];
    hvalue.text = [meishi getHString];
    avalue.text = [meishi getAString];
    bvalue.text = [meishi getBString];
    cvalue.text = [meishi getCString];
    dvalue.text = [meishi getDString];
    svalue.text = [meishi getSString];
}

- (void)close:(id)sender{
    meishi = nil;
    [self removeFromSuperview];
    
}

- (Boolean)isSelected{
    if(meishi == nil){
        return false;
    }else{
        return true;
    }
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
