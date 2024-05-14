//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        setupEditButton()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        
        model.delegate = self

        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func setupEditButton() {
        let rightBarButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func rightBarButtonTapped(_ sender: UIBarButtonItem) {
        contentView.tableView.isEditing.toggle()
        sender.title = contentView.tableView.isEditing ? "Done" : "Edit"
    }
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteViewDelegate {
    
}

extension PlaylistMoveDeleteViewController: UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItems = model.items.remove(at: sourceIndexPath.row)
        model.items.insert(movedItems, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             model.items.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
         }
     }
}

extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

