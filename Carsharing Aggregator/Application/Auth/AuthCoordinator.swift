import UIKit

class AuthCoordinator: ParentCoordinator, Coordinator {
    var parent: RootCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.parent = self
        addChild(loginCoordinator)
        loginCoordinator.start()
    }
    
    func finishAuthAndStartTabBarFlow() {
        parent?.childDidFinish(self)
        parent?.startTabBarFlow()
    }
}
