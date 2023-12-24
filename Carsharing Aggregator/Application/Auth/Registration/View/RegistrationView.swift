import UIKit
import Combine

class RegistrationView: UIView {
    let viewModel = RegistrationViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Properties
    private lazy var termsOfService: UILabel = {
        let label = UILabel().createTermsLabel()
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        return label
    }()
    private lazy var nameTextField = UITextField(placeholder: "Имя", isSecure: false, keyboardType: .other, textContentType: .other)
    private lazy var surnameTextField = UITextField(placeholder: "Фамилия", isSecure: false, keyboardType: .other, textContentType: .other)
    private lazy var emailTextField = UITextField(placeholder: "Example@mail.ru", isSecure: false, keyboardType: .email, textContentType: .email)
    private lazy var passwordTextField = UITextField(placeholder: "Пароль", isSecure: true, keyboardType: .password, textContentType: .password)
    private lazy var confirmPasswordTextField = UITextField(placeholder: "Пароль еще раз", isSecure: true, keyboardType: .password,
        textContentType: .password)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return scrollView
    }()
    
    private let nameSublabel = UILabel(for: "  Имя  ")
    private let surnameSublabel = UILabel(for: "  Фамилия  ")
    private let emailSublabel = UILabel(for: "  Example@mail.ru  ")
    private let passwordSublabel = UILabel(for: "  Пароль  ")
    private let confirmSublabel = UILabel(for: "  Пароль еще раз  ")
    
    private let emptyNameFieldWarning = UILabel(string: "Поле обязательное для заполнения")
    private let emptySurnameFieldWarning = UILabel(string: "Поле обязательное для заполнения")
    private let emptyEmailFieldWarning = UILabel(string: "Поле обязательное для заполнения")
    private let emptyPasswordFieldWarning = UILabel(string: "Поле обязательное для заполнения")
    private let emptyConfirmFieldWarning = UILabel(string: "Поле обязательное для заполнения")
    
    private let incorrectNameWarning = UILabel(string: "Допустимые символы: пробел, кириллические \nи латинские буквы")
    private let incorrectSurnameWarning = UILabel(string: "Допустимые символы: пробел, кириллические \nи латинские буквы")
    private let emailWarninigLabel = UILabel(string: "Используйте только латинские буквы, цифры,\n знак подчеркивания, точку и минус.")
    private let passwordWarningLabel = UILabel(string: "Должно быть не менее 10 символов")
    private let confirmWarningLabel = UILabel(string: "Пароли должны совпадать")
    
    private let orLabel = UILabel().createOrLabel(string: "или")
    private lazy var vkLogoButton = UIButton(with: UIImage.vkLogo!, target: self, action: #selector(vkLogoButtonDidTapped))
    private lazy var yandexLogoButton = UIButton(with: UIImage.yandexLogo!, target: self, action: #selector(yandexLogoButtonDidTapped))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Targets and functions
    private func addStartTarget() {
        nameTextField.addTarget(self, action: #selector(startNameField(_:)), for: .editingDidBegin)
        surnameTextField.addTarget(self, action: #selector(startSurnameField(_:)), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(startEmailField(_:)), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(startPasswordField(_:)), for: .editingDidBegin)
        confirmPasswordTextField.addTarget(self, action: #selector(startConfirmField(_:)), for: .editingDidBegin)
    }
    
    private func addEndingTargets() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidEnd(_:)), for: .editingDidEnd)
        surnameTextField.addTarget(self, action: #selector(surnameTextFieldDidEnd(_:)), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidEnd(_:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidEnd(_:)), for: .editingDidEnd)
        confirmPasswordTextField.addTarget(self, action: #selector(confirmTextFieldDidEnd(_:)), for: .editingDidEnd)
    }
    
    @objc private func startNameField(_ textField: UITextField) {
        nameTextField.placeholder = ""
        nameTextField.layer.borderWidth = 2
        nameSublabel.enterSublabelAnimation()
    }
    
    @objc private func startSurnameField(_ textField: UITextField) {
        surnameTextField.placeholder = ""
        surnameTextField.layer.borderWidth = 2
        surnameSublabel.enterSublabelAnimation()
    }
    
    @objc private func startEmailField(_ textField: UITextField) {
        emailTextField.placeholder = ""
        emailTextField.layer.borderWidth = 2
        emailSublabel.enterSublabelAnimation()
    }
    
    @objc private func startPasswordField(_ textField: UITextField) {
        passwordTextField.placeholder = ""
        passwordTextField.layer.borderWidth = 2
        passwordSublabel.enterSublabelAnimation()
    }
    
    @objc private func startConfirmField(_ textField: UITextField) {
        confirmPasswordTextField.placeholder = ""
        confirmPasswordTextField.layer.borderWidth = 2
        confirmSublabel.enterSublabelAnimation()
    }
    
    @objc private func labelTapped() {
        print("OPEN LINK")
    }
    @objc private func vkLogoButtonDidTapped() {
        print("VK TAPPED")
    }
    
    @objc private func yandexLogoButtonDidTapped() {
        print("YANDEX TAPPED")
    }

    @objc private func nameTextFieldDidEnd(_ textField: UITextField) {
        viewModel.name = textField.text ?? ""
        nameSublabel.isHidden = true
        textField.layer.borderWidth = 1
        observeNameField()
    }
    @objc private func surnameTextFieldDidEnd(_ textField: UITextField) {
        viewModel.surname = textField.text ?? ""
        surnameSublabel.isHidden = true
        textField.layer.borderWidth = 1
        observeSurnameField()
    }
    
    @objc private func emailTextFieldDidEnd(_ textField: UITextField) {
        viewModel.email = textField.text ?? ""
        emailSublabel.isHidden = true
        textField.layer.borderWidth = 1
        observeEmailField()
    }
    
    @objc private func passwordTextFieldDidEnd(_ textField: UITextField) {
        viewModel.password = textField.text ?? ""
        passwordSublabel.isHidden = true
        textField.layer.borderWidth = 1
        observePasswordField()
    }
    
    @objc private func confirmTextFieldDidEnd(_ textField: UITextField) {
        viewModel.confirmPassword = textField.text ?? ""
        confirmSublabel.isHidden = true
        textField.layer.borderWidth = 1
        observeConfirmField()
    }
    
    func setupDelegate() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailTextField.delegate = self
    }

   private func updateConstraintsForEmptyTextField(_ textField: UITextField, relativeTo previousTextField: UITextField?, isEmpty: Bool) {
        let previousTextField = previousTextField ?? scrollView
        let offset = isEmpty ? 33 : 16
        textField.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(nameTextField.snp.height)
            make.width.equalTo(nameTextField.snp.width)
    
        }
       termsOfService.snp.remakeConstraints { make in
           make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(offset)
           make.leading.equalTo(confirmPasswordTextField.snp.leading)
       }
    }
    private func updateForEmptyConfirmTextField(_ label: UILabel, relativeTo previousTextField: UITextField, isEmpty: Bool) {
        let offset = 33
        label.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.leading.equalTo(previousTextField.snp.leading)
        }
    }
    
    private func updateConstraintsForValidTextField(_ textField: UITextField, relativeTo previousTextField: UITextField?, isValid: Bool) {
        let previousTextField = previousTextField ?? scrollView
        let offset = isValid ? 16 : 53
        let termsOffset = isValid ? 16 : 53
        
        if !isValid {
            previousTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            previousTextField.layer.borderColor = UIColor.black.cgColor
        }
        textField.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalTo(nameTextField.snp.height)
            make.width.equalTo(nameTextField.snp.width)
        }
        termsOfService.snp.remakeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(termsOffset)
            make.leading.equalTo(confirmPasswordTextField.snp.leading)
        }
    }
    
    private func updateForValidConfirmTextField(_ label: UILabel, relativeTo previousTextField: UITextField, isValid: Bool) {
        let offset = isValid ? 12 : 40
        label.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.leading.equalTo(previousTextField.snp.leading)
        }
    }

    private func observeNameField() {
        Publishers.CombineLatest3(viewModel.$name,
                                  viewModel.isNameEmptyPublisher,
                                  viewModel.isValidNamePublisher)
        .sink { [weak self] (_, isEmpty, isValid) in
            guard let self = self else { return }
            if isEmpty {
                self.updateConstraintsForEmptyTextField(self.surnameTextField, relativeTo: self.nameTextField, isEmpty: isEmpty)
                self.emptyNameFieldWarning.isHidden = !isEmpty
                self.incorrectNameWarning.isHidden = isEmpty
            } else {
                self.updateConstraintsForValidTextField(self.surnameTextField,
                                                        relativeTo: self.nameTextField,
                                                        isValid: isValid)
                self.incorrectNameWarning.isHidden = isValid
                self.emptyNameFieldWarning.isHidden = !isEmpty
            }
        }
        .store(in: &cancellables)
    }
   
    private func observeSurnameField() {
        Publishers.CombineLatest3(viewModel.$surname,
                                  viewModel.isSurnameEmptyPublisher,
                                  viewModel.isValidSurnamePublisher)
        .sink { [weak self] (_, isEmpty, isValid) in
            guard let self = self else { return }
            if isEmpty {
                self.updateConstraintsForEmptyTextField(self.emailTextField,
                                                        relativeTo: self.surnameTextField,
                                                        isEmpty: isEmpty)
                self.emptySurnameFieldWarning.isHidden = !isEmpty
                self.incorrectSurnameWarning.isHidden = isEmpty
            } else {
                self.updateConstraintsForValidTextField(self.emailTextField, relativeTo: self.surnameTextField, isValid: isValid)
                self.incorrectSurnameWarning.isHidden = isValid
                self.emptySurnameFieldWarning.isHidden = !isEmpty
            }
        }
        .store(in: &cancellables)
    }
    
    private func observeEmailField() {
        Publishers.CombineLatest3(viewModel.$email,
                                  viewModel.isEmailEmptyPublisher,
                                  viewModel.isValidEmailPublisher)
        .sink { [weak self] (_, isEmpty, isValid) in
            guard let self = self else { return }
            if isEmpty {
                self.updateConstraintsForEmptyTextField(self.passwordTextField, relativeTo: self.emailTextField, isEmpty: isEmpty)
                self.emptyEmailFieldWarning.isHidden = !isEmpty
                self.emailWarninigLabel.isHidden = isEmpty
            } else {
                self.updateConstraintsForValidTextField(self.passwordTextField, relativeTo: self.emailTextField, isValid: isValid)
                self.emptyEmailFieldWarning.isHidden = !isEmpty
                self.emailWarninigLabel.isHidden = isValid
            }
        }
        .store(in: &cancellables)
    }
    
    private func observePasswordField() {
        Publishers.CombineLatest3(viewModel.$password,
                                  viewModel.isPasswordEmptyPublisher,
                                  viewModel.isValidPasswordPublisher)
        .sink { [weak self] (_, isEmpty, isValid) in
            guard let self = self else { return }
            if !isValid {
                self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            } else {
                self.passwordTextField.layer.borderColor = UIColor.black.cgColor
            }
            if isEmpty {
                self.updateConstraintsForEmptyTextField(self.confirmPasswordTextField, relativeTo: self.passwordTextField, isEmpty: isEmpty)
                self.emptyPasswordFieldWarning.isHidden = !isEmpty
                self.passwordWarningLabel.isHidden = isEmpty
            } else {
                self.updateConstraintsForEmptyTextField(self.confirmPasswordTextField, relativeTo: self.passwordTextField, isEmpty: !isValid)
                self.emptyPasswordFieldWarning.isHidden = !isEmpty
                self.passwordWarningLabel.isHidden = isValid
            }
        }
        .store(in: &cancellables)
    }
    
    private func observeConfirmField() {
        Publishers.CombineLatest3(viewModel.$confirmPassword,
                                  viewModel.isConfrimPasswordEmptyPublisher,
                                  viewModel.isValidConfirmPasswordPublisher)
        .sink { [weak self] (_, isEmpty, isValid) in
            guard let self = self else { return }
            if !isValid {
                self.confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            } else {
                self.confirmPasswordTextField.layer.borderColor = UIColor.black.cgColor
            }
            if isEmpty {
                self.updateForEmptyConfirmTextField(self.termsOfService, relativeTo: self.confirmPasswordTextField, isEmpty: isEmpty)
                self.emptyConfirmFieldWarning.isHidden = !isEmpty
                self.confirmWarningLabel.isHidden = isEmpty
            } else {
                self.updateForEmptyConfirmTextField(self.termsOfService, relativeTo: self.confirmPasswordTextField, isEmpty: isValid)
                self.emptyConfirmFieldWarning.isHidden = !isEmpty
                self.confirmWarningLabel.isHidden = isValid
            }
        }
        .store(in: &cancellables)
    }
}

