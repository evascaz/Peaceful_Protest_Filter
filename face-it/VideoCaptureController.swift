//
//  VideoCaptureController.swift
//  face-it
//
//  Created by Derek Andre on 4/21/16.
//  Copyright © 2016 Derek Andre. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

class VideoCaptureController: UIViewController {
    var videoCapture: VideoCapture?
    
    
    
    override func viewDidLoad() {
        videoCapture = VideoCapture()
        startCapturing()
    
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
//         startCapturing()
        
    }
    
    override func didReceiveMemoryWarning() {
//        stopCapturing()
    }
    
    func startCapturing() {
        do {
            try videoCapture!.startCapturing(self.view)
        }
        catch {
            // Error
        }
    }

    @IBOutlet weak var screenShotButton: UIButton!
    
    

    // when you press button take screenshot
    @IBAction func screenshotTaken(_ sender: UIButton) {
    

            UIGraphicsBeginImageContext(self.view!.bounds.size)
            self.view!.window!.layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
            print("screenshot taken")


    }
    

    
    //           let screenshot:VideoCapture = UIGraphicsGetImageFromCurrentImageContext()

    
    

    

//    func stopCapturing() {
//        VideoCapture!.stopCapturing()
//    }
    
    func touchDown(_ sender: AnyObject) {
        let button = sender as! UIButton
        button.setTitle("Stop", for: UIControlState())
        
//        startCapturing()
    }
    
    func touchUp(_ sender: AnyObject) {
        let button = sender as! UIButton
        button.setTitle("Start", for: UIControlState())
        
//        stopCapturing()
    }
    
    
}


//video screenshot??? doesn't work
    //      DispatchQueue.main.async {
//    //var dataOutput: AVCaptureVideoDataOutput?
//    self.videoCapture?.captureOutput(AVCaptureOutput!, didOutputSampleBuffer: <#T##CMSampleBuffer!#>, from: <#T##AVCaptureConnection!#>)
//    self.videoCapture.captureStillImageAsynchronouslyFromConnection(self.stillImageOutput.connectionWithMediaType(kCMMediaType_Video), completionHandler: {
//    (imageDataSampleBuffer: CMSampleBuffer?, error: NSError?) -> Void in
//    
//    
//    if (imageDataSampleBuffer != nil)
//    {
//    if(error != nil)
//    {
//    completion!(image:nil, error:nil)
//    
//    }
//    }
//    
//    else if (imageDataSampleBuffer != nil) {
//    var imageData: NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
//    var image: UIImage = UIImage(data: imageData)!
//    completion!(image:image, error:nil)
//    }
//    })
//    
//}

