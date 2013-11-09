//
//  MBItemView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"
#import "UIOutlineLabel.h"
#import "MBSubScrollView.h"

@interface MBItemView : MBScrollView{
    UIButton *item0_button ,*item1_button, *item2_button;
    UIOutlineLabel *item0_label, *item1_label, *item2_label;
    
    MBSubScrollView *myitem_view;
    MBSubScrollView *itemShop_view;
    
    // アイテム説明文
    UIScrollView *now_item_desc_view;
}

@end
