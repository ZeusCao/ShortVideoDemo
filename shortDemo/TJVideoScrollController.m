//
//  TJVideoScrollController.m
//  shortDemo
//
//  Created by Zeus on 2017/10/17.
//  Copyright © 2017年 Zeus. All rights reserved.
//

#import "TJVideoScrollController.h"
#import "TJVideoScrollView.h"
#import <ZFPlayer.h>

@interface TJVideoScrollController () <TJVideoScrollViewDelegate>

@property(nonatomic, strong)TJVideoScrollView *videoScrollView;
@property(nonatomic, strong) UIButton * closeButton;
@property(nonatomic, strong)ZFPlayerView *playerView;

@end

@implementation TJVideoScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self setupUI];
    [self setupPlayer];
    
}

- (void)setupUI
{
    [self.videoScrollView updateForLives:self.dataList withCurrentIndex:self.index];
    [self.view addSubview:self.videoScrollView];
}

- (void)setupPlayer
{
    self.playerView = [[ZFPlayerView alloc]init];
    self.playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    [self.view addSubview:self.playerView];
    self.playerView.videoURL = [NSURL URLWithString:self.videoModel.playUrl];
    NSLog(@"=====================%@",self.videoModel.playUrl);
    // 自动播放
    [self.playerView autoPlayTheVideo];
    
 
    
}

// 代理方法
- (void)videoScrollView:(TJVideoScrollView *)videoScrollView currentVideoIndex:(NSInteger)index
{
    if (self.index == index) {
        return;
    }
    else
    {
       
        ZFVideoModel *videoModel = self.dataList[index];
        self.playerView.videoURL = [NSURL URLWithString:videoModel.playUrl];
       [self.playerView resetToPlayNewURL];
        self.index = index;
    }
}


// 懒加载
- (TJVideoScrollView *)videoScrollView {
    if (_videoScrollView) {
        _videoScrollView = [[TJVideoScrollView alloc]initWithFrame:self.view.frame];
        _videoScrollView.videoDelegate = self;
        _videoScrollView.index = self.index;
    }
    return _videoScrollView;
}

-(UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        _closeButton.frame = CGRectMake(self.view.bounds.size.width-_closeButton.bounds.size.width-8, self.view.bounds.size.height-_closeButton.bounds.size.height-8, _closeButton.bounds.size.width, _closeButton.bounds.size.height);
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(void) closeAction: (UIButton *) button
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
