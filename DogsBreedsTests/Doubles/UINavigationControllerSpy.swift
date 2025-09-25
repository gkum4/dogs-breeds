import UIKit

final class UINavigationControllerSpy: UINavigationController {
    private(set) var showCallCount = 0
    
    override func show(_ vc: UIViewController, sender: Any?) {
        super.show(vc, sender: sender)
        showCallCount += 1
    }
}