extension RegistrationView {
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(nameSublabel)
        scrollView.addSubview(emptyNameFieldWarning)
        scrollView.addSubview(incorrectNameWarning)
        scrollView.addSubview(surnameTextField)
        scrollView.addSubview(surnameSublabel)
        scrollView.addSubview(emptySurnameFieldWarning)
        scrollView.addSubview(incorrectSurnameWarning)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(emailSublabel)
        scrollView.addSubview(emptyEmailFieldWarning)
        scrollView.addSubview(emailWarninigLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(passwordSublabel)
        scrollView.addSubview(emptyPasswordFieldWarning)
        scrollView.addSubview(passwordWarningLabel)
        scrollView.addSubview(confirmPasswordTextField)
        scrollView.addSubview(confirmSublabel)
        scrollView.addSubview(emptyConfirmFieldWarning)
        scrollView.addSubview(confirmWarningLabel)
        scrollView.addSubview(vkLogoButton)
        scrollView.addSubview(yandexLogoButton)
        scrollView.addSubview(orLabel)
        scrollView.addSubview(passwordWarningLabel)
        scrollView.addSubview(termsOfService)
        scrollView.addSubview(incorrectNameWarning)
        scrollView.addSubview(confirmWarningLabel)
        addEndingTargets()
        addStartTarget()
        setupDelegate()
    }
    
