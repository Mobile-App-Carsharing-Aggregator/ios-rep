import Foundation
import Combine

class EnterViewModel {
    var coordinator: AuthCoordinator
    var loginViewModel: LoginViewModel?
    private var userService = DefaultUserService.shared
    var registrationViewModel: RegistrationViewModel?
    init(coordinator: AuthCoordinator) {
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
                                    coordinator.finishAuthAndStartTabBarFlow()
                                    UIProgressHUD.dismiss()
                                    
                                case .failure(let failure):
                                    
                                    UIProgressHUD.failed()
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
                                    self?.coordinator.finishAuthAndStartTabBarFlow()
                                    UIProgressHUD.dismiss()
                                case .failure(let failure):
                                    UIProgressHUD.failed()
                                }
                            }
                        }
                    }
                }
                .store(in: &cancellables)
        }
    }
}
