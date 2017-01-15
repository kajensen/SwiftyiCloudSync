# SwiftyiCloudSync
Sync UserDefaults to iCloud automatically. Swift 3.

### What is this?
A clean and simple class to sync UserDefaults to iCloud.

### How to use?
1. Configure iCloud entitlements to use key-value storage. If you are using across apps (different bundle IDs) make sure they have the same iCloud container id.
2. Drag the file to your xcode project.
3. Call SwiftyiCloudSync.start(prefix) in app did finish launching. Use an app-unique prefix to avoid syncing unnecessary data.

This is a Swift 3 version of https://github.com/MugunthKumar/MKiCloudSync with some minor changes.
