//
//  MainPlaylistViewController.swift
//  Lesson12HW
//

//

import UIKit

class MainPlaylistViewController: UIViewController {
    
    @IBOutlet weak var contentView: MainPlaylistView!
    var model: MainPlaylistModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = MainPlaylistModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

extension MainPlaylistViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension MainPlaylistViewController: MainPlaylistViewDelegate {
    
}

extension MainPlaylistViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell")  as?  MainPlaylistCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
        
        cell.authorLabel.text = item.author
        cell.songTitleLabel.text = item.songTitle
        cell.albumTitle.text = item.albumTitle
        cell.genreLabel.text = item.genre
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedSong = model.items.remove(at: sourceIndexPath.row)
        model.items.insert(movedSong, at: destinationIndexPath.row)
    }
}

extension MainPlaylistViewController: UITableViewDelegate {
    
}

