import Foundation

class TableViewModel {
	/// Data source for the table view.
	@Published var tableDataSource: [String] = ["Hi", "You", "Are"]
	
	var numberOfRows: Int {
		return tableDataSource.count
	}
	
	/// Provides the view with appropriate cell type corresponding to an index.
	func cellItem(forIndex indexPath: IndexPath)-> String {
		tableDataSource[indexPath.row]
	}
	
	/// Add item
	func addItem(item: String) {
		tableDataSource.append(item)
	}
}
