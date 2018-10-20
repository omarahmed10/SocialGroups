
import UIKit
import Firebase

class CenterViewController: UIViewController {
    
    var delegate : CenterViewControllerDelegate?
    enum CellIdentifiers {
        static let GroupCell = "GroupCell"
    }
    @IBOutlet weak var tableView: UITableView!
    
    var allGroups = [Group]()
    var filteredGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        beginMyGroupFetch()
    }
    
    @IBAction func sidePanClicked(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }
    
    func beginExploreGroupFetch() {
        filteredGroups = [Group]()
        fetchGroups { newGroups in
            self.allGroups = newGroups
            if let currentUser = UserService.currentUserProfile {
                self.filteredGroups = self.allGroups.filter{
                    return !$0.nationalities.contains(currentUser.nationality) && !$0.users.contains(currentUser.uid)
                }
            }
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
            }
        }
    }
    
    func beginMyGroupFetch() {
        filteredGroups = [Group]()
        fetchGroups { newGroups in
            self.allGroups = newGroups
            if let currentUser = UserService.currentUserProfile {
                self.filteredGroups = self.allGroups.filter{
                    return $0.users.contains(currentUser.uid)
                }
            }
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchGroups(completion:@escaping (_ groups:[Group])->()) {
        let postsRef = Database.database().reference().child("Groups")
        postsRef.observe(.value, with: { snapshot in
            var tempGroups = [Group]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let coverURL = dict["coverURL"] as? String,
                    let desc = dict["desc"] as? String,
                    let name = dict["name"] as? String,
                    let id = dict["id"] as? String,
                    let nationalities = dict["nationalities"] as? [String],
                    let profileURL = dict["profileURL"] as? String,
                    let users = dict["users"] as? [String],
                    let cURL = URL(string: coverURL),
                    let pURL = URL(string: profileURL){
                    var posts = [String]()
                    if let postsID = dict["postsID"] as? [String] {
                        posts = postsID
                    }
                    let newGroup = Group(id: id, nationalities: nationalities, postsID: posts, name: name, desc: desc, coverURL: cURL, profileURL: pURL, users: users)
                    tempGroups.insert(newGroup, at: 0)
                }
            }
            
            return completion(tempGroups)
        })
    }
    
}

extension CenterViewController : SidePanelViewControllerDelegate {
    func showMyGroups() {
        beginMyGroupFetch()
        delegate?.toggleLeftPanel?()
    }
    
    func exploreGroups() {
        beginExploreGroupFetch()
        delegate?.toggleLeftPanel?()
    }
    
    func openMyProfile() {
        delegate?.toggleLeftPanel?()
    }
    
    //    func selectFeed(with type: FeedType) {
    //        if type == .Main {
    //            getFeeds()
    //        }else {
    //            filteredFeeds = allFeeds.filter{
    //                $0.type == type
    //            }
    //            tableView.reloadData()
    //        }
    //        delegate?.toggleLeftPanel?()
    //    }
    
}

extension CenterViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? HomeViewController {
            let postsID = filteredGroups[indexPath.row].postsID
            vc.postsID = postsID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension CenterViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.GroupCell, for: indexPath) as? PostTableViewCell{
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
}
