//
//  MBItemView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"
#import "UIOutlineLabel.h"

@interface MBItemView : MBScrollView{
    UIButton *item1_button, *item2_button;
    UIOutlineLabel *item1_label, *item2_label;
    
    // アイテム説明文
    UIScrollView *now_item_desc_view;
}

@end
