//
//  EditProfileVC.swift
//  APEX Mentality
//
//  Created by CTS on 25/09/23.
//

import UIKit
import SwiftyJSON
import Alamofire
import MBProgressHUD

class EditProfileVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var fullNameView: UIView!
    
    @IBOutlet weak var phoneNoView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var ProfileImg: UIImageView!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var phoneNoTxt: UITextField!
    
    @IBOutlet weak var mailIdTxt: UITextField!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileMailId: UILabel!
    
    var userProfileData: ProfileData?
    var recordVideoUsingCameraUrlPath = ""
    var pickedImageUrl:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fullNameView.layer.cornerRadius = 20
        phoneNoView.layer.cornerRadius = 20
        emailView.layer.cornerRadius = 20
        
        
        ProfileImg.clipsToBounds = true
        ProfileImg.cornerRadius = 60
        ProfileImg.layer.borderColor = UIColor(red: 229/255, green: 193/255, blue: 3/255, alpha: 1).cgColor
        ProfileImg.layer.borderWidth = 5
        

//
//        let profileImg = UserDefaults.standard.getProfileImg()
        let profileName =  UserDefaults.standard.getUserName()
        let profilemailId = UserDefaults.standard.getEmail()
        let phoneNo =  UserDefaults.standard.getPhoneNo()
        self.phoneNoTxt.text = phoneNo
        self.profileName.text = profileName
        self.profileMailId.text  = profilemailId
        //self.ProfileImg.image = UIImage(named: profileImg ?? "")
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        ProfileImg.layer.borderWidth = 1
        ProfileImg.layer.masksToBounds = false
        ProfileImg.layer.borderColor = UIColor.clear.cgColor
        ProfileImg.layer.cornerRadius = 60.0
