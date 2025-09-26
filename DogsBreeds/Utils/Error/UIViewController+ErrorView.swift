import UIKit

extension UIViewController {
    func showErrorView(delegate: ErrorViewDelegate, viewModel: ErrorViewModel) {
        let errorView = ErrorView()
        errorView.delegate = delegate
        errorView.setup(viewModel)
        errorView.frame = view.bounds
        
        view.addSubview(errorView)
    }
    
    func hideErrorView() {
        guard let errorView = view.subviews.first(where: {
            $0 is ErrorView
        }) else { return }
        
        errorView.removeFromSuperview()
    }
}
