//
//  ViewController.m
//  Tssbs
//
//  Created by flari on 2019/9/19.
//  Copyright © 2019 flari. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
}

@property (nonatomic,strong)UILabel *lb_title;
@property (nonatomic,strong)UILabel *lb_author;
@property (nonatomic,strong)UILabel *lb_content;


@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"绣面芙蓉一笑开，\n斜飞宝鸭衬香腮。\n眼波才动被人猜。\n一面风情深有韵，\n半笺娇恨寄幽怀。\n月移花影约重来。"];
    
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14]  range:NSMakeRange(0, str.length)];
//    CGSize maxSize = CGSizeMake(kWidth - 40,MAXFLOAT);
//    self.attrStrSize = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(width,10000.0f)lineBreakMode:UILineBreakModeWordWrap];

    
    
    
    _lb_content = [[UILabel alloc] init];
    _lb_content.numberOfLines = 0;
    //_lb_content.text = @"";
    _lb_content.lineBreakMode = NSLineBreakByWordWrapping;
    _lb_content.attributedText = str;
    _lb_content.font=[UIFont systemFontOfSize:14];
    _lb_content.preferredMaxLayoutWidth=self.view.frame.size.width-100;
    [_lb_content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.view addSubview:_lb_content];
    
    [self.lb_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    
}


@end
