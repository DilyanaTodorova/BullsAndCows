//
//  MMMainViewController.m
//  BullsAndCows
//
//  Created by Dilyana Todorova on 12/7/12.
//  Copyright (c) 2012 Dilyana Todorova. All rights reserved.
//

#import "MMMainViewController.h"
#include <stdlib.h>

#define SHIFFER_NUMBERS 4
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MMMainViewController (){
    NSMutableArray * _secretNumbers;
    int cowCounts;
    int bullCounts;
}
@property(nonatomic, weak) IBOutlet UIPickerView * numberChooser;
@property(nonatomic, weak) IBOutlet UIButton * checkNumberCombinationButton;
@property(nonatomic, weak) IBOutlet UITextView * resultView;
@property(nonatomic, strong) NSArray * secretNumbers;
@property(nonatomic, strong) NSMutableString * currentCombination;
@property(nonatomic, strong) NSMutableString * statistics;
@end

@implementation MMMainViewController
@synthesize numberChooser, checkNumberCombinationButton, resultView;
@synthesize currentCombination = _currentCombination;
@synthesize secretNumbers = _secretNumbers;
@synthesize statistics = _statistics;

-(NSMutableString *) currentCombination{
    if (_currentCombination) {
        return _currentCombination;
    }
    
    _currentCombination = [[NSMutableString alloc] initWithCapacity:15];
    return _currentCombination;
}

- (NSMutableString *) statistics{
    if(_statistics){
        return _statistics;
    }
    _statistics = [[NSMutableString alloc] initWithCapacity:20];
    return _statistics;
}
#pragma mark - view lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.resultView.backgroundColor = UIColorFromRGB(0xC58E4B);
    self.resultView.textColor = UIColorFromRGB(0x3B2C31);
    self.view.backgroundColor = UIColorFromRGB(0xAA3D38);
    self.checkNumberCombinationButton.backgroundColor = UIColorFromRGB(0x818866);
    [self startGame];
}

#pragma mark - system messages
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.numberChooser = nil;
    self.checkNumberCombinationButton = nil;
    self.resultView = nil;
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(MMFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}
#pragma mark - uipickerview data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 9;
}
#pragma mark - uipickerview delegate
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d", row + 1];
}
- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel * numberLabel = (UILabel *) view;
    if (!numberLabel) {
        CGRect frame = CGRectMake(0, 0, 25.0f, 45.0f);
        numberLabel = [[UILabel alloc] initWithFrame:frame];
        numberLabel.font = [UIFont fontWithName:@"ChunkFive" size:30.0f];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = UIColorFromRGB(0xAA3D38);
        
    }
   
    numberLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return numberLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 45.0f;
}
#pragma mark - actions
- (IBAction)checkNumberCombination:(UIButton *)sender{
    bullCounts = 0;
    cowCounts = 0;
    NSNumber * selectedNumber = nil;
    for (int index = 0; index < SHIFFER_NUMBERS; index++) {
        int selectedRow = [self.numberChooser selectedRowInComponent:index];
        NSString * selectedNumberAsString = [self pickerView:self.numberChooser titleForRow:selectedRow forComponent:index];
        selectedNumber = [ NSNumber numberWithInt:[selectedNumberAsString intValue] ];
        [self.currentCombination appendFormat:@"%@",selectedNumber];
        if ([selectedNumber isEqualToNumber:[self.secretNumbers objectAtIndex:index]]) {
            bullCounts++;
            cowCounts--;
        }
    }
    
    if ([self.secretNumbers containsObject:selectedNumber]) {
        cowCounts++;
    }
    
    [self appendResult];
    if(bullCounts == SHIFFER_NUMBERS){
        [self winGame];
    }
}

- (IBAction)restartGame:(id)sender{
    [self startGame];
}
#pragma mark - game controll
- (void) startGame{
    NSRange statisticsRange = NSMakeRange(0, self.statistics.length);
    [self.statistics replaceCharactersInRange:statisticsRange withString:@""];
    [self showResult];
    _secretNumbers = [[NSMutableArray alloc] initWithCapacity:4];
    for (int index = 0; index < SHIFFER_NUMBERS; index++) {
        int rowedNumber = arc4random_uniform(8) + 1;
        [_secretNumbers addObject:[NSNumber numberWithInt:rowedNumber]];
    }
    
    bullCounts = 0;
    cowCounts = 0;
}
- (void) appendResult{
    [self.statistics appendFormat:@"%@ - %d cows, %d bulls\n", self.currentCombination, cowCounts, bullCounts];
    NSRange numbersRange = NSMakeRange(0, SHIFFER_NUMBERS);
    if (numbersRange.location != NSNotFound) {
        [self.currentCombination replaceCharactersInRange:numbersRange withString:@""];
    }
    
    [self showResult];
}
- (void) winGame{
    UIAlertView * alertVictory = [[UIAlertView alloc] initWithTitle:@"Victory" message:@"You are great - you broke the schiffer" delegate:self cancelButtonTitle:@"Start new Game" otherButtonTitles: nil];
    [alertVictory show];
}
- (void) showResult{
    NSMutableAttributedString * formattedStatistics = [[NSMutableAttributedString alloc] initWithString:self.statistics];
    self.resultView.attributedText = formattedStatistics;
}
#pragma mark - uitext field
@end
