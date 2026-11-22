## Unreleased

* Do not request microphone access when the plugin attaches to an engine.
* Check the real microphone grant in `hasPermission`, and respect
  `request: false` for passive queries.
* Bind explicit permission requests to the foreground UIAbility and complete
  native failures with method-channel errors.

## 1.0.0

* Support OpenHarmony
