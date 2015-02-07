//
//  AppDelegate.m
//  Hidr
//
//  Created by Yaakov Gamliel on 2/7/15.
//  Copyright (c) 2015 G2Think. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (assign, nonatomic) BOOL darkModeOn;
@property (weak) IBOutlet NSMenu *appMenu;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.image = [NSImage imageNamed:@"menuBarIcon"];
    [self.statusItem setMenu:self.appMenu];
    
}

- (IBAction)showItemClicked:(id)sender {
    if ([self isDesktopHidden]) {
        [self showdesktopItems];
        [self restarFinder];
    }
}

- (IBAction)hideItemClicked:(id)sender {
    if (![self isDesktopHidden]) {
        [self hideDesktopItems];
        [self restarFinder];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)isDesktopHidden {
    NSTask *hideTask = [[NSTask alloc] init];
    hideTask.launchPath = @"/usr/bin/defaults";
    hideTask.arguments = @[@"read",@"com.apple.finder",@"CreateDesktop"];
    
    NSPipe *hideTaskPipe = [[NSPipe alloc] init];
    
    hideTask.standardOutput = hideTaskPipe;
    
    [hideTask launch];
    
    NSString *taskOutput = [[NSString alloc] initWithData:[[hideTaskPipe fileHandleForReading] readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    [hideTask waitUntilExit];
    
    if ([taskOutput isEqualToString:@"flase\n"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)hideDesktopItems {
    NSTask *hideTask = [[NSTask alloc] init];
    hideTask.launchPath = @"/usr/bin/defaults";
    hideTask.arguments = @[@"write",@"com.apple.finder",@"CreateDesktop",@"flase"];
    
    [hideTask launch];
    [hideTask waitUntilExit];
}

- (void)showdesktopItems {
    NSTask *showTask = [[NSTask alloc] init];
    showTask.launchPath = @"/usr/bin/defaults";
    showTask.arguments = @[@"write",@"com.apple.finder",@"CreateDesktop",@"true"];
    
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

@end
