//
//  CameraTableCell.swift
//  DeakoProject
//
//

import Foundation
import UIKit
import ChameleonFramework

// custom table view cell class used for the traffic camera table
class CameraTableCell : UITableViewCell {
 
    // camera that this cell correlates to
    var camera : TrafficCam? {
        didSet {
            //set the label text to the camera name
            cameraNameLabel.text = camera?.cameralabel
        }
    }
 
    // label that will display the camera name
    let cameraNameLabel : UILabel = {
        let lbl = UILabel()
        // setting text color to the color flat white (from chameleon framework)
        lbl.textColor = FlatWhite()
        // setting the font to System size 14
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        // align the text in the center
        lbl.textAlignment = .center
        return lbl
    }()
 
    // image that will display the camera icon
    let rightSideImage : UIImageView = {
        // grab the image from the assets
        let image = UIImage(named: "TrafficCamArrow")
        // set the imageview with the image
        let imageView = UIImageView(image: image)
        // fit the image while keeping the aspect ratio
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
 
 
    // image that will display the right arrow icon
    private let cameraIconImage : UIImageView = {
        // grab the image from the assets
        let image = UIImage(named: "TrafficCamIcon")
        // set the imageview with the image
        let imageView = UIImageView(image: image)
        // fit the image while keeping the aspect ration
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
 
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // prevents label and imageViews from automatically generating constraints
        cameraIconImage.translatesAutoresizingMaskIntoConstraints = false
        cameraNameLabel.translatesAutoresizingMaskIntoConstraints = false
        rightSideImage.translatesAutoresizingMaskIntoConstraints = false
        // then add them to the cell view
        addSubview(cameraIconImage)
        addSubview(cameraNameLabel)
        addSubview(rightSideImage)


        // adds contrainsts to the label and imageViews
        
        cameraIconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8) .isActive = true
        cameraIconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        cameraNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cameraNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        rightSideImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        rightSideImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
