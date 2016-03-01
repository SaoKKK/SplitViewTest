//
//  NotCollapse.m
//  SplitViewTest
//
//  Created by 河野 さおり on 2016/03/01.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "NotCollapse.h"
#import "AppDelegate.h"

#define kMinLeftView	120.0f
#define kMinRightView	280.0f

@interface NotCollapse ()

@end

@implementation NotCollapse{
    IBOutlet NSTextView *leftTxtView;
    IBOutlet NSTextView *rightTxtView;
    IBOutlet NSSplitView *_splitView;
    CGFloat oldWidth;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    AppDelegate *appD = [NSApp delegate];
    [rightTxtView setString:appD.dummyTxt];
    [leftTxtView setString:appD.dummyTxt];
}

- (IBAction)pshShowOrHideLeftView:(id)sender {
    NSView *leftView = [[_splitView subviews]objectAtIndex:0];
    NSView *rightView = [[_splitView subviews]objectAtIndex:1];
    CGFloat dividerThickness = [_splitView dividerThickness];
    if (leftView.frame.size.width == 0) {
        [leftView setFrame:NSMakeRect(0,0,oldWidth, leftView.frame.size.height)];
        [rightView setFrame:NSMakeRect(oldWidth+dividerThickness,0,_splitView.frame.size.width-leftView.frame.size.width-dividerThickness,leftView.frame.size.height)];
    } else {
        oldWidth = leftView.frame.size.width;
        [leftView setFrame:NSMakeRect(0,0,0,leftView.frame.size.height)];
        [rightView setFrame:NSMakeRect(dividerThickness,0,_splitView.frame.size.width-dividerThickness,_splitView.frame.size.height)];
    }
}

#pragma mark - split view delegate

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex{
    return proposedMinimumPosition + kMinLeftView;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex{
    return proposedMaximumPosition - kMinRightView;
}

- (void)splitView:(NSSplitView *)splitView resizeSubviewsWithOldSize:(NSSize)oldSize{
    NSRect newFrame = [splitView frame];  //新しいsplitView全体のサイズを取得
    NSView *leftView = [[splitView subviews]objectAtIndex:0];
    NSRect leftFrame = [leftView frame];
    NSView *rightView = [[splitView subviews]objectAtIndex:1];
    NSRect rightFrame = [rightView frame];
    CGFloat dividerThickness = [splitView dividerThickness];
    
    leftFrame.size.height = newFrame.size.height;
    rightFrame.size.width = newFrame.size.width - leftFrame.size.width - dividerThickness;
    rightFrame.size.height = newFrame.size.height;
    rightFrame.origin.x = leftFrame.size.width + dividerThickness;
    
    [leftView setFrame:leftFrame];
    [rightView setFrame:rightFrame];
}

@end
