# CRTouchIDManager

This manager acts as a wrapper for Touch ID authentication methods, which is provided by Apple for users having iOS 8 and TouchID enabled iPhones.

User only has to use the class method provided by the wrapper class, and result is returned by the closure method. This eleminates the worry for checking iOS version, touch Id enrollment, etc.
Moreover, it enables the user to write only 2 lines of code, if same thing is used at multiple places.
