# AFNLocalizationIssue

This is a reduction of a strange localization issue on iOS that was introduced by AFNetworking 2.5.4.

The setup is as follows:

- The app is localized per-region (e.g. en-IE, es-US).
- The app enforces the per-region localization by setting the `AppleLanguages` user default in main.m.
- The app is built with AFNetworking. (It doesn't need to make any call.)

## Expected Behavior

The app should display the localized string for the locale specified in main.m. In this case, main.m specifies es-US so the app displays "Spanish (United States)".

This works fine with AFNetworking up to 2.5.3.

## Behavior with AFNetworking 2.5.4 or Newer

The app ignores the locale specified in main.m and uses the locale set in the OS settings. In the case of this sample app, aside from Spanish, it only has a base language so the app displays "Base language".

## Reproducing

The sample app is set up for AFNetworking 2.5.4, so you just need to build and run to see the problem.

1. cd to the project folder and run `pod install`.
2. Open the workspace in Xcode, build and run.

To see the correct behavior, downgrade to AFNetworking 2.5.3.

1. Modify the Podfile to specify AFNetworking 2.5.3.
2. Run `pod install` again.
3. Build and run.

This was tested on iOS 8 and 9, using Xcode 6 and 7.

All versions of AFNetworking from 2.5.4 and up are affected, including the current 2.6.1.

## Investigation

It's very odd that merely bringing AFNetworking into a project should impact a user default, making this all the more difficult to diagnose.

I have tracked down the issue to this commit in AFNetworking, in AFURLSessionManager.m:
https://github.com/AFNetworking/AFNetworking/commit/e4fad7789b5fe222df5b0a5f84c935f0f6c1d13a

Strangely, commenting out `[localDataTask cancel];` on line 334 works around the problem, although that's probably not the solution.

The `load` method holding this line of code executes _before_ main.m, so my theory is that its implementation forces the bundle resources to be loaded—and therefore, the app language to be effectively set—before the locale is specified in main.m. From the point of view of main.m, there seems to be no way to detect that anything has gone awry.

Given the complexity of this AFNetworking commit, it's difficult to say what an alternative would be. For the time being, we have unfortunately resorted to cap our app to AFNetworking 2.5.3.
