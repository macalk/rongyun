//
//  ScanVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/17.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "ScanVC.h"
#import <AVFoundation/AVFoundation.h>


@interface ScanVC ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

Strong AVCaptureSession *session;
Strong AVCaptureVideoDataOutput *videoDataOutput;
Strong AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation ScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self configView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)leftBarButtonAciton {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)configView {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建摄像设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建元数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 4、创建会话对象
    self.session = [[AVCaptureSession alloc] init];
    // 并设置会话采集率
    self.session.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    // 5、添加元数据输出流到会话对象
    [self.session addOutput:metadataOutput];
    
    // 创建摄像数据输出流并将其添加到会话对象上,  --> 用于识别光线强弱
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [self.videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [self.session addOutput:self.videoDataOutput];
    
    // 6、添加摄像设备输入流到会话对象
    [self.session addInput:deviceInput];
    
    // 7、设置数据输出类型(如下设置为条形码和二维码兼容)，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 8、实例化预览图层, 用于显示会话对象
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    // 保持纵横比；填充层边界
    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];
    
    // 9、启动会话
    [self.session startRunning];
    
    //扫描有效区域
    CGRect intertRect = [self.videoPreviewLayer metadataOutputRectOfInterestForRect:CGRectMake(ScreenWidth/2-122, ScreenHeight/2-122, 244, 244)];
    CGRect layerRect = [self.videoPreviewLayer rectForMetadataOutputRectOfInterest:intertRect];
    NSLog(@"%@,   %@",NSStringFromCGRect(intertRect),NSStringFromCGRect(layerRect));
    metadataOutput.rectOfInterest = intertRect;
    
    //绘制背景
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:maskView];
    
    //绘制镂空
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [maskPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(ScreenWidth/2-122, ScreenHeight/2-122, 244, 244) cornerRadius:1] bezierPathByReversingPath]];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskView.layer.mask = maskLayer;
    
    
    UIButton *leftItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItemBtn.backgroundColor = [UIColor clearColor];
    [leftItemBtn setImage:MACALKImage(@"back_white") forState:normal];
    [leftItemBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftItemBtn];
    [leftItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(StatusBarHeight);
        make.left.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(62, NavigationBarHeight));
    }];
    
    UIButton *rightItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemBtn.backgroundColor = [UIColor clearColor];
    [rightItemBtn setImage:MACALKImage(@"more") forState:normal];
    [rightItemBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightItemBtn];
    [rightItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(StatusBarHeight);
        make.right.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(62, NavigationBarHeight));
    }];

    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:MACALKImage(@"img_sm")];
    imageView.frame = CGRectMake(ScreenWidth/2-122, ScreenHeight/2-122, 244, 244);
    [self.view addSubview:imageView];
    
    UIImageView *lineImg = [[UIImageView alloc]initWithImage:MACALKImage(@"img_line")];
    lineImg.frame = CGRectMake(0, 5, 304, 12);
    [imageView addSubview:lineImg];
    /* 添加动画 */
    [UIView animateWithDuration:1.6 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
        lineImg.frame = CGRectMake(0, 244-10, 304, 12);
        NSLog(@"111");
    } completion:^(BOOL finished) {
        
    }];
    
    CommonLabel *subLable = [[CommonLabel alloc]initWithText:@"将二维码放入框内，即可自动扫描" font:14 textColor:@"ffffff"];
    subLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:subLable];
    [subLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).with.offset(30);
    }];
    
    CommonLabel *tit = [[CommonLabel alloc]initWithText:@"我的二维码" font:15 textColor:@"ffffff"];
    tit.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tit];
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(subLable.mas_bottom).with.offset(30);
    }];
    
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick {
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSString *url = [obj stringValue];
        NSLog(@"%@",url);
        [self.session stopRunning];
        
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

@end
