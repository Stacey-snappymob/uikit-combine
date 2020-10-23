import Foundation
import Combine

/// A description of the class/file.
class LoginViewModel: ObservableObject {
	@Published var email: String = ""
	
	@Published var password: String = ""
	
	var validatedEmail : AnyPublisher<Bool, Never> {
		return $email
			.debounce(for: 0.2, scheduler: RunLoop.main)
			.removeDuplicates()
			.map { $0.isEmpty || $0.isEmail }
			.eraseToAnyPublisher()
	}
	
	lazy var validatedInputs = Publishers.CombineLatest($email, $password)
		.map { $0.count > 2 && $1.count > 2 }
		.eraseToAnyPublisher()
}

extension String {
	public var isEmail: Bool {
		let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
		
		let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: count))
		
		return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
	}
}
