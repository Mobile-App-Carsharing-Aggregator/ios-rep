import UIKit
enum TextContentType {
    case password
    case email
    case other
    
    var textContentType: UITextContentType {
        switch self {
        case .password:
            return .password
        case .email:
            return .emailAddress
        case .other:
            return .name
        }
    }
}

enum KeyboardType {
    case password
    case email
    case other
    
    var uiKeyboardType: UIKeyboardType {
        switch self {
        case .password:
            return .default
        case .email:
            return .emailAddress
        case .other:
            return .default
        }
    }
}

extension UITextField {
    func setTextField(textField: UITextField,
                      validType: String.ValidTypes,
                      wrongMessage: String,
                      string: String,
                      range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        if !result.isValid(validType: validType) {
            
        }
    }
    
    convenience init(placeholder: String,
                     isSecure: Bool,
                     keyboardType: KeyboardType,
                     textContentType: TextContentType) {
        self.init()
        let leftPaddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 16,
            height: frame.height))
        let rightPaddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 16,
            height: frame.height))
        
        leftView = leftPaddingView
        leftViewMode = .always
        
        rightView = rightPaddingView
        rightViewMode = .always
        self.placeholder = placeholder
        self.keyboardType = keyboardType.uiKeyboardType
        self.textContentType = textContentType.textContentType
        let placeholderColor = UIColor(red: 0.404,
                                       green: 0.404,
                                       blue: 0.404,
                                       alpha: 1)
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        layer.masksToBounds = true
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
            clearButtonMode = .whileEditing
            let clearButton = UIButton(type: .custom)
            clearButton.setImage(UIImage(named: "close_small"), for: .normal)
            clearButton.addTarget(self, action: #selector(deleteText), for: .touchUpInside)
            clearButton.tintColor = .black
            clearButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 20))
            rightViewContainer.addSubview(clearButton)

            rightView = rightViewContainer
            rightViewMode = .whileEditing
        if isSecure {
            isSecureTextEntry = true
            self.textContentType = .oneTimeCode
        }
    }
   
    @objc func deleteText() {
        self.text = ""
    }
    
    func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
}
