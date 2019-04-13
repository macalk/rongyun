//
//  UpLoadUserHeadImgVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/13.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "UpLoadUserHeadImgVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>

@interface UpLoadUserHeadImgVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

Strong UIImageView *userHeadImg;

@end

@implementation UpLoadUserHeadImgVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBarHidden];
    [self configStatusBarLight];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self configNavigationBarShow];
    [self configStatusBarDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人头像";
    [self configView];
    
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
    userHeadImg.image = [UIImage imageNamed:@""];
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
        
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//                NSString *aleartMsg = @"请在\"设置 - 隐私 - 相机\"选项中，允许访问您的相机";
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:aleartMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//                [alert show];
//                return;
//            }
//        }else {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"您的手机暂不支持相机" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
        // 创建UIImagePickerController实例
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        // 设置照片来源为相机
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置代理
        imagePickerController.delegate = self;
        // 是否显示裁剪框编辑（默认为NO），等于YES的时候，照片拍摄完成可以进行裁剪
        imagePickerController.allowsEditing = YES;
        // 展示选取照片控制器
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else {

//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//
//            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//                if (status == ALAuthorizationStatusRestricted || status ==ALAuthorizationStatusDenied){
//                    NSString *aleartMsg = @"请在\"设置 - 隐私 - 照片\"选项中，允许访问您的相册";
//                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:aleartMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//                    [alert show];
//                    return;
//                }
//            }];
//
//        }
        // 创建UIImagePickerController实例
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        //图片选择是相册（图片来源自相册）
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 设置代理
        imagePickerController.delegate = self;
        // 是否显示裁剪框编辑（默认为NO），等于YES的时候，照片拍摄完成可以进行裁剪
        imagePickerController.allowsEditing = YES;
        // 展示选取照片控制器
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    /* 此处参数 info 是一个字典，下面是字典中的键值 （从相机获取的图片和相册获取的图片时，两者的info值不尽相同）
     * UIImagePickerControllerMediaType; // 媒体类型
     * UIImagePickerControllerOriginalImage; // 原始图片
     * UIImagePickerControllerEditedImage; // 裁剪后图片
     * UIImagePickerControllerCropRect; // 图片裁剪区域（CGRect）
     * UIImagePickerControllerMediaURL; // 媒体的URL
     * UIImagePickerControllerReferenceURL // 原件的URL
     * UIImagePickerControllerMediaMetadata // 当数据来源是相机时，此值才有效
     */
    // 从info中将图片取出，并加载到imageView当中
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.userHeadImg.image = image;
    //    // 创建保存图像时需要传入的选择器对象（回调方法格式固定）
    //    SEL selectorToCall = @selector(image:didFinishSavingWithError:contextInfo:);
    //    // 将图像保存到相册（第三个参数需要传入上面格式的选择器对象）
    //    UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
}

// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
