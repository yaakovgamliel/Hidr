//
//  AppDelegate.m
//  Hidr
//
//  Created by Yaakov Gamliel on 2/7/15.
//  Copyright (c) 2015 G2Think. All rights reserved.
//
//      ___                       ___           ___
//     /\__\          ___        /\  \         /\  \
//    /:/  /         /\  \      /::\  \       /::\  \
//   /:/__/          \:\  \    /:/\:\  \     /:/\:\  \
//  /::\  \ ___      /::\__\  /:/  \:\__\   /::\~\:\  \
// /:/\:\  /\__\  __/:/\/__/ /:/__/ \:|__| /:/\:\ \:\__\
// \/__\:\/:/  / /\/:/  /    \:\  \ /:/  / \/_|::\/:/  /
//      \::/  /  \::/__/      \:\  /:/  /     |:|::/  /
//      /:/  /    \:\__\       \:\/:/  /      |:|\/__/
//     /:/  /      \/__/        \::/__/       |:|  |
//     \/__/                     ~~            \|__|
//

#import "YGHAppDelegate.h"
#import "PFMoveApplication.h"
#import "YGHDefaultsManager.h"

@interface YGHAppDelegate ()

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (assign, nonatomic) BOOL darkModeOn;
@property (weak) IBOutlet NSMenu *appMenu;
@property (strong) YGHDefaultsManager *defaultsManager;

@end

@implementation YGHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    self.defaultsManager = [[YGHDefaultsManager alloc] init];
    
    self.statusItem.image = [self.defaultsManager menuImageForCurrentDesktopState:![self.defaultsManager isDesktopHidden]];
    
    [self.statusItem setMenu:self.appMenu];
    
}

- (IBAction)showItemClicked:(id)sender {
    if ([self.defaultsManager isDesktopHidden]) {
        [self.defaultsManager showdesktopItems];
        [self.defaultsManager restarFinder];
        self.statusItem.image = [self.defaultsManager menuImageForCurrentDesktopState:YES];
    }
}

- (IBAction)hideItemClicked:(id)sender {
    if (![self.defaultsManager isDesktopHidden]) {
        [self.defaultsManager hideDesktopItems];
        [self.defaultsManager restarFinder];
        self.statusItem.image = [self.defaultsManager menuImageForCurrentDesktopState:NO];
    }
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
    PFMoveToApplicationsFolderIfNecessary();
}

@end
