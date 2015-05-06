//
//  PAPickView.m
//  time
//
//  Created by zuo on 15/4/2.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "PAPickView.h"
#import "UIButton+Button.h"
#import <QuartzCore/QuartzCore.h>
@interface PAPickView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) UIPickerView *locatePicker;
@property (nonatomic ,weak) UIView *toolBar;
@property (nonatomic ,strong)NSMutableArray *provinces;
@property (nonatomic ,strong)NSMutableArray *cities;
@property (nonatomic ,strong)NSMutableArray *areas;
@end
@implementation PAPickView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _location =[[PALocation alloc]init];
        
        UIView *toolBar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        toolBar.userInteractionEnabled = YES;
        toolBar.backgroundColor = [UIColor blueColor];
        [self addSubview:toolBar];

        UIButton * cancel =[UIButton addTarget:self WithNorTitle:@"取消" withNorColor:[UIColor whiteColor] withSelectedTitle:@"取消" withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor clearColor] withTileSize:font(16) action:@selector(cancel:)];
        cancel.tag = 1000;
        cancel.frame =CGRectMake(10, 0, cancel.bounds.size.width, 44);
        [toolBar addSubview:cancel];
        
        UIButton * confirm =[UIButton addTarget:self WithNorTitle:@"确定" withNorColor:[UIColor whiteColor] withSelectedTitle:@"确定" withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor clearColor] withTileSize:font(16) action:@selector(confirm:)];
        confirm.tag = 1001;
        confirm.frame =CGRectMake(SCREEN_WIDTH -cancel.bounds.size.width-10, 0, cancel.bounds.size.width, 44);
        [toolBar addSubview:confirm];
        
        UIPickerView *pickView =[[UIPickerView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(cancel.frame), SCREEN_WIDTH, 216)];
        pickView.delegate = self;
        pickView.dataSource =self;
        [self addSubview:pickView];
        _locatePicker = pickView;
        
        
        _provinces = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
        _cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
        
        self.location.state = [[_provinces objectAtIndex:0] objectForKey:@"state"];
        self.location.city = [[_cities objectAtIndex:0] objectForKey:@"city"];
        
        _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
        if (_areas.count > 0) {
            self.location.district = [_areas objectAtIndex:0];
        } else{
            self.location.district = @"";
        }

    }
    return self;
}

- (void)setPAPickViewBlock:(PAPickViewBlock)block
{
    _block = block;
    
}
- (void)confirm:(UIButton *)btn{
    if (_block) {
        _block(btn.tag);
    }
}
- (void)cancel:(UIButton *)btn{
    if (_block) {
        _block(btn.tag);
    }
}
#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [_provinces count];
            break;
        case 1:
            return [_cities count];
            break;
        case 2:
            return [_areas count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[_provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[_cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([_areas count] > 0) {
                return [_areas objectAtIndex:row];
                break;
            }
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            _cities = [[_provinces objectAtIndex:row] objectForKey:@"cities"];
            [self.locatePicker selectRow:0 inComponent:1 animated:NO];
            [self.locatePicker reloadComponent:1];
            _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
            [self.locatePicker selectRow:0 inComponent:2 animated:YES];
            [self.locatePicker reloadComponent:2];
            
            self.location.state = [[_provinces objectAtIndex:row] objectForKey:@"state"];
            self.location.city = [[_cities objectAtIndex:0] objectForKey:@"city"];
            if ([_areas count] > 0) {
                self.location.district = [_areas objectAtIndex:0];
            } else{
                self.location.district = @"";
            }

            break;
        case 1:
            self.location.city = [[_cities objectAtIndex:row] objectForKey:@"city"];
            _areas = [[_cities objectAtIndex:row] objectForKey:@"areas"];
            [self.locatePicker selectRow:0 inComponent:2 animated:NO];
            [self.locatePicker reloadComponent:2];
            self.location.latitude = [[[_cities objectAtIndex:row] objectForKey:@"lat"] doubleValue];
            self.location.longitude = [[[_cities objectAtIndex:row] objectForKey:@"lon"] doubleValue];
            break;
        case 2:
            if ([_areas count] > 0) {
                self.location.district = [_areas objectAtIndex:row];
            } else{
                self.location.district = @"";
            }
            break;
        default:
            break;
    }
}

#pragma mark - animation

- (void)showInView:(UIView *) view
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
//                         [self removeFromSuperview];
                         
                     }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
