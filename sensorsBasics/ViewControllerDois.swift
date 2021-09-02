//
//  ViewControllerDois.swift
//  sensorsBasics
//
//  Created by Joao Gabriel Dourado Cervo on 02/09/21.
//

import UIKit
import CoreMotion

enum SensorType: String {
    case accelerometer = "Accelerometer"
    case gyroscope = "Gyroscope"
    case magnetometer = "Magnetometer"
    
    var fields: [String] {
        if self == .accelerometer {
            return ["", "", ""]
        } else if self == .gyroscope {
            return ["", "", ""]
        }
        
        // Magnetometer
        return ["", "", ""]
    }
}

class ViewControllerDois: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var typeTitle: UILabel!
    
    @IBOutlet weak var value1: UILabel!
    
    @IBOutlet weak var value2: UILabel!
    
    @IBOutlet weak var value3: UILabel!
    
    var sensorType: SensorType = .accelerometer
    
    let motion = CMMotionManager()
    
    let refreshInterval: Double = 1.0 / 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeTitle.text = sensorType.rawValue
        startSensor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopSensor()
    }
    
    //MARK: - Start and Stop Sensor
    func startSensor() {
        if sensorType == .accelerometer && motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = refreshInterval
            self.motion.startAccelerometerUpdates(to: .main) {  [weak self] in self?.handleAccelerometerData(data: $0, error: $1)
            }
        }
        
        if sensorType == .gyroscope && motion.isGyroAvailable {
            self.motion.gyroUpdateInterval = refreshInterval
            self.motion.startGyroUpdates(to: .main) { [weak self] in
                self?.handleGyroData(data: $0, error: $1)
            }
        }
            
        if sensorType == .magnetometer && motion.isMagnetometerAvailable {
            self.motion.magnetometerUpdateInterval = refreshInterval
            self.motion.startMagnetometerUpdates(to: .main) { [weak self] in
                self?.handleMagnetometerData(data: $0, error: $1)
            }
        }
    }
    
    func stopSensor() {
        self.motion.stopDeviceMotionUpdates()
    }

    //MARK: - Handle sensor changes
    private func handleAccelerometerData(data: CMAccelerometerData?, error: Error?) {
        guard let data = data, error == nil else { return }
        
        self.value1.text = String(format: "X: %.3f g", data.acceleration.x)
        self.value2.text = String(format: "Y: %.3f g", data.acceleration.y)
        self.value3.text = String(format: "Z: %.3f g", data.acceleration.z)
    }
    
    private func handleGyroData(data: CMGyroData?, error: Error?) {
        guard let data = data, error == nil else { return }
        
        self.value1.text = String(format: "Pitch: %.3f degrees", data.rotationRate.x)
        self.value2.text = String(format: "Yaw: %.3f degrees", data.rotationRate.y)
        self.value3.text = String(format: "Roll: %.3f degrees", data.rotationRate.z)
    }
    
    private func handleMagnetometerData(data: CMMagnetometerData?, error: Error?) {
        guard let data = data, error == nil else { return }
    
        self.value1.text = String(format: "Field X: %.3f uT", data.magneticField.x)
        self.value2.text = String(format: "Field Y: %.3f uT", data.magneticField.y)
        self.value3.text = String(format: "Field Z: %.3f uT", data.magneticField.z)
    }
}