//        ProfileImg.frame.height/2
        ProfileImg.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userName = UserDefaults.standard.getUserName()
        self.nameTxt.text = userName
        self.profileName.text = userName
        
        let emailId = UserDefaults.standard.getEmail()
        self.mailIdTxt.text = emailId
        
        let phoneNo =  UserDefaults.standard.getPhoneNo()
        self.phoneNoTxt.text = phoneNo
        
        let profileImg = UserDefaults.standard.getProfile()
        if profileImg != nil {
            
            if profileImg == "" {
                self.ProfileImg.image = UIImage(named: "empty_image")
            }else{
                self.ProfileImg.kf.setImage(with: URL(string: profileImg!))
            }
        }
        
        self.tabBarController?.tabBar.isHidden = true
    }    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        guard let userID = UserDefaults.standard.getUserID() else { return }
        let name = nameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let phoneNumber = phoneNoTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = mailIdTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let request = EditProfileRequest(userID: userID, name: name,  phone: phoneNumber, location: "Delhi" )
        
        let profileDetailsValidation = ProfileDetailsValidation()
        let validationResult = profileDetailsValidation.validate(request: request)
        
        if validationResult.success == true{
            updateProfileRequest()
        }else{
            DispatchQueue.main.async {
                self.makeToast(validationResult.error!.localizedDescription)
            }
        }
        
    }
    
    func updateProfileRequest(){
        DispatchQueue.main.async {
            self.showLoader()
        }
        
        guard let userID = UserDefaults.standard.getUserID() else { return }
        let name = nameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = mailIdTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumber = phoneNoTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        let url = URL(string: APIs.EDIT_PROFILE)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (ProfileImg.image == nil)
        {
            return
        }
        
        let image_data = ProfileImg.image?.jpegData(compressionQuality: 0.3)
        
        if(image_data == nil)
        {
            return
        }
        
        let body = NSMutableData()
        let fname = "test.png"
        let mimetype = "image/png"
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"user_id\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(userID)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"name\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(name!)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"email\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(email!)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"phone\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(phoneNumber!)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"location\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"image\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        HttpUtility.shared.getApiData(urlRequest: request, resultType: ProfileResponse.self) { (userProfileResponse) in
            if userProfileResponse.success == "true"{
                
                DispatchQueue.main.async {
                    self.showLoader()
                    UserDefaults.standard.removeObject(forKey: "name")
                    let userName =  UserDefaults.standard.getUserName()
                    print(userName)
                    
                    UserDefaults.standard.savePhoneNo(phoneNo: (userProfileResponse.data?.phone ?? ""))
                    UserDefaults.standard.saveUserName(userName: (userProfileResponse.data?.name ?? ""))
                    
                    hideLoading()
                    self.makeToast(userProfileResponse.message!)
                    NotificationCenter.default.post(name: NSNotification.Name("reloadProfile"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(userProfileResponse.message!)
                }
            }
        }
        
    }
    
    func showLoader() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    // Hide the loader
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

    
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
    
    
    func ShowAlert(message: String, title: String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:"OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func uploadVideoServerData(){
        //        showLoader()
        showLoading()
        let urlString =  String(describing: pickedImageUrl)
        if urlString == "" {
            //            let alert = UIAlertController(title: "", message: "Please upload a Image", preferredStyle: UIAlertController.Style.alert)
            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            //            self.present(alert, animated: true, completion: nil)
            //            return
        }else{
            let videoURL = URL(string: urlString)!
            print(videoURL)
            
            print(videoURL)
            //            self.showLoader()
            let userId  = UserDefaults.standard.getUserID()
            let params: [String:Any]
            
            = [  "user_id":userId,
                 "name":nameTxt.text,
                 "phone":mailIdTxt.text,
                 "location":"Delhi",
                 //    "video" : videoURL
            ]
            //           self.showLoader()
            self.sendMultipartRequestToServer(urlString: APIs.EDIT_PROFILE, fileName: "video", sendJson: params, imageUrl: videoURL, successBlock: { (json) in
                print(json)
                //          hideAllProgressOnView(appDelegateInstance.window!)
                let success = json["status"].stringValue
                if success  == "1"
                {
                    
                    print(success)
                }
                else
                {
                }
            }, errorBlock: { (NSError) in
            })
            //            hideLoader()
        }
    }
    
    
    
    
    func sendMultipartRequestToServer(urlString:String,fileName:String,  sendJson:[String:Any], imageUrl:URL?, successBlock:@escaping ( _ response: JSON)->Void , errorBlock: @escaping (_ error: NSError) -> Void )
    {
        let headerField : HTTPHeaders = [:]
        AF.upload(multipartFormData: { multipartFormData in
            for (key,value) in sendJson {
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
                else
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            if let url = imageUrl
            {
                multipartFormData.append(url, withName: fileName)
            }
        },to: urlString, method: .post, headers : headerField)
        .responseJSON {  response in
            if response.response?.statusCode == 403 {
            }
            switch response.result {
            case .success(let value):
                //            self.hideLoader()
                if let jsonDictionary = value as? NSDictionary {
                    print(jsonDictionary["message"])
                    //                    self.makeToast("Your video has been uploaded successfully. It will be available in Video section shortly")
                    //
                    //
                    
                    //                self.makeToast(jsonDictionary["message"]! as! String)
                    print(response)
                    
                    DispatchQueue.main.async {
                        //            self.showAlert(message: jsonDictionary["message"] as! String)
                        self.makeToast(jsonDictionary["message"] as! String)
                        //                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
                        //                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    
                }
                successBlock(JSON(value ))
                let data = response.result
                print(data)
                
                //            self.makeToast("Your video has been uploaded successfully. It will be available in Video section shortly")
                
                //            self.makeToast(response.message ?? "")
                /*
                 print(response)
                 self.hideLoader()
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
                 self.navigationController?.pushViewController(vc, animated: true)
                 */
            case .failure( let error):
                errorBlock(error as NSError)
                //                self.hideLoader()
                print("ERROR RESPONSE: \(error.localizedDescription)")
            }
        }
    }
    
    
    func sendRequestForChangePassword(request: EditProfileRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let profileResource = ProfileResource()
        profileResource.editProfile(request: request) { (response) in
            if response.success == "true"{
                //                UserDefaults.standard.removeObject(forKey: "phone" )
                //             let phoneno = UserDefaults.standard.getPhoneNo()
                //                print(phoneno)
                UserDefaults.standard.removeObject(forKey: "name")
                let userName =  UserDefaults.standard.getUserName()
                print(userName)
                UserDefaults.standard.savePhoneNo(phoneNo: (response.data?.phone ?? ""))
                UserDefaults.standard.saveUserName(userName: (response.data?.name ?? ""))
                DispatchQueue.main.async {
                    hideLoading()
                    self.phoneNoTxt.text = ""
                    self.makeToast(response.message ?? "")
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(response.message ?? "")
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func onClickProfilePic(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        let alert = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.openCamera(imagePicker)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
            self.openGallery(imagePicker)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
//    func uploadProfileImageServerData(_ image:String){
        //        showLoader()
    func uploadProfileImageServerData(){
//           showLoading()
      
        let urlString = String(describing: pickedImageUrl)
        if urlString == "" {
        return
        }else{
            showLoader()
            let videoURL = URL(string: urlString)!
            print(videoURL)
            
            print(videoURL)
            //            self.showLoader()
            let userId  = UserDefaults.standard.getUserID()
            let params: [String:Any] = ["user_id":userId!,
                                        "image" : pickedImageUrl as Any]
                 self.showLoader()
            self.sendMultipartRequestToServer(urlString: APIs.PROFILE_IMAGE, fileName: "image", sendJson: params, imageUrl: pickedImageUrl, successBlock: { (json) in
                print(json)
                let success = json["success"].stringValue
                if success  == "true"
            {
              
                    let profileUrlStr = json["data"].stringValue
                    UserDefaults.standard.saveProfilePic(profile:(profileUrlStr))
                    if profileUrlStr != nil
                    {
                        self.ProfileImg.kf.setImage(with: URL(string: profileUrlStr))
                    }
                    let message = json["message"].stringValue
                    self.makeToast("\(message)")
                    self.hideLoader()
                }
                else
                {
                    self.hideLoader()
                    hideLoading()
                }
            }, errorBlock: { (NSError) in
            })
            hideLoader()
            
//            hideLoading()
        }
    }
    
    
//    func uploadProfileImageServerData(_ image:String){
//        //        showLoader()
//        let urlString = String(describing: pickedImageUrl)
//        if urlString == "" {
//            //            let alert = UIAlertController(title: "", message: "Please upload a Video", preferredStyle: UIAlertController.Style.alert)
//            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            //            self.present(alert, animated: true, completion: nil)
//            return
//        }else{
//            let videoURL = URL(string: urlString)!
//            print(videoURL)
//
//            print(videoURL)
//            //            self.showLoader()
//            let userId  = UserDefaults.standard.getUserID()
//            let params: [String:Any] = ["user_id":userId!,
//                                        "image" : pickedImageUrl as Any]
//            //         self.showLoader()
//            self.sendMultipartRequestToServer(urlString: APIs.PROFILE_IMAGE, fileName: "image", sendJson: params, imageUrl: pickedImageUrl, successBlock: { (json) in
//                print(json)
//
//                //UserDefaults.standard.saveProfileImg(ProfileImage: "ProfileImage")
//                //          hideAllProgressOnView(appDelegateInstance.window!)
//                let success = json["status"].stringValue
//                print(json["data"].stringValue)
//                let userImage = json["data"].stringValue
//               // UserDefaults.standard.set(userImage, forKey: "USER_Profile")
//                //     let userDefaultImg =          UserDefaults.standard.saveProfileImg(ProfileImage:userImage)
//                if success  == "true"
//                {
//                    print(success)
//                    let userImage = json["data"].stringValue
//
//
////                    UserDefaults.standard.set(userImage, forKey: "USER_Profile")
//                    self.makeToast("Profile image updated successfully.")
//
//                }
//                else
//                {
//                }
//            }, errorBlock: { (NSError) in
//            })
//            //            hideLoader()
//        }
//    }
    
    
    func openCamera(_ imagePicker: UIImagePickerController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera is not available.")
        }
    }
    
    func openGallery(_ imagePicker: UIImagePickerController) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            self.ProfileImg.image = pickedImage
            saveImageDocumentDirectory(usedImage: pickedImage)
            
        }
        if let imgUrl = getImageUrl()
        {
            pickedImageUrl = imgUrl
        }
                
        //        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        //               let urlstring = selectedImage
        //               let anyvar =  String(describing: urlstring)
        //               ProfileImg.image = selectedImage
        //               self.uploadProfileImageServerData()
        //           }
        picker.dismiss(animated: true, completion: nil)
        self.uploadProfileImageServerData()

        //let selectImgStr = String(pickedImageUrl)
        
//        self.uploadProfileImageServerData(pickedImageUrl?.lastPathComponent ?? "" )
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func saveImageDocumentDirectory(usedImage:UIImage)
    {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("temp.jpeg")
        let imageData = usedImage.jpegData(compressionQuality: 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    
    public func getImageUrl() -> URL? {
        let url = URL(fileURLWithPath: (getDirectoryPath() as NSString).appendingPathComponent("temp.jpeg"))
        return url
    }
    
    public func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}



