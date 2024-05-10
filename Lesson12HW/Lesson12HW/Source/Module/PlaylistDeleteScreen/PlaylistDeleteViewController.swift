//
//  PlaylistDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistDeleteView!
    var model: PlaylistDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistDeleteModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
}

extension PlaylistDeleteViewController: PlaylistDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension PlaylistDeleteViewController: PlaylistDeleteViewDelegate {
    
}

extension PlaylistDeleteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") as? MainPlaylistCell
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
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension PlaylistDeleteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
