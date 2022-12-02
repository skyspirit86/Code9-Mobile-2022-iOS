//
//  MasterViewController.swift
//  Code9-Mobile-2022-iOS
//
//  Created by Zolt Varga on 4/24/22.
//

import UIKit

class MasterViewController: UIViewController {
    
    // MARK: - UI
    
    let tableView = UITableView()
    
    lazy var spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Services and Data
    
    private let networking = Networking()
    private var clients: [Client]?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        // 1. This is needed to populate tableview with real data. UITableViewDataSource, UITableViewDelegate in extension
        tableView.dataSource = self
        tableView.delegate = self
        
        addNavigationButton()
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Small initial setup
        view.backgroundColor = .systemTeal
        title = "Master"
        
        // 2. Show Spinner to user till fetching from Network the data, so user can
        startSpinner()
        
        // 3. Fetch data from internet, async. This have delay what we never know will be 1s or 5s
        networking.fetchClients(completion: { cli in
            // 3.1. Set data to property of this class
            self.clients = cli
            
            // 3.2. Stop the spinner as data arived
            self.stopSpinner()
            
            // 3.3. Show table view to the user with data
            self.setupTableView()
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Setup tableview
    
    private func startSpinner() {
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 150).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        spinner.startAnimating()
    }
    
    private func stopSpinner() {
        
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    private func setupTableView() {
    
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // Need to register Cell to TableView. This could be iOS pre-defined or our custom cell
        tableView.register(ClientTableViewCell.self, forCellReuseIdentifier: "ClientTableViewCellId")
    }
    
    private func addNavigationButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    }
    
    // MARK: - Action
    @objc func logoutTapped() {
        let vc = LoginViewController()
        UIApplication.shared.windows.first?.rootViewController = vc
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = clients?.count ?? 0
        return count
    }
    
    // This method is called for every item in array of dataSource provider. Method above 'numberOfRowsInSection'
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 0. Check if list of data exist
        guard let clients = clients else { return  UITableViewCell() }
        
        // 1. Create Cell for table view with id, deque saves memory as reuse the cells.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientTableViewCellId", for: indexPath) as! ClientTableViewCell
        
        // 2. Set information to the Cell
        cell.textLabel?.text = clients[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // When clicking on the Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 0. Check if list of data exist
        guard let clients = clients else { return }
        
        // 1. Create destination
        let detailsViewController = DetailsViewController()
        let navigation = UINavigationController(rootViewController: detailsViewController)
        
        // 2. Pass information to the Destination ViewController. Property need to be defined in Destination ViewController
        detailsViewController.client = clients[indexPath.row]
        
        // 3. Show Destination ViewController
        present(navigation, animated: true)
    }
}
