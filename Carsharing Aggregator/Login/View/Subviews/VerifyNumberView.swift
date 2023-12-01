import UIKit

class VerifyNumberView: UIView {
    let enterPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(
            string: "Введите номер телефона",
            attributes:
                [NSAttributedString.Key.kern: -0.41,
                 NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 16,
                                               height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.text = "+7 (       )"
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
            //textField.isHidden = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(enterPhoneNumberLabel)
        addSubview(phoneTextField)
        setConstraints()
        phoneTextField.delegate = self
    }
    
    func needToShowButton() -> Bool {
        if phoneTextField.text?.count == 18 {
           return false
        } else {
            return true
        }
    }
    
    private func setConstraints() {
        enterPhoneNumberLabel.snp.makeConstraints { make in
            make.bottom.equalTo(phoneTextField.snp.top).offset(-12)
            make.leading.equalTo(snp.leading).offset(33)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.height.equalTo(52)
        }
    }
}
extension VerifyNumberView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        phoneTextField.text = textField.setPhoneNumberMask(
            textField: phoneTextField,
            mask: "+X (XXX) XXX XX XX",
            string: string,
            range: range)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
