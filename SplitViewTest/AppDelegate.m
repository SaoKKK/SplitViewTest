//
//  AppDelegate.m
//  SplitViewTest
//
//  Created by 河野 さおり on 2016/03/01.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import "AppDelegate.h"
#import "NotCollapse.h"
#import "NaturalCollapse.h"

#pragma mark - WindowController

@interface NSWindowController(ConvenienceWC)
- (BOOL)isWindowShown;
- (NSString *)showOrHideWindow;
@end

@implementation NSWindowController(ConvenienceWC)

- (BOOL)isWindowShown{
    return [[self window]isVisible];
}

- (NSString *)showOrHideWindow{
    NSWindow *window = [self window];
    if ([window isVisible]) {
        [window orderOut:self];
        return @"Show";
    } else {
        [self showWindow:self];
        return @"Hide";
    }
}

- (void)windowWillClose:(NSNotification *)notification{
    NSWindow *closedWin = notification.object;
    AppDelegate *appD = [NSApp delegate];
    [appD switchMenuTitle:closedWin.title];
}

@end


@interface AppDelegate ()

@end

@implementation AppDelegate{
    NotCollapse *_notCollapseWC;
    NaturalCollapse *_naturalCollapseWC;
    IBOutlet NSMenuItem *mnWinNotCollapse;
    IBOutlet NSMenuItem *mnWinNaturalCollapse;
}
@synthesize dummyTxt;

# pragma mark - Launching

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //ダミーテキストを読み込む
    dummyTxt = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"dummy" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    //ウインドウを開く
    [self showHideNotCollapse:mnWinNotCollapse];
    [self showHideNaturalCollapse:mnWinNaturalCollapse];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showHideNotCollapse:(NSMenuItem *)sender{
    if (! _notCollapseWC) {
        _notCollapseWC = [[NotCollapse alloc]initWithWindowNibName:@"NotCollapse"];
    }
    [sender setTitle:[NSString stringWithFormat:@"%@ NotCollapse",[_notCollapseWC showOrHideWindow]]];
}

- (IBAction)showHideNaturalCollapse:(NSMenuItem *)sender{
    if (! _naturalCollapseWC) {
        _naturalCollapseWC = [[NaturalCollapse alloc]initWithWindowNibName:@"NaturalCollapse"];
    }
    [sender setTitle:[NSString stringWithFormat:@"%@ NaturalCollapse",[_naturalCollapseWC showOrHideWindow]]];
}

- (void)switchMenuTitle:(NSString *)winTitle{
    if ([winTitle isEqualToString:@"NotCollapse"]) {
        [mnWinNotCollapse setTitle:@"Show NotCollapse"];
    } else {
        [mnWinNaturalCollapse setTitle:@"Show NaturalCollapse"];
    }
}

@end
