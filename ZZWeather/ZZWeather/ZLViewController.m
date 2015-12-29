//
//  ZLViewController.m
//  ZZWeather
//
//  Created by 张亮 on 15/12/30.
//  Copyright © 2015年 张亮. All rights reserved.
//

#import "ZLViewController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
@interface ZLViewController()
@property (nonatomic ,strong) UIImageView *backgroudImage;
@property (nonatomic ,strong) UIImageView *blueredImageView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) CGFloat screenH;
@end
@implementation ZLViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.screenH = [UIScreen mainScreen].bounds.size.height;
    UIImage *background = [UIImage imageNamed:@"bg"];
    
    self.backgroudImage = [[UIImageView alloc] initWithImage:background];
    self.backgroudImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroudImage];
    
    self.blueredImageView = [UIImageView new];
    self.blueredImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blueredImageView.alpha = 0;
    [self.blueredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blueredImageView];
    
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    
    
//    *************************
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    CGFloat inset = 20;
    
    CGFloat temperatureHeight = 110;
    CGFloat hiloHeight = 40;
    CGFloat iconHeight = 30;
    
    CGRect hiloFrame = CGRectMake(inset, headerFrame.size.height - hiloHeight, headerFrame.size.width - (2 * inset), hiloHeight);
    CGRect temperatureFrame = CGRectMake(inset, headerFrame.size.height - (temperatureHeight + hiloHeight), headerFrame.size.width - (2 * inset), temperatureHeight);
    CGRect iconFrame = CGRectMake(inset, temperatureFrame.origin.y - iconHeight, iconHeight, iconHeight);
    
    
    CGRect conditionsFrame = iconFrame;
    conditionsFrame.size.width = self.view.bounds.size.width - (((2 * inset) + iconHeight) + 10);
    conditionsFrame.origin.x = iconFrame.origin.x + (iconHeight + 10);
//    **************************
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView =header;
    
    UILabel *temperatureLable = [[UILabel alloc] initWithFrame:temperatureFrame];
    temperatureLable.backgroundColor = [UIColor clearColor];
    temperatureLable.textColor = [UIColor whiteColor];
    temperatureLable.text = @"0°";
    temperatureLable.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    [header addSubview:temperatureLable];
    
    
    UILabel *hiloLable = [[UILabel alloc] initWithFrame:hiloFrame];
    hiloLable.backgroundColor = [UIColor clearColor];
    hiloLable.textColor = [UIColor whiteColor];
    hiloLable.text = @"0° / 0°";
    hiloLable.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    [header addSubview:hiloLable];
    
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.text = @"Loading...";
    cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cityLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:cityLabel];
    
    UILabel *conditionsLabel = [[UILabel alloc] initWithFrame:conditionsFrame];
    conditionsLabel.backgroundColor = [UIColor clearColor];
    conditionsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    conditionsLabel.textColor = [UIColor whiteColor];
    [header addSubview:conditionsLabel];
    
//
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:iconFrame];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.backgroundColor = [UIColor clearColor];
    [header addSubview:iconView];

    
    
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    self.backgroudImage.frame = bounds;
    self.blueredImageView.frame = bounds;
    self.tableView.frame = bounds;

}


// 1
#pragma mark - UITableViewDataSource

// 2
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO: Return count of forecast
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // 3
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    // TODO: Setup the cell
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Determine cell height based on screen
    return 44;
}

@end
