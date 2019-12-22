import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var channel: FlutterMethodChannel!
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        channel = FlutterMethodChannel(name: "sample/toPlatformScreen",
                                       binaryMessenger: controller as! FlutterBinaryMessenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "toPlatformScreen":
                let argument = call.arguments as! Dictionary<String, String>
                let label = argument["label_from_dart"]!
                self.toPlatformScreen(label)
                result("Platform Screen was displayed!!")
                break
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func toPlatformScreen(_ label: String) {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let storyboard: UIStoryboard = UIStoryboard(name: "Next", bundle: nil)
        let next = storyboard.instantiateInitialViewController() as! NextController
        controller.present(next, animated: true, completion: { () in
            next.label.text = label
        })
        next.onClose = { () in
            self.channel.invokeMethod("onClosed", arguments: ["from_platform": "called onClosed() in ios"])
        }
    }
}
