import Foundation

extension String {
    enum ValidTypes {
        case name
        case surname
        case email
        case password
        case confirmPassword(String)
    }
    
    enum Regex: String {
        case name = "[а-яА-Яa-zA-Z]{3,}"
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        case password = ".{10,}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .surname: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        case .password: regex = Regex.password.rawValue
        case .confirmPassword(let originalPassword):
            return self == originalPassword
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
