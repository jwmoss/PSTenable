# Change Log

## [0.2.5] 2020-02-07

- Add switch option to Get-PSTenablePlugin for returning the plugin output.

## [0.2.4] 2019-11-18

- Add pagination support, add support for more than 5000 records, and code cleanup for Get-PSTenableSeverity. Thanks [@AaronG1234](https://github.com/AaronG1234)! [#12](https://github.com/jwmoss/PSTenable/issues/12)

## [0.2.3] 2019-09-01

- Code cleanup [#9](https://github.com/jwmoss/PSTenable/issues/9)

## [0.2.2] 2019-07-13

- Fixed automatically retrieving token.

## [0.2.1] 2019-07-13

- Re-worked how to automatically retrive a new token.

## [0.2.0] 2019-07-12

- Added Get-PSTenableWindowsServerJava
- Fixed issue with Get-PSTenablePlugin output

## [0.1.3] 2019-07-09

- Added feature in Invoke-PSTenableRest to enable TLS 1.2 and restoring TLS settings, used in [KBUpdate](https://github.com/potatoqualitee/kbupdate).
- Added feature in Connect-PSTenable to automatically fix Invoke-RestMethod if hostname isn't using TLS.
- Formatting changes for a handful of functions.

## [0.1.2] 2019-07-05

- Initial upload to gallery
- Fixed changelog date to ISO 8061. Derp.

## [0.1.1] 2019-07-04

- Initial upload
- Converted Invoke-RestMethod to Invoke-PSTenableRest
- Added basic support for caching token, web seession, and credential using PSFramework
- Added basic help/readme support
