import UIKit

extension Coordinator {
    func popViewController(animated: Bool, useCustomAnimation: Bool) {
        
        switch useCustomAnimation {
        case true: navigationController.customPopViewController(direction: .fromTop, transitionType: .push)
        case false: navigationController.popViewController(animated: animated)
        }
    }
    
    
    
    func pushViewController(viewController vc: UIViewController, animated: Bool) {
        navigationController.customPushViewController(viewController: vc, direction: .fromBottom, transitionType: .push)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        navigationController.popToViewController(ofClass: ofClass, animated: animated)
    }
    
    func popViewController(to viewController: UIViewController, animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType = .push) {
        
        switch useCustomAnimation {
        case true: navigationController.customPopToViewController(viewController: viewController, direction: .fromTop, transitionType: transitionType)
        case false: navigationController.popToViewController(viewController, animated: animated)
        }
    }
}
