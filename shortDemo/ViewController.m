//
//  ViewController.m
//  shortDemo
//
//  Created by Zeus on 2017/10/10.
//  Copyright © 2017年 Zeus. All rights reserved.
//

#import "ViewController.h"
#import "TJVideoScrollController.h"
#import "ZFVideoModel.h"


#import <ZFPlayer.h>
@interface ViewController () <ZFPlayerDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong)ZFPlayerView *playerView;
@property(nonatomic, strong)ZFPlayerModel *playerModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     //[self requestData];
    
    _playerView = [[ZFPlayerView alloc] init];
    _playerView.delegate = self;
    _playerModel = [[ZFPlayerModel alloc] init];
    NSString *string = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    _playerModel.videoURL = [NSURL URLWithString:string];
    _playerModel.fatherView       = self.view;
    [_playerView playerControlView:nil playerModel:self.playerModel];
    // 自动播放
    [self.playerView autoPlayTheVideo];
    
    
    
    
}



- (IBAction)LunboAction:(id)sender {
//    TJVideoScrollController *vc = [[TJVideoScrollController alloc]init];
//    vc.dataList = self.dataSource;
//    vc.index = 1;
//    vc.videoModel = self.dataSource[1];
//    [self presentViewController:vc animated:YES completion:nil];
    
    
    
    
}


- (void)requestData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"videoData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.dataSource = @[].mutableCopy;
    NSArray *videoList = [rootDict objectForKey:@"videoList"];
    for (NSDictionary *dataDic in videoList) {
        ZFVideoModel *model = [[ZFVideoModel alloc] init];
        [model setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:model];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
