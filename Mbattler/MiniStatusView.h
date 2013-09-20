//
//  MiniStatusView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/13.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meishi.h"

@protocol MiniStatusViewDelegate
-(void)closeMiniStatusView;
@end

@interface MiniStatusView : UIScrollView{
    UILabel *statusbg;
    Meishi *meishi;
    UIImageView *icon;
    UILabel *name;
    UILabel *hlabel;
    UILabel *alabel;
    UILabel *blabel;
    UILabel *clabel;
    UILabel *dlabel;
    UILabel *slabel;
    UILabel *hvalue;
    UILabel *avalue;
    UILabel *bvalue;
    UILabel *cvalue;
    UILabel *dvalue;
    UILabel *svalue;
    UIButton *cancel_button;
    UIButton *withdraw;
    
    id <MiniStatusViewDelegate> delegate;
}

- (void)setMeishi:(Meishi *)m;
- (Boolean)isSelected;
@end

