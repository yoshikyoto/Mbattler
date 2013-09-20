//
//  MBStatusView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"

@interface MBStatusView : MBScrollView{
    UIButton *backbutton;
}

- (id)initWithMeishi:(Meishi *)meishi;
- (void)removeBackButton;
@end
