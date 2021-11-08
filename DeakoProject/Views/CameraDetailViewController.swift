//
//  CameraDetailViewController.swift
//  DeakoProject
//

import Foundation
import UIKit
import ChameleonFramework

// class that shows the details of a single camera
class CameraDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // tableview to display the camera data
    let tableView =  UITableView()
    // imageview to display the image from the security camera
    let imageView = UIImageView()
    // reuse identifier for table cells
    var cellId = "cameraCell"
    // identifiers for the camera details
    var fields = [ "Camera Label", "SID", "ID", "Zipcode", "Location", "Position", "Created at", "Created Meta", "Updated at", "Updated Meta", "Meta", "Ownership CD", "Plan Area", "Census Tracts", "Council Districts", "SPD Beats", "Image URL", "Video URL", "Web URL"]
    // the values for the specific camera being looked at
    var values: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // calls/runs setupTableView function
        setupTableView()
        // calls/runs setupImageView function
        setupImageView()
        
        // tableView delegates funcationality and dataSource to TrafficCameraViewController class (this class)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        // setting entire views background to the color flat navy blue (from chameleon framework)
        view.backgroundColor = FlatNavyBlueDark()
        // set what the navigation  bar displays
        navigationItem.title = "Details"
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        // setting tableView's background to the color flat navy blue dark (from chameleon framework)
        tableView.backgroundColor = FlatNavyBlueDark()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        // prevents tableView from automatically generating constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // sets tableView constraints
        tableView.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func setupImageView() {
        view.addSubview(imageView)
        
        // setting imageView's background to the color flat navy blue dark(from chameleon framework)
        imageView.backgroundColor = FlatNavyBlueDark()
        
        let url = URL(string: values[values.count - 3])!

        // fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // create Image and update imageView
            imageView.image = UIImage(data: data)
        }
        
        // prevents imageView from automatically generating constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // sets imageView constraints
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -24).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }

    // determines  then number of table cells corresponds with the fields array size
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // grab a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        // grab corresponding camera field with the table row
        var currentLastItem = fields[indexPath.row]
        // format the field with its identifier
        currentLastItem = currentLastItem + ": " + values[indexPath.row]
        // set the labels text to the formatted string
        cell.textLabel?.text = currentLastItem
        // setting cells text to the color flat white (from chameleon framework)
        cell.textLabel?.textColor = FlatWhite()
        // have cell text adjust width based on the lengh of it
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        // setting cell's background to the color flat navy blue (from chameleon framework)
        cell.backgroundColor = FlatNavyBlue()
        // have no selection highlighting in the table
        cell.selectionStyle = .none
        return cell
    }
}
