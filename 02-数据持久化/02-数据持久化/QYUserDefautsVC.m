//
//  QYUserDefautsVC.m
//  02-数据持久化
//
//  Created by qingyun on 15/8/6.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYUserDefautsVC.h"

@interface QYUserDefautsVC ()
@property (weak, nonatomic) IBOutlet UISwitch *toggle;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *progressTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation QYUserDefautsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    NSLog(@"%@", NSHomeDirectory());
}

- (void)loadData
{
    // 1. 获取NSUserDefaults单例对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _toggle.on = [defaults boolForKey:@"switch"];
    
    _progressView.progress = [defaults floatForKey:@"progress"];
    
    _label.text = [defaults stringForKey:@"input"];
}

- (IBAction)saveData:(UIBarButtonItem *)sender {
    // 1. 获取NSUserDefaults单例对象
    /**
     1. 该单例对象封装了对plist文件的读写操作，可以对每个字段单独读写
     2. 该plist文件在系统的Library/Preferences目录下，名字为<<Bundle Identify.plist>>
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 2. 写操作
    // 将开关的值记录到plist文件中，键为"switch"
    [defaults setBool:_toggle.on forKey:@"switch"];
    
    // 将进度值文本框的内容记录到plist文件中，键为"progress"
    NSString *progress = _progressTextField.text;
    float progressValue = [progress floatValue];
    [defaults setFloat:progressValue forKey:@"progress"];
    
    // 将输入文本框的内容记录到plist文件中，键位"input"
    [defaults setObject:_inputTextField.text forKey:@"input"];
    
    // 3. 将内存中的配置值，刷新到plist文件中
    [defaults synchronize];
}

- (IBAction)textFieldDidEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}
@end






















