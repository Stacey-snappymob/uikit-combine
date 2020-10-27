import UIKit
import Combine

// A description of the class/file.
class TableViewController: UIViewController {
	//----------------------------------------
	// MARK: - Initialization
	//----------------------------------------
	
	// Define view initialization and viewDidLoad().
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel = TableViewModel()
		
		// Configure for table view
		StringTableViewCell.registerWithTable(tableView)
		
		tableView.dataSource = self
		anyCancellable = viewModel.$tableDataSource
			.print("Datasource:")
			.receive(on: RunLoop.main)
			.sink { [weak self] items in
				self?.tableView.reloadData()
			}
	}
	
	//----------------------------------------
	// MARK: - Actions
	//----------------------------------------
	
	@IBAction func addButtonDidTap(_ sender: Any) {
		print("Wow")
		viewModel.addItem(item: "Wow")
	}
	
	//----------------------------------------
	// MARK: - Internals
	//----------------------------------------
	
	@IBOutlet private var tableView: UITableView!
	
	private var viewModel: TableViewModel!
	
	private var anyCancellable: AnyCancellable?
}

extension TableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: StringTableViewCell.reuseIdentifier, for: indexPath) as! StringTableViewCell
		cell.bindViewModel(StringViewModel(item: viewModel.cellItem(forIndex: indexPath)))
		return cell
	}
	
	// TODO: Put in View Model
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	// TODO: Put in View Model
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return section == 0 ? "Section 1" : "Section 2"
	}
}
