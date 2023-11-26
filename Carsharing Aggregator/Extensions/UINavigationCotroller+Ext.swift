import UIKit

private let _durationTime: CFTimeInterval = 0.25

extension UINavigationController {
    enum VCTransition {
        case fromBottom
        case fromTop
    }
    
    func customPopViewController(direction: VCTransition, transitionType: CATransitionType) {
        addTransition(transitionDirection: direction, transitionType: transitionType, duration: _durationTime)
        popViewController(animated: false)
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool) {
        if let vc = viewControllers.last(where: {$0.isKind(of: ofClass)}) {
            popToViewController(vc, animated: animated)
        }
    }
    
    func customPopToRootViewController(direction: VCTransition, transitionType: CATransitionType) {
        addTransition(transitionDirection: direction, transitionType: transitionType, duration: _durationTime)
        popToRootViewController(animated: false)
    }
    
    func customPopToViewController(viewController vc: UIViewController, direction: VCTransition, transitionType: CATransitionType) {
        addTransition(transitionDirection: direction, transitionType: transitionType, duration: _durationTime)
        popToViewController(vc, animated: false)
    }
    
    func customPushViewController(viewController vc: UIViewController, direction: VCTransition, transitionType: CATransitionType) {
        addTransition(transitionDirection: direction, transitionType: transitionType, duration: _durationTime)
        pushViewController(vc, animated: false)
    }
    
    
    private func addTransition(transitionDirection direction: VCTransition, transitionType: CATransitionType, duration: CFTimeInterval) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = .init(name: .easeInEaseOut)
        
        switch direction {
        case .fromBottom: transition.subtype = .fromBottom
        case .fromTop: transition.subtype = .fromTop
        }
        
        self.view.layer.add(transition, forKey: kCATransition)
    }
}
