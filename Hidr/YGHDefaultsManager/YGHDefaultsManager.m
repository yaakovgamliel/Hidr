//
//  YGHDefaultsManager.m
//  Hidr
//
//  Created by Yaakov on 2/21/17.
//  Copyright © 2017 G2Think. All rights reserved.
//

#import "YGHDefaultsManager.h"
#import <Cocoa/Cocoa.h>

static NSString *const kPathToDefaults = @"/usr/bin/defaults";

@implementation YGHDefaultsManager

- (BOOL)isDesktopHidden {
    NSTask *hideTask = [[NSTask alloc] init];
    hideTask.launchPath = kPathToDefaults;
    hideTask.arguments = @[@"read",@"com.apple.finder",@"CreateDesktop"];
    
    NSPipe *hideTaskPipe = [[NSPipe alloc] init];
    
    hideTask.standardOutput = hideTaskPipe;
    
    [hideTask launch];
    
    NSString *taskOutput = [[NSString alloc] initWithData:[[hideTaskPipe fileHandleForReading] readDataToEndOfFile]
                                                 encoding:NSUTF8StringEncoding];
    
    [hideTask waitUntilExit];
    
    if ([taskOutput isEqualToString:@"false\n"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)hideDesktopItems {
    NSTask *hideTask = [[NSTask alloc] init];
    hideTask.launchPath = kPathToDefaults;
    hideTask.arguments = @[@"write",@"com.apple.finder",
                           @"CreateDesktop",@"false"];
    
    [hideTask launch];
    [hideTask waitUntilExit];
}

- (void)showdesktopItems {
    NSTask *showTask = [[NSTask alloc] init];
    
    showTask.launchPath = kPathToDefaults;
    showTask.arguments = @[@"write",@"com.apple.finder",
                           @"CreateDesktop",@"true"];
    
    [showTask launch];
    [showTask waitUntilExit];
}

- (void)restarFinder {
    NSTask *restartFinder = [[NSTask alloc] init];
    restartFinder.launchPath = @"/usr/bin/killall";
    restartFinder.arguments = @[@"Finder"];
    
    [restartFinder launch];
    [restartFinder waitUntilExit];
}

- (NSImage *)menuImageForCurrentDesktopState:(BOOL)onScreen {
    if (onScreen) {
        return [NSImage imageNamed:@"desktopOn"];
    } else {
        return [NSImage imageNamed:@"desktopOff"];
    }
}

@end
