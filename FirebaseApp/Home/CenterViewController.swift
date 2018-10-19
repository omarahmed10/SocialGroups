
import UIKit
import FirebaseCore
import FirebaseDatabase

class CenterViewController: UIViewController {
    
    var delegate : CenterViewControllerDelegate?
    enum CellIdentifiers {
        static let FeedCell = "FeedCell"
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func sidePanClicked(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }
    
}

extension CenterViewController : SidePanelSelectionDelegate {
    func selectFeed(with type: FeedType) {
        if type == .Main {
            getFeeds()
        }else {
            filteredFeeds = allFeeds.filter{
                $0.type == type
            }
            tableView.reloadData()
        }
        delegate?.toggleLeftPanel?()
    }
    
}

extension CenterViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let videoController = storyboard.instantiateViewController(withIdentifier: "FeedDetailsViewController") as? FeedDetailsViewController {
            delegate?.collapseSidePanels?()
            videoController.feedModel = filteredFeeds[indexPath.row]
            self.navigationController?.pushViewController(videoController, animated: true)
        }
    }
}
extension CenterViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.FeedCell, for: indexPath) as? FeedTableViewCell{
            cell.bind(model: filteredFeeds[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFeeds.count
    }
}
