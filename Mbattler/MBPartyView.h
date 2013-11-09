//
//  MBPartyView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"
#import "MiniStatusView.h"
#import "PartyChangeView.h"

@interface MBPartyView : MBScrollView{
    UIScrollView *party_view; //CGRectMake(10, 50, 300, 90)
    UIScrollView *reserve_view;
    UILabel *party_black_mask, *reserve_black_mask;
    Boolean latest_view;
    UIButton *p_cancelbutton;
    UIButton *n_cancelbutton;
    Boolean party_select_flag;
    Boolean reserve_select_flag;
    int p_id;
    int n_id;
    
    int selected_party_tag;
    int selected_reserve_tag;
    /* これらの変数は、
     * -2 何も選択されていない
     * -1 「はずす」「いれる」が選択されている
     * 1~ 何かが選択されている
     */
    
    Boolean latest_selection_bool;
    
    PartyChangeView *confirm_window;
    UIButton *confirm_button;
    UIButton *cancel_button;
    
    UIButton *selected_p_button;
    UIButton *selected_n_button;
}

@end
