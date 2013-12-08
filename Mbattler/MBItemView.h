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
#import "MBItemButton.h"
#import "MBMassageLabel.h"
#import <StoreKit/StoreKit.h>

@interface MBItemView : MBScrollView
<SKProductsRequestDelegate,SKPaymentTransactionObserver> {
    MBItemButton *item0_button ,*item1_button, *item2_button;
    UIOutlineLabel *item0_label, *item1_label, *item2_label;
    
    MBSubScrollView *myitem_view;
    MBSubScrollView *shop_view;
    
    int buying_item_int;

    NSArray *products;
    
    
    // アイテム説明文
    // UIScrollView *now_item_desc_view;
    MBMassageLabel *now_item_desc_view;
}

@end
