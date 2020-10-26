import Foundation
import Combine

// A description of the class/file.
class SignUpViewModel {
	
	@Published var email: String = ""
	@Published var password: String = ""
	@Published var confirmedPassword: String = ""
	
	// Do we want to do UI logic here, or just a general one and let VC to do the further view validation?
	// For example: isEmailValid, isPasswordValid, isConfirmPasswordValid are now validations for views,
	// when it comes to areInputsValid, areInputs Valid will return true when there is no input.
	
	// areInputsValid will need another form of validations if UI logic to be done here.
	
	// Validation on UI
	// validate email
	var isEmailValid: AnyPublisher<Bool, Never> {
		return $email
			.debounce(for: 0.2, scheduler: RunLoop.main)
			.removeDuplicates()
			.map { $0.isEmpty || $0.isEmail }
			.eraseToAnyPublisher()
	}
	
	// minimum password character as 8
	var isPasswordValid: AnyPublisher<Bool, Never> {
		return $password
			.debounce(for: 0.2, scheduler: RunLoop.main)
			.removeDuplicates()
			.map { $0.count == 0 || $0.count >= 8 }
			.eraseToAnyPublisher()
	}
	
	// confirm password matching
	var isConfirmPasswordValid: AnyPublisher<Bool, Never> {
		return Publishers.CombineLatest($password, $confirmedPassword)
			.map{$0 == $1}
			.eraseToAnyPublisher()
	}
	
	// fulfill all condition to enable the button
	var areInputsValid: AnyPublisher<Bool, Never> {
		return Publishers.CombineLatest3(isEmailValid, isPasswordValid, isConfirmPasswordValid)
			.map{$0 && $1 && $2}
			.eraseToAnyPublisher()
	}
	
	// Submissiomn
	// SignUpParams?
}
