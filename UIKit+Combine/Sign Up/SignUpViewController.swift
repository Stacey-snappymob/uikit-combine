import UIKit
import Combine

// Protocol will be defined above class declaration.

// A description of the class/file.
class SignUpViewController: UIViewController, UITextFieldDelegate {
	//----------------------------------------
	// MARK: - Initialization
	//----------------------------------------
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.delegate = self
		
		viewModel = SignUpViewModel()
		
		// Doing it with AnyCancellable
//		stream = viewModel.$email
//			.print("Email")
//			.receive(on: RunLoop.main)
//			.sink { (inputValue) in
//				print("emailStream: \(inputValue)")
//			}
		
		// Listen to changes based on user input
		
		// Since we’re interacting with UIKit, we use receive(on:)
		// to make sure we receive from our publisher on the main run loop.
		viewModel.$email
			.print("Email")
			.receive(on: RunLoop.main)
			.sink { (inputValue) in
				print("emailStream: \(inputValue)")
			}
			.store(in: &streams)
		
		viewModel.$password
			.print("Password")
			//.receive(on: RunLoop.main)
			.sink { (inputValue) in
				print("passwordStream: \(inputValue)")
			}
			.store(in: &streams)
		
		viewModel.$confirmedPassword
			.print("Confirmed Password")
			.receive(on: RunLoop.main)
			.sink { (inputValue) in
				print("confirmPasswordStream: \(inputValue)")
			}
			.store(in: &streams)
		
		// UI changes
		viewModel.isEmailValid
			.receive(on: RunLoop.main)
			.assign(to: \.isHidden, on: emailErrorLabel)
			.store(in: &streams)
		
		viewModel.isPasswordValid
			.receive(on: RunLoop.main)
			.assign(to: \.isHidden, on: passwordErrorLabel)
			.store(in: &streams)
		
		viewModel.isConfirmPasswordValid
			.receive(on: RunLoop.main)
			.assign(to: \.isHidden, on: confirmPasswordErrorLabel)
			.store(in: &streams)
		
		viewModel.areInputsValid
			.receive(on: RunLoop.main)
			.assign(to: \.isEnabled, on: signUpButton)
			.store(in: &streams)
	}
	
	//----------------------------------------
	// MARK: - Actions
	//----------------------------------------
	
	
	@IBAction func textFieldEditingChange(_ sender: UITextField) {
		switch sender {
		case emailTextField:
			viewModel.email = sender.text ?? ""
			
		case passwordTextField:
			viewModel.password = sender.text ?? ""
			
		case confirmPasswordTextField:
			viewModel.confirmedPassword = sender.text ?? ""
			
		default:
			fatalError("text field: \(sender) is not handled.")
		}
	}
	
	@IBAction func signUpButtonDidTap(_ sender: UIButton) {
		print("Sign Up")
	}
	
	
	//----------------------------------------
	// MARK: - Internals
	//----------------------------------------
	@IBOutlet private var emailTextField: UITextField!
	@IBOutlet private var passwordTextField: UITextField!
	@IBOutlet private var confirmPasswordTextField: UITextField!
	@IBOutlet private var emailErrorLabel: UILabel!
	@IBOutlet private var passwordErrorLabel: UILabel!
	@IBOutlet private var confirmPasswordErrorLabel: UILabel!
	@IBOutlet private var signUpButton: UIButton!
	
	private var viewModel: SignUpViewModel!
	
	// Need to keep it in memory
	private var stream: AnyCancellable?
	private var streams = Set<AnyCancellable>()
}
