//
//  ViewController.swift
//  Elemental
//
//  Created by George Yu on 2018-12-20.
//  Copyright © 2018 George Yu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let gradientLayer = CAGradientLayer()
    let apiKey = "8c1e240150949fb7bfe0bf0503c8a20e"
    var lat = 43.4643
    var lon = -80.5204
    var activityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    var imageIndex = 0
    let backgroundImages: [UIImage] = [
        UIImage(named: "1.png")!,
        UIImage(named: "2.png")!,
        UIImage(named: "3.png")!,
        UIImage(named: "4.png")!,
        UIImage(named: "5.png")!,
        UIImage(named: "6.png")!,
        UIImage(named: "7.png")!,
        UIImage(named: "8.png")!,
        UIImage(named: "9.png")!,
        UIImage(named: "10.png")!,
        UIImage(named: "11.png")!,
        UIImage(named: "12.png")!,
        UIImage(named: "13.png")!,
        UIImage(named: "14.png")!,
        UIImage(named: "15.png")!,
        UIImage(named: "16.png")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2, y: (view.frame.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)
        locationManager.requestWhenInUseAuthorization()
        activityIndicator.startAnimating()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        setBackgroundImage()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            prevBackgroundImage()
       } else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            nextBackgroundImage()
       }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON { [self]
            response in
            self.activityIndicator.stopAnimating()
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                
                self.locationLabel.text = jsonResponse["name"].stringValue
                self.conditionImageView.image = UIImage(named: iconName)
                self.conditionLabel.text = jsonWeather["main"].stringValue
                self.temperatureLabel.text = String(Int(round(jsonTemp["temp"].doubleValue))) + "°"
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                let currentDateTime = Date()
                let formatter = DateFormatter()
                formatter.timeStyle = .none
                formatter.dateStyle = .long
                var dateString = formatter.string(from: currentDateTime)
                dateString = String(dateString.dropLast(6))
                self.dayLabel.text = dateFormatter.string(from: date) + ", " + dateString
                setBackgroundImage()
                
                
            }
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func setBackgroundImage() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if (0 <= hour && hour <= 3) {
            setBackgroundImage(imageIndex: 0)
            imageIndex = 0
        } else if (hour == 4) {
            setBackgroundImage(imageIndex: 1)
            imageIndex = 1
        } else if (hour == 5) {
            setBackgroundImage(imageIndex: 2)
            imageIndex = 2
        } else if (hour == 6) {
            setBackgroundImage(imageIndex: 3)
            imageIndex = 3
        } else if (hour == 7) {
            setBackgroundImage(imageIndex: 4)
            imageIndex = 4
        } else if (hour == 8) {
            setBackgroundImage(imageIndex: 5)
            imageIndex = 5
        } else if (hour == 9) {
            setBackgroundImage(imageIndex: 6)
            imageIndex = 6
        } else if (hour == 10) {
            setBackgroundImage(imageIndex: 7)
            imageIndex = 7
        } else if (11 <= hour && hour <= 15) {
            setBackgroundImage(imageIndex: 8)
            imageIndex = 8
        } else if (hour == 16) {
            setBackgroundImage(imageIndex: 9)
            imageIndex = 9
        } else if (hour == 17) {
            setBackgroundImage(imageIndex: 10)
            imageIndex = 10
        } else if (hour == 18) {
            setBackgroundImage(imageIndex: 11)
            imageIndex = 11
        } else if (hour == 19) {
            setBackgroundImage(imageIndex: 12)
            imageIndex = 12
        } else if (hour == 20) {
            setBackgroundImage(imageIndex: 13)
            imageIndex = 13
        } else if (hour == 21) {
            setBackgroundImage(imageIndex: 14)
            imageIndex = 14
        } else if (hour == 22) {
            setBackgroundImage(imageIndex: 15)
            imageIndex = 15
        } else if (hour == 23) {
            setBackgroundImage(imageIndex: 0)
            imageIndex = 0
        }
    }
    
    func setBackgroundImage(imageIndex: Int) {
        let toImage = backgroundImages[imageIndex]
        UIView.transition(with: self.backgroundImage, duration: 0.5, options: .transitionCrossDissolve, animations: {self.backgroundImage.image = toImage}, completion: nil)
    }
    
    func nextBackgroundImage() {
        if (imageIndex == 15) {
            imageIndex = 0
        } else {
            imageIndex += 1
        }
        setBackgroundImage(imageIndex: imageIndex)
    }
    func prevBackgroundImage() {
        if (imageIndex == 0) {
            imageIndex = 15
        } else {
            imageIndex -= 1
        }
        setBackgroundImage(imageIndex: imageIndex)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}
