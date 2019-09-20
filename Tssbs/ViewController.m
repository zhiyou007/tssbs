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
    
    //标题
    //_lb_title = [[UILabel init] alloc];
    
    //转圈动画
    //http://www.code4app.com/thread-32109-1-1.html
    
    
    //参考 https://www.jianshu.com/p/badee2350860
    
    NSString *content = @"功盖三分国，名成八阵图。\n江流石不转，遗恨失吞吴。";
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"功盖三分国，名成八阵图。\n江流石不转，遗恨失吞吴。"];
//
//    //修改行间距
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//
//    [paragraphStyle setLineSpacing:18];
//
//    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
//
//    // 调整字间距
//    long number = 1.5;
//    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
//    [str addAttribute:NSParagraphStyleAttributeName value:num range:NSMakeRange(0,[str length])];
    
    
    

    
    
    
    
    
    _lb_content = [[UILabel alloc] init];
    //换行设置
    _lb_content.numberOfLines = 0;
    _lb_content.lineBreakMode = NSLineBreakByWordWrapping;
    _lb_content.preferredMaxLayoutWidth=kScreenWidth-100;
    
    [_lb_content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.view addSubview:_lb_content];
    
    [self.lb_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    
    
//    //富文本样式
//    NSMutableDictionary *txtDict = [NSMutableDictionary dictionary];
//    //字体颜色
//    txtDict[NSForegroundColorAttributeName] = [UIColor blackColor];
//    //字号大小
//    txtDict[NSFontAttributeName] = [UIFont systemFontOfSize:28.0];
//
//    //段落样式
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//    paraStyle.lineSpacing = 10.0f;
//    paraStyle.firstLineHeadIndent = 20.0;
//
//    txtDict[NSParagraphStyleAttributeName] = paraStyle;
//
//    //字间距
//
//    txtDict[NSKernAttributeName] = @(6);
//
//    //赋值
//    _lb_content.attributedText = [[NSAttributedString alloc] initWithString:content attributes:txtDict];
    
    
    _lb_content.attributedText = [self getAttributedString:content fontSize:28.0f fontColor:[UIColor blackColor] isbold:NO];
    
    
    

    
    
    _lb_author = [[UILabel alloc] init];
    [self.view addSubview:_lb_author];
    [self.lb_author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lb_content.mas_top).offset(-20);
        make.centerX.equalTo(self.view);
    }];
    
    self.lb_author.attributedText = [self getAttributedString:@"唐代：杜甫" fontSize:20.0f fontColor:[UIColor darkGrayColor] isbold:NO];
    
    
    _lb_title = [[UILabel alloc] init];
    
    [self.view addSubview:_lb_title];
    [_lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(self.view.mas_left).offset(0);
        //        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.bottom.mas_equalTo(self.lb_author.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.view);
    }];
    self.lb_title.attributedText = [self getAttributedString:@"八阵图" fontSize:35.0f fontColor:[UIColor blackColor] isbold:YES];
    
}


- (NSAttributedString *)getAttributedString:(NSString *)str fontSize:(float)fontsize fontColor:(UIColor *)fontcolor isbold:(Boolean)isBold{
    
    //富文本样式
    NSMutableDictionary *txtDict = [NSMutableDictionary dictionary];
    //字体颜色
    txtDict[NSForegroundColorAttributeName] = fontcolor;
    
    //字号大小
    if(isBold)
    {
       txtDict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:fontsize];
    }else{
        txtDict[NSFontAttributeName] = [UIFont systemFontOfSize:fontsize];
    }

    
    //段落样式
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 20.0f;
    paraStyle.firstLineHeadIndent = 20.0;
    
    txtDict[NSParagraphStyleAttributeName] = paraStyle;
    
    //字间距
    
    txtDict[NSKernAttributeName] = @(6);
    NSAttributedString* attStr = [[NSAttributedString alloc] initWithString:str attributes:txtDict];
    return attStr;
}




@end
