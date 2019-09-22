//
//  ViewController.m
//  Tssbs
//
//  Created by flari on 2019/9/19.
//  Copyright © 2019 flari. All rights reserved.
//

#import "ViewController.h"
#import "iflyMSC/IFlyMSC.h"
@interface ViewController ()<IFlySpeechSynthesizerDelegate>
{
    
}

@property (nonatomic,strong)UILabel *lb_title;
@property (nonatomic,strong)UILabel *lb_author;
@property (nonatomic,strong)UILabel *lb_content;
@property (nonatomic,strong)UIImageView *iv_speech;
@property (nonatomic,strong)CAEmitterLayer *emitter;
@property (nonatomic,assign)BOOL isSpeech;
@property (nonatomic,assign)NSString *content;
@property (nonatomic,assign)NSString *mTitle;
@property (nonatomic,assign)NSString *author;
@property (nonatomic,strong)IFlySpeechSynthesizer *iFlySpeechSynthesizer;
@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isSpeech = false;
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    
    //标题
    //_lb_title = [[UILabel init] alloc];
    
    //转圈动画
    //http://www.code4app.com/thread-32109-1-1.html
    
    
    //参考 https://www.jianshu.com/p/badee2350860
    
    
    //self.view.backgroundColor = [UIColor redColor];
    _mTitle = @"八阵图";
    _author = @"唐代 杜甫";
    _content = @"功盖三分国，名成八阵图。\n江流石不转，遗恨失吞吴。";
    
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
    
    
    _lb_content.attributedText = [self getAttributedString:_content fontSize:28.0f fontColor:[UIColor blackColor] isbold:NO];
    
    
    

    
    
    _lb_author = [[UILabel alloc] init];
    [self.view addSubview:_lb_author];
    [self.lb_author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lb_content.mas_top).offset(-20);
        make.centerX.equalTo(self.view);
    }];
    
    self.lb_author.attributedText = [self getAttributedString:_author fontSize:20.0f fontColor:[UIColor darkGrayColor] isbold:NO];
    
    
    _lb_title = [[UILabel alloc] init];
    
    [self.view addSubview:_lb_title];
    [_lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(self.view.mas_left).offset(0);
        //        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.bottom.mas_equalTo(self.lb_author.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.view);
    }];
    self.lb_title.attributedText = [self getAttributedString:_mTitle fontSize:35.0f fontColor:[UIColor blackColor] isbold:YES];
    
    _iv_speech = [[UIImageView alloc] init];
    [_iv_speech setImage:[UIImage imageNamed:@"laba"]];
    [self.view addSubview:_iv_speech];
    [_iv_speech mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-60);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
    }];
    
    _iv_speech.userInteractionEnabled = YES;
    //初始化一个手势
//    UIGestureRecognizer *singleTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //为图片添加手势
    [_iv_speech addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSpeech)]];
    
    //[self starEmitter];
    
    
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    
    
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //设置音量，取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50"
                                  forKey: [IFlySpeechConstant VOLUME]];
    //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@"xiaoxin"
                                  forKey: [IFlySpeechConstant VOICE_NAME]];
    //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
    [_iFlySpeechSynthesizer setParameter:@"tts.pcm"
                                  forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    
    
    
}

- (void)clickSpeech{
    
    _isSpeech = !_isSpeech;
    
    if(_iFlySpeechSynthesizer.isSpeaking)
    {
        [_iFlySpeechSynthesizer resumeSpeaking];
    }else{
        
        NSString * str = [NSString stringWithFormat:@"%@###%@###%@", _mTitle, _author,_content];
        
        [_iFlySpeechSynthesizer startSpeaking:str];
    }
    
    
    
    
    
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


- (void)starEmitter{
    if(!_emitter){
        _emitter = [[CAEmitterLayer alloc]init];
        _emitter.zPosition = 101;
        // 2.设置发射器的位置
        _emitter.emitterPosition = CGPointMake(66,44);
        
        // 3.开启三维效果--可以关闭三维效果看看
        _emitter.preservesDepth = YES;
        
        // 4.创建粒子, 并且设置粒子相关的属性
        // 4.1.创建粒子Cell
        CAEmitterCell *cell = [[CAEmitterCell alloc]init];
        
        // 4.2.设置粒子速度
        cell.velocity = 30;
        //速度范围波动50到250
        cell.velocityRange = 20;
        
        // 4.3.设置粒子的大小
        //一般我们的粒子大小就是图片大小， 我们一般做个缩放
        cell.scale = 0.1;
        
        //粒子大小范围: 0.4 - 1 倍大
        cell.scaleSpeed = 0.3;
        
        // 4.4.设置粒子方向
        //这个是设置经度，就是竖直方向 --具体看我们下面图片讲解
        //这个角度是逆时针的，所以我们的方向要么是 (2/3 π)， 要么是 (-π)
        cell.emissionLongitude = - M_PI * 1/5;
        cell.emissionRange = M_PI_2 / 2;//发射范围
        
        // 4.5.设置粒子的存活时间
        cell.lifetime =2.3;
        cell.lifetimeRange = 0.7;
        // 4.6.设置粒子旋转
        cell.spin = M_PI_2/4;
        cell.spinRange = M_PI_2 / 4;
        // 4.6.设置粒子每秒弹出的个数
        cell.birthRate = 1;
        
        // 4.7.设置粒子展示的图片 --这个必须要设置为CGImage
        cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"yinfu"].CGImage);
        // 5.将粒子设置到发射器中--这个是要放个数组进去
        _emitter.emitterCells = @[cell];
        
    }
    
    [_iv_speech.layer addSublayer:_emitter];
    
}

- (void)stopEmitter{
    
    [_emitter removeFromSuperlayer];
    _isSpeech = false;
}

//合成结束
- (void) onCompleted:(IFlySpeechError*) error
{
    NSLog(@"------------onCompleted");

    [self stopEmitter];
    _isSpeech = false;

    
}
//合成开始
- (void) onSpeakBegin {
    NSLog(@"------------onSpeakBegin");
    
    if(_isSpeech)
    {
        [self starEmitter];
    }
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg {
    //NSLog(@"onBufferProgress:--%d -- %@ ",progress,msg);
}
//合成播放进度
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos {
    //NSLog(@"onSpeakProgress:--%d -- %d  -- %d",progress,beginPos,endPos);
}

@end