    private func setConstraints() {
        addSubviews()
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(348)
            make.height.equalTo(52)
        }
        
        nameSublabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.top).offset(-8)
            make.leading.equalTo(nameTextField.snp.leading).offset(16)
        }
        
        emptyNameFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalTo(nameTextField.snp.leading).offset(16)
            make.trailing.equalTo(nameTextField.snp.trailing)
        }
        
        incorrectNameWarning.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(8)
            make.leading.equalTo(nameTextField.snp.leading).offset(16)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.centerX.equalTo(nameTextField.snp.centerX)
            make.width.equalTo(nameTextField.snp.width)
            make.height.equalTo(nameTextField)
        }
        
        surnameSublabel.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.top).offset(-8)
            make.leading.equalTo(surnameTextField.snp.leading).offset(16)
        }
        
        emptySurnameFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(8)
            make.leading.equalTo(surnameTextField.snp.leading).offset(16)
            make.trailing.equalTo(surnameTextField.snp.trailing)
        }
        
        incorrectSurnameWarning.snp.makeConstraints { make in
            make.top.equalTo(emptySurnameFieldWarning.snp.top)
            make.leading.equalTo(emptySurnameFieldWarning.snp.leading)
            make.trailing.equalTo(emptySurnameFieldWarning.snp.trailing)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(16)
            make.centerX.equalTo(surnameTextField.snp.centerX)
            make.width.equalTo(surnameTextField.snp.width)
            make.height.equalTo(surnameTextField)
        }
        
        emailSublabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.top).offset(-8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
        }
        
        emptyEmailFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        
        emailWarninigLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.centerX.equalTo(surnameTextField.snp.centerX)
            make.width.equalTo(surnameTextField.snp.width)
            make.height.equalTo(emailTextField.snp.height)
        }
        
        passwordSublabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.top).offset(-8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
        }
        
        emptyPasswordFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        passwordWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
            make.trailing.equalTo(emptyPasswordFieldWarning.snp.trailing)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.width.equalTo(passwordTextField.snp.width)
            make.height.equalTo(passwordTextField.snp.height)
        }
        
        confirmSublabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.top).offset(-8)
            make.leading.equalTo(confirmPasswordTextField.snp.leading).offset(16)
        }
        
        termsOfService.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(12)
            make.leading.equalTo(confirmPasswordTextField.snp.leading)
            make.trailing.equalTo(confirmPasswordTextField.snp.trailing)
        }
        
        emptyConfirmFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(8)
            make.leading.equalTo(confirmPasswordTextField.snp.leading).offset(16)
            make.trailing.equalTo(confirmPasswordTextField.snp.trailing)
        }
        
        confirmWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyConfirmFieldWarning.snp.top)
            make.leading.equalTo(emptyConfirmFieldWarning.snp.leading)
            make.trailing.equalTo(emptyConfirmFieldWarning.snp.trailing)
        }
        
        orLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(termsOfService.snp.bottom).offset(20)
            make.bottom.equalTo(yandexLogoButton.snp.top).offset(-12)
        }
        
        yandexLogoButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(12)
            make.leading.equalTo(scrollView.snp.leading).offset(141)
        }
        
        vkLogoButton.snp.makeConstraints { make in
            make.top.equalTo(yandexLogoButton.snp.top)
            make.leading.equalTo(yandexLogoButton.snp.trailing).offset(16)
        }
    }
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
