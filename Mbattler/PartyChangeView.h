//
//  PartyChangeView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/07/14.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meishi.h"

@interface PartyChangeView : UIScrollView{
    Meishi *p_meishi;
    UIImageView *p_image;
    UILabel *ph, *pa, *pb, *pc, *pd, *ps;
    UILabel *phv, *pav, *pbv, *pcv, *pdv, *psv;
    
    Meishi *n_meishi;
    UIImageView *n_image;
    UILabel *nh, *na, *nb, *nc, *nd, *ns;
    UILabel *nhv, *nav, *nbv, *ncv, *ndv, *nsv;
}

- (void)set_p:(Meishi *)m;
- (void)set_n:(Meishi *)m;
- (void)draw;

@end
