//
//  ImageCaptureHelper.swift
//  Panicure
//
//  Created by Sam Meech Ward on 2016-03-06.
//  Copyright © 2016 Panicuru. All rights reserved.
//

import Foundation
import AVFoundation
import ImageIO

class ImageCaptureHelper: NSObject {

    
    typealias RequestCameraAuthorizationBlock = (authorized: Bool) -> Void
    
    
    func capture(completion: (image: UIImage?, error: NSError?) -> Void) {
        
        // Create a new session to manage taking pictures
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        // For some reason we have to add to the layer even though this layer is never added to the view heirarchy
        let layer = AVCaptureVideoPreviewLayer(session: session)
        
        // Grab the camera device
        let camera = frontFacingCamera()
        
        var input: AVCaptureDeviceInput?
        do {
            input = try AVCaptureDeviceInput(device: camera)
        } catch {
            print("error trying to open camera")
            return
        }

        // Add the input to the session
        session.addInput(input)
        
        // Create a new jpeg output
        let imageOutput = stillImageOutput()
        
        // Add the output to teh session
        session.addOutput(imageOutput)
        
        session.startRunning()
        
        // Get the correct connection
        let videoConnection = backCameraConnection(imageOutput)
        
        if videoConnection == nil {
            completion(image: nil, error: NSError(domain: "error", code: 69, userInfo: nil))
            return
        }
        
        // Grab an image
        imageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection) { (imageSampleBuffer: CMSampleBuffer!, error: NSError!) -> Void in
            
            let exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, nil)
            
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
            let image: UIImage = UIImage(data: imageData)!
            
            if exifAttachments != nil {
                // Do something with the attachments
            }
            
            // Continue
            
            completion(image: image, error: nil)
        }
    }
    
    private func backCameraConnection(stillImageOutput: AVCaptureStillImageOutput) -> AVCaptureConnection? {
        var videoConnection: AVCaptureConnection?
        
        // Loop through all possible inputs
        for connection: AVCaptureConnection in stillImageOutput.connections as! [AVCaptureConnection] {
            for port: AVCaptureInputPort in connection.inputPorts as! [AVCaptureInputPort] {
                
                // Check for video port
                if port.mediaType == AVMediaTypeVideo {
                    videoConnection = connection
                    break
                }
            }
            if videoConnection != nil {
                break
            }
        }
        
        return videoConnection
    }
    
    private func stillImageOutput() -> AVCaptureStillImageOutput {
        let stillImageOutput = AVCaptureStillImageOutput()
        let outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        stillImageOutput.outputSettings = outputSettings
        return stillImageOutput
    }
    
    
    private func frontFacingCamera() -> AVCaptureDevice? {
        
        // Get all video devices
        let videoDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        // Loop through to find the fron facing camera
        var captureDevice: AVCaptureDevice?
        for device: AVCaptureDevice in videoDevices as! [AVCaptureDevice] {
            if device.position == AVCaptureDevicePosition.Front {
                // Front
                captureDevice = device
            }
        }
        
        return captureDevice
    }
    
    private func defaultCamera() -> AVCaptureDevice {
        return AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    }
    
    
    // MARK: -
    // MARK: - Permisions
    
    func requestCameraAuthorization(completion: RequestCameraAuthorizationBlock) {
        let authorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch authorizationStatus {
        case .NotDetermined:
            // permission dialog not yet presented, request authorization
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo,
                completionHandler: { (granted:Bool) -> Void in
                    if granted {
                        // go ahead
                        completion(authorized: true)
                    }
                    else {
                        // user denied, nothing much to do
                        self.userDeniedPermision()
                        completion(authorized: false)
                    }
            })
        case .Authorized:
            // go ahead
            completion(authorized: true)
        case .Denied, .Restricted:
            // the user explicitly denied camera usage or is not allowed to access the camera devices
            userDeniedPermision()
            completion(authorized: false)
        }
    }
    
    private func userDeniedPermision() {
        
    }
}
