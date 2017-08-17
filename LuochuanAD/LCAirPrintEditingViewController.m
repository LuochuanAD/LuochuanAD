//
//  LCAirPrintEditingViewController.m
//  LuochuanAD
//
//  Created by care on 17/5/17.
//  Copyright © 2017年 luochuan. All rights reserved.
//

#import "LCAirPrintEditingViewController.h"
#import "YYText.h"
#import "YYImage.h"
#import "UIImage+YYWebImage.h"
#import "UIView+YYAdd.h"
#import "NSBundle+YYAdd.h"
#import "NSString+YYAdd.h"
#import "UIControl+YYAdd.h"
#import "CALayer+YYAdd.h"
#import "NSData+YYAdd.h"
#import "UIGestureRecognizer+YYAdd.h"

#import "WNImagePicker.h"
#import "WNImapgePicker/ImageEditVC.h"

#import "SuPhotoPicker.h"
@interface LCAirPrintEditingViewController ()<UIPrintInteractionControllerDelegate,YYTextViewDelegate,YYTextKeyboardObserver,WNImagePickerDelegate>
@property (strong, nonatomic)YYTextView *textView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UISwitch *verticalSwitch;
@property (nonatomic, strong) UISwitch *debugSwitch;
@property (nonatomic, strong) UISwitch *exclusionSwitch;

@end

@implementation LCAirPrintEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 100, 30);
    [button setTitle:@"添加图片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addImageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setTintColor:[UIColor greenColor]];
    self.navigationItem.titleView=button;
    
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(printTextView)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the season of light, it was the season of darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us. We were all going direct to heaven, we were all going direct the other way.\n\n这是最好的时代，这是最坏的时代；这是智慧的时代，这是愚蠢的时代；这是信仰的时期，这是怀疑的时期；这是光明的季节，这是黑暗的季节；这是希望之春，这是失望之冬；人们面前有着各样事物，人们面前一无所有；人们正在直登天堂，人们正在直下地狱。"];
    text.yy_font = [UIFont fontWithName:@"Times New Roman" size:20];
    text.yy_lineSpacing = 4;
    text.yy_firstLineHeadIndent = 20;
    
    self.textView = [[YYTextView alloc]init];
    self.textView.attributedText = text;
    self.textView.size = self.view.size;
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.textView.delegate = self;
    if (kiOS7Later) {
        self.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    } else {
        self.textView.height -= 64;
    }
    self.textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.textView.scrollIndicatorInsets = self.textView.contentInset;
    self.textView.selectedRange = NSMakeRange(text.length, 0);
    [self.view addSubview:self.textView];
    
    self.textView.verticalForm=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });

    
    
}

- (void)initImageViewWithFileData:(NSData *)ImageData {
    
    NSData *data = ImageData;
    UIImage *image = [[YYImage alloc] initWithData:data scale:2];
    self.imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    self.imageView.clipsToBounds = YES;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.layer.cornerRadius = self.imageView.bounds.size.height / 2;
    self.imageView.center = CGPointMake(WINDOWS.width / 2, WINDOWS.height / 2);
    
    
    
    __weak typeof(self) _self = self;
    UIPanGestureRecognizer *g = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(UIPanGestureRecognizer *g) {
        __strong typeof(_self) self = _self;
        if (!self) return;
        CGPoint p = [g locationInView:self.textView];
        self.imageView.center = p;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.imageView.frame
                                                        cornerRadius:self.imageView.layer.cornerRadius];
        self.textView.exclusionPaths = @[path];
    }];
    [self.imageView addGestureRecognizer:g];
    [self.textView addSubview:self.imageView];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.imageView.frame
                                                    cornerRadius:self.imageView.layer.cornerRadius];
    self.textView.exclusionPaths = @[path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSURL *url=[[NSBundle mainBundle]URLForResource:@"dribbble256_imageio.png" withExtension:nil];
//    NSData *data=[NSData dataWithContentsOfURL:url];
    //[self initImageViewWithFileData:data];
}


- (void)printInteractionControllerWillPresentPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Will Present");
}

- (void)printInteractionControllerDidPresentPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Did Present");
}

- (void)printInteractionControllerWillDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Will Dismiss");
}

- (void)printInteractionControllerDidDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Did Dismiss");
}

- (void)printInteractionControllerWillStartJob:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Will Start Job");
}

- (void)printInteractionControllerDidFinishJob:(UIPrintInteractionController *)printInteractionController
{
    NSLog(@"Print Interaction Controller Did Finish Job");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)printTextView{
    [self.textView resignFirstResponder];
    
    UIPrintInteractionController *print=[UIPrintInteractionController sharedPrintController];
    print.delegate=self;
    UIPrintInfo *printInfo=[UIPrintInfo printInfo];
    printInfo.outputType=UIPrintInfoOutputGeneral;//文本,图像和图片的混合
    printInfo.jobName=@"Print for iOS";//打印任务
    printInfo.duplex=UIPrintInfoDuplexLongEdge;
    print.printInfo=printInfo;
    print.showsPageRange=YES;
    
    UISimpleTextPrintFormatter *textFormatter=[[UISimpleTextPrintFormatter alloc]initWithText:self.textView.text];
    textFormatter.startPage=0;
    textFormatter.contentInsets=UIEdgeInsetsMake(36.0, 36.0, 36.0, 36.0);
    textFormatter.maximumContentWidth=540;
    print.printFormatter=textFormatter;
    //错误处理
    void (^completionHandler)(UIPrintInteractionController *,BOOL,NSError *)=^(UIPrintInteractionController *print,BOOL completed,NSError *error){
        if (!completed&&error) {
            NSLog(@"======================airPrint Error!");
        }
    };
    [print presentAnimated:YES completionHandler:completionHandler];
}



- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    BOOL clipped = NO;
    if (_textView.isVerticalForm && transition.toVisible) {
        CGRect rect = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
        if (CGRectGetMaxY(rect) == self.view.height) {
            CGRect textFrame = self.view.bounds;
            textFrame.size.height -= rect.size.height;
            _textView.frame = textFrame;
            clipped = YES;
        }
    }
    
    if (!clipped) {
        _textView.frame = self.view.bounds;
    }
}
- (void)addImageButtonClicked{
    WNImagePicker *pickerVC  = [[WNImagePicker alloc]init];
    pickerVC.delegate = self;
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:pickerVC];
    [self presentViewController:navVC animated:YES completion:nil];

//    __weak typeof(self) weakSelf = self;
//    SuPhotoPicker * picker = [[SuPhotoPicker alloc]init];
//        picker.selectedCount = 1;
//        picker.preViewCount = 20;
//    [picker showInSender:self.tabBarController handle:^(NSArray<UIImage *> *photos) {
//        [weakSelf showSelectedPhotos:photos];
//    }];
}
- (void)showSelectedPhotos:(NSArray *)imgs {
    if (imgs.count==1) {
        UIImage *img=[imgs firstObject];
        
        NSData *data=UIImagePNGRepresentation(img);
        
        [self initImageViewWithFileData:data];
    }
    
    
    
}
#pragma mark -- WNImagePickerDelegate
- (void)getCutImage:(UIImage *)image controller:(WNImagePicker *)vc
{
    [vc.navigationController dismissViewControllerAnimated:NO completion:nil];
//    ImageEditVC *editVC = [[ImageEditVC alloc]init];
//    editVC.image = image;
//    [self.navigationController pushViewController:editVC animated:YES];
    NSData *data=UIImagePNGRepresentation(image);
    
    [self initImageViewWithFileData:data];
}

- (void)onCancel:(WNImagePicker *)vc
{
    [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
