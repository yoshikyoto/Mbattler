//
//  MBCharacterView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"
#import "MBStatusView.h"

@interface MBCharacterView : MBScrollView{
    int tag;
    MBStatusView *status_view;
    UIScrollView *characterScrollView;
}

@end
