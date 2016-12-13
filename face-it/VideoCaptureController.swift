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
import AVFoundation

class VideoCaptureController: UIViewController {
    var videoCapture: VideoCapture?
    
    @IBOutlet weak var buttonView: UIView!
    override func viewDidLoad() {
        videoCapture = VideoCapture()
        startCapturing()
        
        self.view.addSubview(buttonView)
    
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
        
            //capturePicture()
        

            UIGraphicsBeginImageContext(self.view!.bounds.size)
            self.view!.window!.layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
            print("screenshot taken")
        
//        func screenShotMethod() {
//            let layer = UIApplication.shared.keyWindow!.layer
//            let scale = UIScreen.main.scale
//            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
//            
//            layer.render(in: UIGraphicsGetCurrentContext()!)
//            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
//            print("screenshot registered")
//        }

    }
    

    


    func touchDown(_ sender: AnyObject) {
        let button = sender as! UIButton
        button.setTitle("Stop", for: UIControlState())
        

    }
    
    func touchUp(_ sender: AnyObject) {
        let button = sender as! UIButton
        button.setTitle("Start", for: UIControlState())
        
    }
    
    func capturePicture(){
        
        //println("Capturing image")
        videoCapture?.image?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        videoCapture?.session?.addOutput(videoCapture?.dataOutput)
        
        if let videoConnection = videoCapture?.image?.connection(withMediaType: AVMediaTypeVideo){
            videoCapture?.image?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {
                (sampleBuffer, error) in
                var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                var dataProvider = CGDataProvider(data: imageData as! CFData)
                var cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                var image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                
                var imageView = UIImageView(image: image)
                imageView.frame = CGRect(x:0, y:0, width:720, height:1280)
                
                //Show the captured image to
                self.view.addSubview(imageView)
                
                //Save the captured preview to image
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                
            })
        }
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

