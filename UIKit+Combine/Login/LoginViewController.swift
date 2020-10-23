import UIKit
import Combine

/// A description of the class/file.
class LoginViewController: UIViewController {
    //----------------------------------------
    // MARK: - Initialization
    //----------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
		
		viewModel = LoginViewModel()
		
		setupBindings()
    }

    //----------------------------------------
    // MARK: - Actions
    //----------------------------------------
	@IBAction func loginButtonDidTap(_ sender: Any) {
		print("Login")
	}
	
	//----------------------------------------
	// MARK:- Internal methods
	//----------------------------------------
	private func setupBindings() {
		// Bind view to view model
		emailTextField.textPublisher
			.receive(on: DispatchQueue.main)
			.assign(to: \.email, on: viewModel)
			.store(in: &bindings)
		
		passwordTextField.textPublisher
			.receive(on: DispatchQueue.main)
			.assign(to: \.password, on: viewModel)
			.store(in: &bindings)
		
		// Bind view model to view
		viewModel.validatedEmail
			.receive(on: RunLoop.main)
			.assign(to: \.isHidden, on: emailErrorLabel)
			.store(in: &bindings)
		
		viewModel.validatedInputs
			.receive(on: RunLoop.main)
			.assign(to: \.isEnabled, on: loginButton)
			.store(in: &bindings)
	}

    //----------------------------------------
    // MARK: - Internals
    //----------------------------------------
	@IBOutlet private var emailTextField: UITextField!
	@IBOutlet private var emailErrorLabel: UILabel!
	@IBOutlet private var passwordTextField: UITextField!
	@IBOutlet private var loginButton: UIButton!
	
	private var viewModel: LoginViewModel!
	private var bindings = Set<AnyCancellable>()
}

extension UITextField {
	var textPublisher: AnyPublisher<String, Never> {
		NotificationCenter.default
			.publisher(for: UITextField.textDidChangeNotification, object: self)
			.compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
			.map { $0.text ?? "" } // mapping UITextField to extract text
			.eraseToAnyPublisher()
	}
}
