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
    UIScrollView *p_view;
    UIScrollView *n_view;
    MiniStatusView *pministatus;
    MiniStatusView *nministatus;
    UILabel *p_black, *n_black;
    Boolean latest_view;
    UIButton *p_cancelbutton;
    UIButton *n_cancelbutton;
    Boolean p_selected;
    Boolean n_selected;
    int p_id;
    int n_id;
    
    UILabel *confirm_message;
    PartyChangeView *confirm_window;
    UIButton *confirm;
    UIButton *cancel;
}

@end
