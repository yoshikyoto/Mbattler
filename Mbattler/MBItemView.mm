//
//  MBItemView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBItemView.h"

@implementation MBItemView

- (id)initWithPlayer:(Player *)p
{
    self = [super initWithPlayer:p];
    if (self) {
        // Initialization code
        
        // タイトル
        title.text = @"アイテム";
        [self addSubview:title];
        
        // 所持アイテム描写
        [self drawMyitem];
        [self drawShop];
    }
    return self;
}

- (void)drawMyitem{
    UIScrollView *myitem_view = [[UIScrollView alloc] init];
    myitem_view.frame = CGRectMake(10, 40, 300, 60);
    myitem_view.backgroundColor = title_bg;
    [self addSubview:myitem_view];
}

- (void)drawShop{
    UIScrollView *shop_view = [[UIScrollView alloc] init];
    shop_view.frame = CGRectMake(10, 105, 300, 300);
    shop_view.backgroundColor = sub_bg;
    [self addSubview:shop_view];
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
