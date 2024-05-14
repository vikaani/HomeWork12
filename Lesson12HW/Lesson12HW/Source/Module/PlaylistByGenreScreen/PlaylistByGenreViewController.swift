//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistByGenreViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
    var model: PlaylistByGenreModel!
    
    private var genreSections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    private func setupInitialState() {
        
        model = PlaylistByGenreModel()
        
        model.delegate = self
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        model.loadData()
    }
}

extension PlaylistByGenreViewController: PlaylistByGenreModelDelegate {
    func dataDidLoad() {
        genreSections = Dictionary(grouping: model.items, by: { $0.genre })
            .map { key,value in Section(title: key, items: value) }
            .sorted(by: { $0.title < $1.title } )

        contentView.tableView.reloadData()
    }
}

extension PlaylistByGenreViewController: PlaylistByGenreViewDelegate {
    
}

extension PlaylistByGenreViewController: UITableViewDelegate {
    
}

extension PlaylistByGenreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        genreSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        genreSections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genreSections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") as? MainPlaylistCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = genreSections[indexPath.section].items[indexPath.row]
        cell.authorLabel.text = item.author
        cell.songTitleLabel.text = item.songTitle
        cell.albumTitle.text = item.albumTitle
        cell.genreLabel.text = item.genre

        return cell
    }
}

struct Section {
    let title: String
    let items: [Song]
}
