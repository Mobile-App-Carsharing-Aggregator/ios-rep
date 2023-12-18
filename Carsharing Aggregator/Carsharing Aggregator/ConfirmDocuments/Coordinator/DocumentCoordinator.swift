import UIKit

class DocumentCoordinator: Coordinator, ChildCoordinator {
    weak var parent: AuthCoordinator?
    var viewControllerRef: UIViewController?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = DocumentsViewModel()
        let documentsVC = DocumentsViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController.setAttributesForDocumentsTitle(loginVC: documentsVC)
        navigationController.pushViewController(documentsVC, animated: true)
    }
    
    func coordinatorDidFinish() {
        parent?.childDidFinish(self)
    }
}
