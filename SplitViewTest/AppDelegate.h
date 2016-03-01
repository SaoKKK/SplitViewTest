//
//  AppDelegate.h
//  SplitViewTest
//
//  Created by 河野 さおり on 2016/03/01.
//  Copyright © 2016年 河野 さおり. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (readonly,nonatomic)NSString* dummyTxt;

- (void)switchMenuTitle:(NSString *)winTitle;
@end

