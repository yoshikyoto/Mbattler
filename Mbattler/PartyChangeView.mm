//
//  PartyChangeView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/07/14.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "PartyChangeView.h"

@implementation PartyChangeView

// initialization --------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 「HP」とか表示する部分の初期化まとめて
        [self initStatusLabel];
        // 画像
        p_image = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 48, 48)];
        [self addSubview:p_image];
        n_image = [[UIImageView alloc] initWithFrame:CGRectMake(180, 30, 48, 48)];
        [self addSubview:n_image];
    }
    return self;
}

// 「HP」とか表示する部分の初期化 ----------------------------------------------------------------
- (void)initStatusLabel{
    // 
    ph = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 40, 20)];
    [ph setBackgroundColor:[UIColor clearColor]];
    [ph setText:@"HP"];
    [self addSubview:ph];
    
    pa = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 40, 20)];
    [pa setBackgroundColor:[UIColor clearColor]];
    [pa setText:@"攻撃"];
    [self addSubview:pa];
    
    pb= [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 40, 20)];
    [pb setBackgroundColor:[UIColor clearColor]];
    [pb setText:@"防御"];
    [self addSubview:pb];
    
    pc = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 40, 20)];
    [pc setBackgroundColor:[UIColor clearColor]];
    [pc setText:@"魔攻"];
    [self addSubview:pc];
    
    pd = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 40, 20)];
    [pd setBackgroundColor:[UIColor clearColor]];
    [pd setText:@"魔防"];
    [self addSubview:pd];
    
    ps = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 60, 20)];
    [ps setBackgroundColor:[UIColor clearColor]];
    [ps setText:@"素早さ"];
    [self addSubview:ps];
    
    
    phv = [[UILabel alloc] initWithFrame:CGRectMake(70, 100, 40, 20)];
    [phv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:phv];
    
    pav = [[UILabel alloc] initWithFrame:CGRectMake(70, 120, 40, 20)];
    [pav setBackgroundColor:[UIColor clearColor]];
    [self addSubview:pav];
    
    pbv = [[UILabel alloc] initWithFrame:CGRectMake(70, 140, 40, 20)];
    [pbv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:pbv];
    
    pcv = [[UILabel alloc] initWithFrame:CGRectMake(70, 160, 40, 20)];
    [pcv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:pcv];
    
    pdv = [[UILabel alloc] initWithFrame:CGRectMake(70, 180, 40, 20)];
    [pdv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:pdv];
    
    psv = [[UILabel alloc] initWithFrame:CGRectMake(70, 200, 40, 20)];
    [psv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:psv];
    
    
    nh = [[UILabel alloc] initWithFrame:CGRectMake(180, 100, 40, 20)];
    [nh setBackgroundColor:[UIColor clearColor]];
    [nh setText:@"HP"];
    [self addSubview:nh];
    
    na = [[UILabel alloc] initWithFrame:CGRectMake(180, 120, 40, 20)];
    [na setBackgroundColor:[UIColor clearColor]];
    [na setText:@"攻撃"];
    [self addSubview:na];
    
    nb= [[UILabel alloc] initWithFrame:CGRectMake(180, 140, 40, 20)];
    [nb setBackgroundColor:[UIColor clearColor]];
    [nb setText:@"防御"];
    [self addSubview:nb];
    
    nc = [[UILabel alloc] initWithFrame:CGRectMake(180, 160, 40, 20)];
    [nc setBackgroundColor:[UIColor clearColor]];
    [nc setText:@"魔攻"];
    [self addSubview:nc];
    
    nd = [[UILabel alloc] initWithFrame:CGRectMake(180, 180, 40, 20)];
    [nd setBackgroundColor:[UIColor clearColor]];
    [nd setText:@"魔防"];
    [self addSubview:nd];
    
    ns = [[UILabel alloc] initWithFrame:CGRectMake(180, 200, 60, 20)];
    [ns setBackgroundColor:[UIColor clearColor]];
    [ns setText:@"素早さ"];
    [self addSubview:ns];
    
    nhv = [[UILabel alloc] initWithFrame:CGRectMake(230, 100, 40, 20)];
    [nhv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:nhv];
    
    nav = [[UILabel alloc] initWithFrame:CGRectMake(230, 120, 40, 20)];
    [nav setBackgroundColor:[UIColor clearColor]];
    [self addSubview:nav];
    
    nbv = [[UILabel alloc] initWithFrame:CGRectMake(230, 140, 40, 20)];
    [nbv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:nbv];
    
    ncv = [[UILabel alloc] initWithFrame:CGRectMake(230, 160, 40, 20)];
    [ncv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:ncv];
    
    ndv = [[UILabel alloc] initWithFrame:CGRectMake(230, 180, 40, 20)];
    [ndv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:ndv];
    
    nsv = [[UILabel alloc] initWithFrame:CGRectMake(230, 200, 40, 20)];
    [nsv setBackgroundColor:[UIColor clearColor]];
    [self addSubview:nsv];
}

// setp ------------------------------------------------------------------------------------
- (void)set_p:(Meishi *)m{
    p_meishi = m;
    p_image.image = [m getIcon];
    [phv setText:[m getHString]];
    [pav setText:[m getAString]];
    [pbv setText:[m getBString]];
    [pcv setText:[m getCString]];
    [pdv setText:[m getDString]];
    [psv setText:[m getSString]];
}

// setn ------------------------------------------------------------------------------------
- (void)set_n:(Meishi *)m{
    if(m){
        n_meishi = m;
        n_image.image = [m getIcon];
        [nhv setText:[m getHString]];
        [nav setText:[m getAString]];
        [nbv setText:[m getBString]];
        [ncv setText:[m getCString]];
        [ndv setText:[m getDString]];
        [nsv setText:[m getSString]];
    }else{
        n_image.image = [UIImage imageNamed:@"outicon.png"];
    }
}

- (void)draw{
    p_image = [p_meishi getCenterImage];
    p_image.frame = CGRectMake(10, 10, 32, 48);
    [self addSubview:p_image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
