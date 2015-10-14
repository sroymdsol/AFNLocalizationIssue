# AFNLocalizationIssue

This is a reduction of a localization issue on iOS that was introduced by AFNetworking 2.5.4.

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

## Investigation

I have tracked down the issue to this commit in AFNetworking:
https://github.com/AFNetworking/AFNetworking/commit/e4fad7789b5fe222df5b0a5f84c935f0f6c1d13a

Strangely, commenting out `[localDataTask cancel];` on line 334 works around the problem, although that's probably not the solution.
