//
//  YGHDefaultsManager.h
//  Hidr
//
//  Created by Yaakov on 2/21/17.
//  Copyright © 2017 G2Think. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGHDefaultsManager : NSObject

- (BOOL)isDesktopHidden;

- (void)hideDesktopItems;

- (void)showdesktopItems;

- (void)restarFinder;

- (NSImage *)menuImageForCurrentDesktopState:(BOOL)onScreen;

@end
