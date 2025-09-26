import UIKit

extension UIViewController {
    private static let loadingViewScreenIdentifier = "loadingViewScreenIdentifier"
    
    func showLoadingScreen() {
        let loadingView = LoadingView(identifier: UIViewController.loadingViewScreenIdentifier)
        view.addSubview(loadingView)
        loadingView.center = view.center
    }
    
    func hideLoadingScreen() {
        guard let loadingView = view.subviews.first(where: {
            ($0 as? LoadingView)?.identifier == UIViewController.loadingViewScreenIdentifier
        }) else { return }
        loadingView.removeFromSuperview()
    }
}
