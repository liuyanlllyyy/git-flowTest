//
//  ViewController.m
//  test
//
//  Created by Yan on 2018/5/26.
//  Copyright © 2018 Yanni. All rights reserved.
//

#import "ViewController.h"
#import "OTScreenshotHelper.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//   WKWebView * webbiew = [WKWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen], <#CGFloat height#>)
    self.webview.delegate = self;
    //这里是修改的新特性 开发的版本
    
             NSString * urlStr = [NSString stringWithFormat:@"http://192.168.10.87:8083/views/activity.html"];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"activity" ofType:@"html"];
//    NSURL *fileURL = [[NSURL alloc] initWithString:filePath];
//    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"activity.html" withExtension:nil];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    
        NSURL *url = [NSURL URLWithString:urlStr];
    
        // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
        // 3. 发送请求给服务器
        [self.webview loadRequest:request];
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0/*延迟执行时间*/ * NSEC_PER_SEC));
//
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//
//
//    });
//    [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  
}

#pragma mark  JS 调取的方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    __weak typeof(self) weakSelf = self;
    JSContext *context = [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    context[@"screenShoot"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *screenShot = [OTScreenshotHelper screenshotWithStatusBar:YES];
                    //
                    [weakSelf saveImageToPhotos:screenShot];
//            str = @"success";
        });
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
        }
        
        NSLog(@"-------End Log-------");
    };
}

//- (IBAction)touch:(id)sender {
//     UIImage *screenShot = [OTScreenshotHelper screenshotWithStatusBar:YES];
//
//    [self saveImageToPhotos:screenShot];
//    
//}
- (void)saveImageToPhotos:(UIImage*)savedImage
{
    
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        
        NSLog(@"存入手机相册成功");
        
    }else{
        
        NSLog(@"存入手机相册失败");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
