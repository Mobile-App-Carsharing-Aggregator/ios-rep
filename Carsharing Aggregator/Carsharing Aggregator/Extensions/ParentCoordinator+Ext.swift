import UIKit

extension ParentCoordinator {
    
    func addChild(_ child: Coordinator?) {
        if let _child = child {
            childCoordinators.append(_child)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            where coordinator === child {
                print(child)
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
