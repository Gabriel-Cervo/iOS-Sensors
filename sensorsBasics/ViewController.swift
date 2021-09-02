//
//  ViewController.swift
//  sensorsBasics
//
//  Created by Joao Gabriel Dourado Cervo on 02/09/21.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func onAccelerometerTap(_ sender: UIButton) {
        performSegue(withIdentifier: "goToDetails", sender: SensorType.accelerometer)
    }
    
    @IBAction func onGyroscopeTap(_ sender: UIButton) {
        performSegue(withIdentifier: "goToDetails", sender: SensorType.gyroscope)
    }
    
    @IBAction func onMagnetometerTap(_ sender: UIButton) {
        performSegue(withIdentifier: "goToDetails", sender: SensorType.magnetometer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sensorType = sender as? SensorType {
            let vc = segue.destination as! ViewControllerDois
            vc.sensorType = sensorType
        }
    }
}

