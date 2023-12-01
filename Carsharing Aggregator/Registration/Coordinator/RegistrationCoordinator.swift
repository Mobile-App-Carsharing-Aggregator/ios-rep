import UIKit

final class RegistrationCoordinator: ChildCoordinator, Coordinator {
    var parent: AuthCoordinator?
    
    var viewControllerRef: UIViewController?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }

    func start() {
        let viewModel = RegistrationViewModel()
        let registerVC = RegistrationViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController.setAttributesForRegistrationTitle(loginVC: registerVC)
        navigationController.pushViewController(registerVC, animated: true)
    }
    
    func openDocumentsCoordinator() {
        parent?.openDocumentsCoordinator()
    }
}
