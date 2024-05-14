//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistModesViewController: UIViewController {
    @IBOutlet weak var contentView: PlaylistModesView!
    
    var model: PlaylistModesModel!
    
    private var songsByGenre: [Song] = []
    private var songsByAuthor: [Song] = []
    
    private var songsViewController: SongsViewController?
    
    enum DisplayMode: Int {
        case all 
        case byGenre
        case byAuthor
    }
    
    var displayMode: DisplayMode = .all {
        didSet { reloadTableView() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialState()
    }

    @IBAction private func didChangeSegmentControlValue(_ sender: UISegmentedControl) {
        displayMode = DisplayMode(rawValue: sender.selectedSegmentIndex)!
    }
}

extension PlaylistModesViewController: PlaylistModesModelDelegate {
    func dataDidLoad() {
        songsByGenre = model.items.sorted(by: { $0.genre < $1.genre })
        songsByAuthor = model.items.sorted(by: { $0.author < $1.author })
        
        displayMode = .all
    }
}

extension PlaylistModesViewController: PlaylistModesViewDelegate { }

private extension PlaylistModesViewController {
     func setupInitialState() {
        
        model = PlaylistModesModel()
        
        model.delegate = self
        contentView.delegate = self
    
        model.loadData()
    }
    
    func reloadTableView() {
        updateTableViewSongsData()
        contentView.tableView.reloadData()
    }
    
    func updateTableViewSongsData() {
        var songs: [Song] = []
        
        switch displayMode {
        case .all:
            songs = model.items
        case .byGenre:
            songs = songsByGenre
        case .byAuthor:
            songs = songsByAuthor
        }
        
        songsViewController = SongsViewController(songs: songs)
        contentView.tableView.delegate = songsViewController
        contentView.tableView.dataSource = songsViewController
    }
}
