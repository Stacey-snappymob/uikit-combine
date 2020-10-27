import Foundation

// A description of the class/file.
class StringViewModel {
	//----------------------------------------
	// MARK:- Initialization
	//----------------------------------------

	init(item: String) {
		self.item = item
	}

	//----------------------------------------
	// MARK:- Presentation
	//----------------------------------------

	var title: String {
		return item
	}
	
	//----------------------------------------
	// MARK:- Internals
	//----------------------------------------
	let item: String
}
