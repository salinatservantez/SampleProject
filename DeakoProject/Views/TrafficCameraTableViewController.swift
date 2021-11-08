//
// SecCameraTableViewController.swift
//  DeakoProject
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import ChameleonFramework

// initial view controller. table for displaying all of the cmaeras
class TrafficCameraTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    // the tableview that will display the cameras
    let tableView =  UITableView()
    // reuse identifier for the tableview cells
    let cellId = "cellId"
    // the list of traffic camers to display
    var trafficCams : [TrafficCam] = []
    // location mansger for pulling the user location
    var locationManager = CLLocationManager()
    // tne users current location
    var currentlocation:CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // delegates locationManger functionality to the TrafficCameraTableViewController class (this class)
        locationManager.delegate = self
        //  permission request to get user location
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // setting entire backgroud to the color flat navy blue (from chameleon framework)
        view.backgroundColor = FlatNavyBlue()
    
        // adds a clear view to top of the tableview to stop header floating
        let dummyViewHeight = CGFloat(100)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        // tableView delegates funcationality and dataSource to TrafficCameraViewController class (this class)
        tableView.delegate = self
        tableView.dataSource = self
        // calls/runs setupTableView function
        setupTableView()
        
        // calls/runs setUpNavigation function
        setUpNavigation()
    }
    
    // this function adds visuals to navigation bar
    func setUpNavigation() {
        // removes border from navigation bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // determines displayed text on nav bar
        navigationItem.title = "Get Started"
        // setting navigation bar to the color flat navy blue dark (from chameleon framework)
        self.navigationController?.navigationBar.barTintColor = FlatNavyBlueDark()
        // removes translucent overlay on the navigation bar
        self.navigationController?.navigationBar.isTranslucent = false
        // setting navigation bar text (get started) to the color flat white (from chameleon framework)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: FlatWhite()]
    }
    
    // the setupTableView function constrains tableView and grabs API data for the t-camera table
    func setupTableView() {
        view.addSubview(tableView)
        // setting tableView's space between cells and header to the color flat navy blue (from chameleon framework)
        tableView.backgroundColor = FlatNavyBlue()
        // registers any cell with the cellId identifier to use custom cell class CameraTableCell
        tableView.register(CameraTableCell.self, forCellReuseIdentifier: cellId)
        
        
        // prevents tableView from automatically generating constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // sets tableView constraints
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  17).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17).isActive = true
    
        // traffic camera data location
        let request = AF.request("https://mobile-takehome.s3.amazonaws.com/cached_seattle_traffic_cam_data.json")
        // pulls data from mock API
        request.responseJSON { (response) in
            switch response.result {
            // looks for data iff request was successful
            case .success(let value):
                // converts data request response to JSON
                let json = JSON(value)
                
                self.trafficCams = []
                // loops through data for each individual camera
                for cam in json["data"].arrayValue {
                      
                   // converts camera JSON into swift data model
                    var camera = TrafficCam()
                    camera.sid = cam[0].string ?? "NULL"
                    camera.id = cam[1].string ?? "NULL"
                    camera.position = cam[2].intValue
                    camera.created_at = cam[3].intValue
                    camera.created_meta = cam[4].intValue
                    camera.updated_at = cam[5].intValue
                    camera.updated_meta = cam[6].intValue
                    camera.meta = cam[7].string ?? "NULL"
                    camera.ownershipcd = cam[8].string ?? "NULL"
                    camera.cameralabel = cam[9].string ?? "NULL"
                    camera.imageurl = cam[10][0].string ?? "NULL"
                    camera.videourl = cam[11].string ?? "NULL"
                    camera.weburl = cam[12].string ?? "NULL"
                    camera.xpos = cam[13].doubleValue
                    camera.ypos = cam[14].doubleValue
                    camera.location = CLLocation(latitude: camera.ypos, longitude: camera.xpos)
                    camera.plan_area = cam[16].string ?? "NULL"
                    camera.census_tracts = cam[17].string ?? "NULL"
                    camera.council_dist = cam[18].string ?? "NULL"
                    camera.spdbeats = cam[19].string ?? "NULL"
                    camera.zipcode = cam[20].string ?? "NULL"
                   
                    // adds all camera data to
                    self.trafficCams.append(camera)
                }
                //checks for location permissions
                if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == .authorizedAlways) {
                    // if it has permission - grabs user location from device
                    self.currentlocation = self.locationManager.location
                    // and sorts location by distance from the users location
                    self.trafficCams.sort(by: {$0.location.distance(from: self.currentlocation ?? CLLocation()) < $1.location.distance(from: self.currentlocation ?? CLLocation())})
                }
                // reloads table after the loop has iterated through each camera in order to display data
                self.tableView.reloadData()
            // if request fails - prints error
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    // generates cells for the tableView
    func tableView(_ _tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // grabs a cell using the identifier cellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CameraTableCell
       // grabs the camera that corresponds with the given row
        let currentLastItem = trafficCams[indexPath.section]
       // populates the cell with camera information
        cell.camera = currentLastItem
       // setting cells background to the color flat navy blue dark (from chameleon framework)
        cell.backgroundColor = FlatNavyBlueDark()
        // rounds cell corners
        cell.layer.cornerRadius = 5
        // manages cell highlight when selected
        cell.selectionStyle = .gray
        //  test code:
        return cell
        
    }
    // sets one row per section
    func tableView(_ _tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    // sets the number of sections to the number of cameras b/c the section header will peoduce space btw cells
    func numberOfSections(in tableView: UITableView) -> Int {
        return trafficCams.count
    }
    
    // height for a single row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // makes header for each section and header message at the top of the table
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       // subview used for header
        let headerView = UIView()
        // if this section is the first section -  add label and little blue divider
        if section == 0 {
            let messageLabel = UILabel()
            let lineLabel = UILabel()
            
            // prevents labels from automatically generating constraints
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            lineLabel.translatesAutoresizingMaskIntoConstraints = false
            // creates little divider within header
            lineLabel.text = "____"
           // header text
            messageLabel.text = "Nearest traffic cameras"
            // setting divider line to the color flat sky blue and header text color to flat white (from chameleon framework)
            lineLabel.textColor = FlatSkyBlue()
            messageLabel.textColor = FlatWhite()
            // specifying font and size
            messageLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 25)
            lineLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
           // adding text and divider to the header view
            headerView.addSubview(messageLabel)
            headerView.addSubview(lineLabel)
            
            // adding contraints to the text and divider within the header section
            messageLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -13).isActive = true
            messageLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
            lineLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 13).isActive = true
            lineLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
            
        } else {
            // make all other headers clear
            headerView.backgroundColor = UIColor.clear
        }
        return headerView
     }
     
    // makes the header view heigh 100 and other subsequent headers 17
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        } else {
            return 17
        }
    }
   
    // selects row when pressed on 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newView = CameraDetailViewController()
        var fieldValue: [String] = []
        let camera = trafficCams[indexPath.section]
        
        // puts camera data in desired order for detail view display
        fieldValue.append(camera.cameralabel)
        fieldValue.append(camera.sid)
        fieldValue.append(camera.id)
        fieldValue.append(camera.zipcode)
        let location = "( " + String(camera.ypos) + ", " + String(camera.xpos) + " )"
        fieldValue.append(location)
        fieldValue.append(String(camera.position))
        fieldValue.append(String(camera.created_at))
        fieldValue.append(String(camera.created_meta))
        fieldValue.append(String(camera.updated_at))
        fieldValue.append(String(camera.updated_meta))
        fieldValue.append(camera.meta)
        fieldValue.append(camera.ownershipcd)
        fieldValue.append(camera.plan_area)
        fieldValue.append(camera.census_tracts)
        fieldValue.append(camera.council_dist)
        fieldValue.append(camera.spdbeats)
        fieldValue.append(camera.imageurl)
        fieldValue.append(camera.videourl)
        fieldValue.append(camera.weburl)
        
        // gives new view the data in desired order
        newView.values = fieldValue
        // making the new view the current view
        self.navigationController?.pushViewController(newView, animated: true)
        // deselectes the selected table cell
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
    // records user permission response
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //if user allowed for location permission
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
   
    // Resets table order when user location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //set the current location to the newly grabbed location
        currentlocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        // and sorts location by distance from the users location
        trafficCams.sort(by: {$0.location.distance(from: currentlocation) < $1.location.distance(from: currentlocation)})
        tableView.reloadData()
    }

}
