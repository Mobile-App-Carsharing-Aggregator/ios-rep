import Foundation
import Combine

class EnterViewModel {
    var coordinator: LoginCoordinator
    var loginViewModel: LoginViewModel!
    private var userService = DefaultUserService.shared
    var registrationViewModel: RegistrationViewModel!
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func isSubmitRegistrationEnabled() {
        if let registrationViewModel = registrationViewModel {
            registrationViewModel.isSubmitEnabled
                .sink { [weak self] isEnabled in
                    guard let self = self else { return }
                    if isEnabled {
                        let registrationModel = UserRegistration(email: registrationViewModel.email,
                                                                 firstName: registrationViewModel.name,
                                                                 lastName: registrationViewModel.surname,
                                                                 password: registrationViewModel.password,
                                                                 confirmPassword: registrationViewModel.confirmPassword)
                        print(registrationModel)
                        userService.createUser(with: registrationModel) { result in
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else { return }
                                UIProgressHUD.show()
                                switch result {
                                case .success(let success):
                                    coordinator.startTabBarFlow()
                                    UIProgressHUD.dismiss()
                                case .failure(let failure):
                                    UIProgressHUD.failed()
                                    UIProgressHUD.dismiss()
                                }
                            }
                        }
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    func isSubmitLoginEnabled() {
        if let loginViewModel = loginViewModel {
            loginViewModel.isSubmitEnabled
                .sink { [weak self] isEnabled in
                    guard let self = self else { return }
                    if isEnabled {
                        let loginModel = UserLogin(email: loginViewModel.email, password: loginViewModel.password)
                        userService.userLogin(with: loginModel) { result in
                            DispatchQueue.main.async { [weak self] in
                                UIProgressHUD.show()
                                switch result {
                                case .success(let success):
                                    self?.coordinator.startTabBarFlow()
                                    UIProgressHUD.dismiss()
                                case .failure(let failure):
                                    UIProgressHUD.failed()
                                    UIProgressHUD.dismiss()
                                }
                            }
                        }
                    }
                }
                .store(in: &cancellables)
        }
    }
}
