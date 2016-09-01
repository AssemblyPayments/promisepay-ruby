# Change Log
All notable changes to this project will be documented in this file.

## [1.2.0] - 2016-09-01

- Add `BatchTransaction` resource
- Drop Ruby 1.9.3 support

## [1.1.0] - 2016-08-23

- Add `Tool#health_check`
- Add `:errors_format` option to the gem
- Add `Client#marketplace`
- Add `Client#generate_token`
- Add `Item#decline_refund`
- Add `Item#raise_dispute`
- Add `Item#request_resolve_dispute`
- Add `Item#resolve_dispute`
- Add `Item#escalate_dispute`
- Add `Item#send_tax_invoice`
- Add `Item#request_tax_invoice`

## [1.0.2] - 2016-08-10

- Add `DirectDebitAuthority` resource
- Add support for Ruby `2.3.0` and `2.3.1`
- Fix `UserResource#update` and `CompanyResource#update`

## [1.0.1] - 2016-08-01

- Add `Charge` resource
- Fix `json` and `coverall` gem version to be compliant with Ruby 1.9.3

## [0.0.5] - 2015-07-30
### Added
- Added ability to request session tokens.
- README example section.
