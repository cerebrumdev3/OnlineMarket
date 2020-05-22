//
//  UIViewController.swift
//  BidJones
//
//  Created by Rakesh Kumar on 3/22/18.
//  Copyright © 2018 Seasia. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos
import MobileCoreServices
import NVActivityIndicatorView
import VegaScrollFlowLayout
import SwiftEntryKit



//MARK: - UIViewController Extnesion
extension UIViewController: NVActivityIndicatorViewable
{
    
    func showErrorToast(msg:String,img:String)
    {
        let attributes = getAttributes()
        
        let text = msg
        let style = EKProperty.LabelStyle(
            font: MainFont.light.with(size: 15),
            color: .white,
            alignment: .center,
            displayMode: attributes.displayMode
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        let imageContent = EKProperty.ImageContent(
            image: UIImage(named: img)!,
            displayMode: attributes.displayMode
        )
        let contentView = EKImageNoteMessageView(
            with: labelContent,
            imageContent: imageContent
        )
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
     
    func getAttributes() ->EKAttributes
    {
        var attributes = EKAttributes()
        attributes.name = "Top Note"
        attributes.windowLevel = .normal
        attributes.position = .bottom
        attributes.precedence = .override(priority: .max, dropEnqueuedEntries: false)
        attributes.precedence = .enqueue(priority: .normal)
        attributes.displayDuration = 3
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.rotation.isEnabled = false
        
        let offset = EKAttributes.PositionConstraints.KeyboardRelation.Offset(bottom: 10, screenEdgeResistance: 20)
        let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: offset)
        attributes.positionConstraints.keyboardRelation = keyboardRelation
        
        attributes.entryInteraction = .delayExit(by: 3)
        
        attributes.entryInteraction = .dismiss
        attributes.screenInteraction = .dismiss
        
        attributes.entryInteraction = .absorbTouches
        
        
        attributes.screenInteraction = .forward
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.displayMode = .dark
        
        attributes.entryBackground = .clear
        attributes.screenBackground = .clear
        
        attributes.screenBackground = .color(color: EKColor(UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.4)))
        
        attributes.roundCorners = .all(radius: 10)
   
        attributes.entryBackground = .visualEffect(style: .dark)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))
        
        return attributes
    }
    
    func makeCollectionViewFency(cllcnView:UICollectionView,cellGap:CGFloat)
    {
        let layout = VegaScrollFlowLayout()
        cllcnView.collectionViewLayout = layout
        layout.minimumLineSpacing = cellGap
        layout.itemSize = CGSize(width: cllcnView.frame.width, height: 190)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func getGradientColor()
    {
        
    }
    
    
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboard()
    {
        self.view.endEditing(true)
    }
    
    func convert_Array(arr:NSMutableArray) -> String
    {
        do
        {
            let data = try JSONSerialization.data(withJSONObject: arr)
            let dataString = String(data: data, encoding: .utf8)!
            print(dataString)
            return dataString
        }
        catch
        {
            print("JSON serialization failed: ", error)
            return ""
        }
    }
    
    func StartIndicator(message: String)
    {
        if(!AllUtilies.isAnimating)
        {
            AllUtilies.isAnimating = true
            let size = CGSize(width: 30, height: 30)
            startAnimating(size, message: message, type: .ballTrianglePath, fadeInAnimation: nil)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
            }
        }
        //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
        //                       NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
        //                   }
    }
    func StopIndicator()
    {
        AllUtilies.isAnimating = false
        DispatchQueue.main.async()
            {
                self.stopAnimating(nil)
        }
    }
    
    func roundCorners_TOPLEFT_TOPRIGHT(viewAny:AnyObject)
    {
        let path = UIBezierPath(roundedRect: viewAny.view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = viewAny.view.bounds
        maskLayer.path = path.cgPath
        viewAny.view.layer.mask = maskLayer
    }
    
    
    func makeViewRound(View:UIView,rad:CGFloat)
    {
        View.layer.cornerRadius = rad
        View.layer.masksToBounds = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK: - GallaryCamera Actionc
    
    func OpenGallaryCamera(pickerController : UIImagePickerController)
    {
        let alert = UIAlertController(title: KChooseImage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: KCamera, style: .default, handler: { _ in
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                //  Open Camera
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
                {
                    pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    pickerController.sourceType = UIImagePickerController.SourceType.camera
                    pickerController.allowsEditing = true
                    pickerController.mediaTypes = [kUTTypeImage as String]
                    
                    //  pickerController.mediaTypes = [kUTTypeMovie as String]
                    //   UIImagePickerController.availableMediaTypes(for:.camera)!;
                    self.present(pickerController, animated: true, completion: nil)
                }
                else {
                    self.showAlertMessage(titleStr: kAppName, messageStr: KYoudonthavecamera)
                }
                
            } else
            {
                // Open setting alert for camera
                let alert = UIAlertController(title: KOpenSettingForCamera , message: "", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: KCancel, style: .default))
                alert.addAction(UIAlertAction(title: KSettings, style: .cancel) { (alert) -> Void in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                })
                self.present(alert, animated: true)
                ////////
            }
        }))
        alert.addAction(UIAlertAction(title: KGallery, style: .default, handler: { _ in
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                // Open Gallary
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                    pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                    pickerController.mediaTypes = [kUTTypeImage as String]
                    pickerController.allowsEditing = true
                    self.present(pickerController, animated: true, completion: nil)
                    /////////
                }
            case .denied, .restricted:
                // Open setting Alert for galllary
                // Open setting alert for camera
                let alert = UIAlertController(title: KOpenSettingForPhotos , message: "", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: KCancel, style: .default))
                alert.addAction(UIAlertAction(title: KSettings, style: .cancel) { (alert) -> Void in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                })
                self.present(alert, animated: true)
            //////////
            case .notDetermined:
                break
            @unknown default:
                fatalError()
            }
        }))
        alert.addAction(UIAlertAction.init(title: KCancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func OpenGallaryCameraForVideo(pickerController : UIImagePickerController)
    {
        let alert = UIAlertController(title: KChooseImage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: KCamera, style: .default, handler: { _ in
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                //  Open Camera
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    pickerController.sourceType = UIImagePickerController.SourceType.camera
                    // pickerController.allowsEditing = true
                    pickerController.videoMaximumDuration = 30
                    pickerController.videoQuality = UIImagePickerController.QualityType.typeMedium
                    pickerController.allowsEditing = false
                    pickerController.mediaTypes = [kUTTypeMovie as String]
                    //   UIImagePickerController.availableMediaTypes(for:.camera)!;
                    self.present(pickerController, animated: true, completion: nil)
                }
                else {
                    self.showAlertMessage(titleStr: kAppName, messageStr: KYoudonthavecamera)
                }
                //////////
            } else
            {
                // Open setting alert for camera
                let alert = UIAlertController(title: KOpenSettingForCamera , message: "", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: KCancel, style: .default))
                alert.addAction(UIAlertAction(title: KSettings, style: .cancel) { (alert) -> Void in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                })
                self.present(alert, animated: true)
                ////////
            }
        }))
        alert.addAction(UIAlertAction(title: KGallery, style: .default, handler: { _ in
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                // Open Gallary
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                    pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                    pickerController.allowsEditing = true
                    pickerController.videoMaximumDuration = 30
                    pickerController.videoQuality = UIImagePickerController.QualityType.typeMedium
                    //pickerController.allowsEditing = true
                    pickerController.mediaTypes = [kUTTypeMovie as String]
                    //   UIImagePickerController.availableMediaTypes(for:.camera)!;
                    self.present(pickerController, animated: true, completion: nil)
                }
            case .denied, .restricted:
                // Open setting Alert for galllary
                // Open setting alert for camera
                let alert = UIAlertController(title: KOpenSettingForPhotos , message: "", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: KCancel, style: .default))
                alert.addAction(UIAlertAction(title: KSettings, style: .cancel) { (alert) -> Void in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                })
                self.present(alert, animated: true)
            //////////
            case .notDetermined:
                break
            @unknown default:
                fatalError()
            }
        }))
        alert.addAction(UIAlertAction.init(title: KCancel, style: .cancel, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func OpenVideoCamera(pickerController : UIImagePickerController)
    {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            //  Open Camera
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                pickerController.sourceType = UIImagePickerController.SourceType.camera
                pickerController.allowsEditing = true
                pickerController.videoMaximumDuration = 30
                pickerController.videoQuality = UIImagePickerController.QualityType.typeMedium
                pickerController.allowsEditing = false
                pickerController.mediaTypes = [kUTTypeMovie as String]
                //   UIImagePickerController.availableMediaTypes(for:.camera)!;
                self.present(pickerController, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage(titleStr: kAppName, messageStr: KYoudonthavecamera)
            }
            //////////
        } else
        {
            // Open setting alert for camera
            let alert = UIAlertController(title: KOpenSettingForCamera , message: "", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: KCancel, style: .default))
            alert.addAction(UIAlertAction(title: KSettings, style: .cancel) { (alert) -> Void in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            })
            self.present(alert, animated: true)
            ////////
        }
    }
    
    
    //MARK: - Alert and Toast
    
    func AlertMessageWithOkAction(titleStr:String, messageStr:String,Target : UIViewController, completionResponse:@escaping () -> Void) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: KOK, style: UIAlertAction.Style.default) {
            UIAlertAction in
            completionResponse()
        }
        // Add the actions
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func AlertMessageWithOkCancelAction(titleStr:String, messageStr:String,Target : UIViewController, completionResponse:@escaping (String) -> Void) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: KYes, style: UIAlertAction.Style.default) {
            UIAlertAction in
            completionResponse(KYes)
        }
        let CancelAction = UIAlertAction(title: KNo, style: UIAlertAction.Style.default) {
            UIAlertAction in
            completionResponse(KNo)
        }
        // Add the actions
        alert.addAction(okAction)
        alert.addAction(CancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertMessage(titleStr:String, messageStr:String)
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: KOK, style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        // Add the actions
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorMessage(titleStr:String, messageStr:String)
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: KOK, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.backLogout()
        }
        // Add the actions
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func backLogout()
    {
        // UserDefault.userPhone = ""
        // UserDefault.userId = 0
        // UserDefault.userName = ""
        // UserDefault.userType = ""
        // self.setRootView("LoginVC", storyBoard: "Auth")
    }
    
    
    func showToast(message : String)
    {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = Appcolor.getThemeColor()
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 8.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        configs.kAppdelegate.window?.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //MARK: - Screen width
    
    func ViewHeight() -> CGFloat
    {
        return UIScreen.main.bounds.size.height
    }
    //MARK: - Screen Height
    
    func ViewWidth() -> CGFloat
    {
        return UIScreen.main.bounds.size.width
    }
    
    
    //MARK: - Navigatin after Alert
    
    func AlertWithNavigation(message: String, completion: @escaping() -> (Void))
    {
        let alertController = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        // Create the actions
        let okAction = UIAlertAction(title: AlertTitles.Ok, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            completion()
        }
        self.dismiss(animated: true, completion: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    //MARK: - ThumbNail From Video Url
    
    func getThumbnailImage(forUrl url: URL) -> UIImage?
    {
        
        guard let videoTrack = AVAsset(url: url).tracks(withMediaType: AVMediaType.video).first else {
            return nil
        }
        let transformedVideoSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
        let videoIsPortrait = abs(transformedVideoSize.width) < abs(transformedVideoSize.height)
        print("Mode : \(videoIsPortrait)")
        let asset:AVAsset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do
        {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch
        {
            return nil
        }
    }
    
    
    func set_statusBar_color(view:UIView)
    {
        if #available(iOS 13.0, *)
        {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = UIColor(red: 255.0/255.0, green: 164.0/255.0, blue: 42.0/255.0, alpha: 1.0)
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
            
        }
        else
        {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(red: 255.0/255.0, green: 164.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        }
    }
    
}

//MARK:- UIViewController extensions
extension UIViewController
{
    
    func hideNAV_BAR (controller : UIViewController)
    {
        controller.navigationController?.isNavigationBarHidden = true
    }
    
    func showNAV_BAR (controller : UIViewController)
    {
        controller.navigationController?.isNavigationBarHidden = false
    }
    
    func moveBACK (controller : UIViewController)
    {
        controller.navigationController?.popViewController(animated: true);
    }
    
    func push_To_Controller(from_controller:UIViewController,to_Controller:UIViewController)
    {
        from_controller.navigationController?.pushViewController(to_Controller, animated: true)
    }
    
    func getAppDelegate() -> AppDelegate
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate
    }
    
    
    func hideBackButtonTitle()
    {
        self.navigationController?.navigationBar.topItem?.title = " "
    }
    
    func removeBackButton()
    {
        self.navigationItem.hidesBackButton = true
    }
    
    func setBackBarButtonCustom(addFrame:CGRect,contorller:UIViewController)
    {
        //Initialising "back button"
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControl.State.normal)
        btnLeftMenu.addTarget(contorller, action: #selector(onClickBack), for: UIControl.Event.touchUpInside)
        btnLeftMenu.frame = addFrame
        btnLeftMenu.imageEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0);
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        contorller.navigationItem.leftBarButtonItem = barButton
        
    }
    
    @objc func onClickBack()
    {
        if (self.navigationController?.viewControllers.count)! > 1
        {
            _ = self.navigationController?.popViewController(animated: true)
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func generateRandomString() -> String
    {
        let letters : NSString = "0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< 10
        {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func intToDate(intval:Int) -> String
    {
        let timeInterval = Double(intval)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm yyyy-MM-dd"
        let date = formatter.string(from: myNSDate)
        return date
    }
    
    func strToDate_Bookings (strDate : String) -> String
    {
        //2020-04-17T03:30:00.000Z
        let formatter = DateFormatter()
        let form2 = DateFormatter()
        form2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let daten = form2.date(from: strDate)
        formatter.dateFormat = "hh:mm yyyy-MM-dd"
        let fdate = formatter.string(from: daten ?? Date())
        return fdate
        
    }
    
    func getMinutesDifferenceFromTwoDates(start: Date, end: Date) -> Int
    {
        
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
        
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        return minutes
    }
    
    func hexStringToRGB(hexString: String) -> UIColor
    {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#"))
        {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6)
        {
            return Appcolor.getThemeColor()
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        
        let finalColor = UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0x0000FF)/255.0, alpha: 1.0)
        
        return finalColor
    }
    
    func get_transaction_failed_reason(dicnry:NSDictionary) -> String
    {
        let txt = "Payment Failed!"
        let field1  = dicnry.value(forKey: "field1")as? String
        let field2  = dicnry.value(forKey: "field2")as? String
        let field3  = dicnry.value(forKey: "field3")as? String
        let field4  = dicnry.value(forKey: "field4")as? String
        let field5  = dicnry.value(forKey: "field5")as? String
        let field6  = dicnry.value(forKey: "field6")as? String
        let field7  = dicnry.value(forKey: "field7")as? String
        let field8  = dicnry.value(forKey: "field8")as? String
        let field9  = dicnry.value(forKey: "field9")as? String
        
        if (field1?.count ?? 0 > 0)
        {
            return field1 ?? txt
        }
        if (field2?.count ?? 0 > 0)
        {
            return field2 ?? txt
        }
        if (field3?.count ?? 0 > 0)
        {
            return field3 ?? txt
        }
        if (field4?.count ?? 0 > 0)
        {
            return field4 ?? txt
        }
        if (field5?.count ?? 0 > 0)
        {
            return field5 ?? txt
        }
        if (field6?.count ?? 0 > 0)
        {
            return field6 ?? txt
        }
        if (field7?.count ?? 0 > 0)
        {
            return field7 ?? txt
        }
        if (field8?.count ?? 0 > 0)
        {
            return field8 ?? txt
        }
        if (field9?.count ?? 0 > 0)
        {
            return field9 ?? txt
        }
        
        return txt
        
        
    }
}
