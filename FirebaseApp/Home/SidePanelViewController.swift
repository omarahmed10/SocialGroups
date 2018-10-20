import UIKit

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menu = ["My Groups","Explore Groups"]
    var delegate : SidePanelViewControllerDelegate?
    enum CellIdentifiers {
        static let MenuCell = "MenuCell"
        static let SocialMediaCell = "SocialMediaCell"
    }
    
    let images1 = [#imageLiteral(resourceName: "icons8-home-50"),#imageLiteral(resourceName: "icons8-news-50"),#imageLiteral(resourceName: "icons8-music-50"),#imageLiteral(resourceName: "icons8-documentary-50")]
//    let images2 = [#imageLiteral(resourceName: "icons8-play-button-filled-50"),#imageLiteral(resourceName: "icons8-snapchat-filled-50"),#imageLiteral(resourceName: "icons8-sent-filled-50"),#imageLiteral(resourceName: "icons8-instagram-50")]
//    let titles = ["Youtube","SnapChat","Telegram","Instagram"]
//    let urls = ["https://www.youtube.com/channel/UC6PjoUHuropUbFagibBjF2g?app=desktop","https://www.snapchat.com/add/fag-1407","https://t.me/fagihalshehri1407","https://www.instagram.com/fagih_alshehri/?utm_source=ig_profile_share&igshid=5ejgppsg14i9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: Table View Data Source
extension SidePanelViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MenuCell, for: indexPath) as? MenuTableViewCell{
            switch indexPath.section {
            case 0 :
                cell.bind(model: menu[indexPath.row],image: images1[indexPath.row])
//            case 1:
//                cell.bind(model: titles[indexPath.row],image: images2[indexPath.row])
            case 1:
                cell.bind(model: "Share",image: #imageLiteral(resourceName: "icons8-share-26"))
            default:
                break
            }
            return cell
        }
         return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let back = UIView()
        back.backgroundColor = UIColor.clear
        let label = UILabel(frame: CGRect(x: 10.0, y: 10.0, width: tableView.contentSize.width, height: 30.0))
        switch section {
//        case 1:
//            label.text = "Communicate"
        case 1:
            label.text = "Share"
        default:
            label.text = ""
        }
        label.textColor = UIColor.gray
        back.addSubview(label)
        return back
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return menu.count
//        case 1:
//            return 4
        case 1:
            return 1
        default:
            return 0
        }
        
    }
}

// Mark: Table View Delegate
extension SidePanelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:delegate?.showMyGroups()
            case 1:delegate?.exploreGroups()
            case 2:delegate?.openMyProfile()
            default:break
            }
//        case 1:
//            UIApplication.tryURL(urls: [urls[indexPath.row]])
        case 1:
            let activityVC = UIActivityViewController(activityItems: ["https://play.google.com/store/apps/details?id=com.ezzat.islamacdemy"], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        default:
            break
        }
    }
}
