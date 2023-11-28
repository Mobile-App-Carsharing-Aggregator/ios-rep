import UIKit

final class RegistrationCoordinator: ChildCoordinator, Coordinator {
    var parent: RootCoordinator?
    
    var viewControllerRef: UIViewController?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }

    func start() {
        let registrationVC = RegistrationViewController()
        viewControllerRef = registrationVC
        registrationVC.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        registrationVC.navigationItem.title = "Регистрация"
        navigationController.pushViewController(registrationVC, animated: false)
    }
}
