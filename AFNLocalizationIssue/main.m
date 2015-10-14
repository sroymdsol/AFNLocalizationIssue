//
//  main.m
//  AFNLocalizationIssue
//
//  Created by Steve Roy on 2015-10-14.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [[NSUserDefaults standardUserDefaults] setObject:@[@"es-US"] forKey:@"AppleLanguages"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
