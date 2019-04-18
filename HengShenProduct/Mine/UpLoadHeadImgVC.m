//
//  ViewController.m
//  YYImageClipViewController
//
//  Created by 杨健 on 16/7/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "UpLoadHeadImgVC.h"
#import "YYImageClipViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface UpLoadHeadImgVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,YYImageClipDelegate>

Strong UIImageView *userHeadImg;

@end

@implementation UpLoadHeadImgVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBarHidden];
    [self configStatusBarLight];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self configNavigationBarShow];
    [self configStatusBarDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configView {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *leftItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItemBtn.backgroundColor = [UIColor clearColor];
    [leftItemBtn setImage:MACALKImage(@"back_white") forState:normal];
    [leftItemBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftItemBtn];
    [leftItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(StatusBarHeight);
        make.left.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(62, NavigationBarHeight));
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"个人头像";
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(leftItemBtn);
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
    
    UIImageView *userHeadImg = [[UIImageView alloc]init];
    [userHeadImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[DEFAULTS objectForKey:@"userPortraitUri"]]]];
    userHeadImg.backgroundColor = [UIColor redColor];
    [self.view addSubview:userHeadImg];
    [userHeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, ScreenWidth));
    }];
    self.userHeadImg = userHeadImg;
    
}

- (void)backBtnClick:(UIButton *)sender {
    sender.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreBtnClick {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectCameraOrPhoto:@"camera"];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectCameraOrPhoto:@"photo"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:camera];
    [actionSheet addAction:photo];
    [actionSheet addAction:cancel];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

//调用相机、相册
- (void)selectCameraOrPhoto:(NSString *)type {
    
    
    if ([type isEqualToString:@"camera"]) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                NSString *aleartMsg = @"请在\"设置 - 隐私 - 相机\"选项中，允许访问您的相机";
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:aleartMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [alert show];
                return;
            }
        }else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"您的手机暂不支持相机" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        // 创建UIImagePickerController实例
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        // 设置照片来源为相机
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置代理
        imagePickerController.delegate = self;
        // 展示选取照片控制器
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }else {
        
        // 创建UIImagePickerController实例
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        //图片选择是相册（图片来源自相册）
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置代理
        imagePickerController.delegate = self;
        // 展示选取照片控制器
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}


#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    YYImageClipViewController *imgCropperVC = [[YYImageClipViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
    imgCropperVC.delegate = self;
    [picker pushViewController:imgCropperVC animated:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - YYImageCropperDelegate
- (void)imageCropper:(YYImageClipViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.userHeadImg.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    [self configStatusBarLight];
}

- (void)imageCropperDidCancel:(YYImageClipViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
