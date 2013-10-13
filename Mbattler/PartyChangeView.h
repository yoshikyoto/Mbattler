//
//  PartyChangeView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/07/14.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meishi.h"
#import "UIOutlineLabel.h"

@interface PartyChangeView : UIScrollView{
    UIImageView *p_image;
    UILabel *p_name_label;
    UILabel *pjob, *plv, *pabl;
    UILabel *ph, *pa, *pb, *pc, *pd, *ps;
    UILabel *phv, *pav, *pbv, *pcv, *pdv, *psv;
    
    UIImageView *r_image;
    UILabel *r_name_label;
    UILabel *rjob, *rlv, *rabl;
    UILabel *rh, *ra, *rb, *rc, *rd, *rs;
    UILabel *rhv, *rav, *rbv, *rcv, *rdv, *rsv;
}

- (void)setPartyMember:(Meishi *)meishi;
- (void)setReserveMember:(Meishi *)meishi;
@end
