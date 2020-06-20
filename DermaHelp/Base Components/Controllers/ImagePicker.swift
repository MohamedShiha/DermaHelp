//
//  ImagePicker.swift
//
//  Created by Mohamed Shiha on 6/5/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit
import class Photos.PHPhotoLibrary
import class AVFoundation.AVCaptureDevice

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

class ImagePicker: NSObject {
    
    // MARK: Properties
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    // MARK: Initializer
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    // MARK: Displaying picker options using UIAlertController
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func presentOptions(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = .black
        if let action = self.action(for: .camera, title: .localized(key: "take photo")) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: .localized(key: "camera roll")) {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: .localized(key: "cancel"), style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    // MARK: Present specific picker type directly
    
    public func presentCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let msg = String.localized(key: "no camera error")
            let alertController = AlertController.dismissingAlert(title: msg, message: nil, dismissingTitle: .localized(key: "cancel"))
            presentationController?.present(alertController, animated: true, completion: nil)
            return
        }
        pickerController.sourceType = .camera
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            self.presentationController?.present(pickerController, animated: true, completion: nil)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { (isGranted) in
                guard isGranted else {
                    DispatchQueue.main.async { self.alertForAuthorization() }
                    return
                }
                DispatchQueue.main.async {
                    self.presentationController?.present(self.pickerController, animated: true, completion: nil)
                }
            }
        }
    }
    
    public func presentCameraRoll() {
        presentLibrary(ofType: .savedPhotosAlbum)
    }
    
    public func presentPhotoLibrary() {
        presentLibrary(ofType: .photoLibrary)
    }
    
    private func presentLibrary(ofType type: UIImagePickerController.SourceType) {
        guard type == .photoLibrary || type == .savedPhotosAlbum else { return }
        if UIImagePickerController.isSourceTypeAvailable(type) {
            pickerController.sourceType = type
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
                self.presentationController?.present(pickerController, animated: true, completion: nil)
            case .notDetermined:
                requestPhotoAccess(type)
            case .denied:
                alertForAuthorization()
            case .restricted:
                alertForAuthorization()
            @unknown default:
                break
            }
        }
    }
    
    // MARK: Requesting authorization
    
    private func requestPhotoAccess(_ pickerType: UIImagePickerController.SourceType) {
        PHPhotoLibrary.requestAuthorization { (newStatus) in
            if newStatus == .authorized {
                DispatchQueue.main.async {
                    self.pickerController.sourceType = pickerType
                    self.presentationController?.present(self.pickerController, animated: true, completion: nil)
                }
            } else {
                print("User has denied the access request.")
            }
        }
    }
    
    // MARK: Authorization AlertController
    
    private func alertForAuthorization() {
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "The app"
        let source = pickerController.sourceType == .camera ? String.localized(key: "camera") : .localized(key: "library source")
        let message = String.localizedStringWithFormat(.localized(key: "camera and photo access error"), appName, source)
//        let message = "\(appName) does not have access to your \(source), tap Settings and turn on Photos."
        let alertController = AlertController.dismissingAlert(title: message, message: "", dismissingTitle: .localized(key: "cancel"))
        // Settings Action
        alertController.createAlert(title: .localized(key: "settings"), action: .secondary, alertStyle: .default) {
            self.openSettings()
        }
        self.presentationController?.present(alertController, animated: true, completion: nil)
    }
    
    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:]) { (success) in
                print("Settings opened: \(success)")
            }
        }
    }
}

// MARK: UIImagePickerController Delegate

extension ImagePicker: UIImagePickerControllerDelegate {
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return pickerController(picker, didSelect: nil)
        }
        pickerController(picker, didSelect: image)
    }
}

// MARK: UINavigationController Delegate

extension ImagePicker: UINavigationControllerDelegate { }
