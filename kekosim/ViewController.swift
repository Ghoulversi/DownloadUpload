//
//  ViewController.swift
//  kekosim
//
//  Created by Minami on 21.10.17.
//  Copyright © 2017 Minami. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var downloadImage: UIImageView!
    
    let filename = "tmage.jpeg"
    

    var imageReference: StorageReference {
         return Storage.storage().reference().child("images")    }
    
    @IBAction func onUploadTapped()
    {
        guard let image = uploadImage.image else {return}
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
        
        let uploadImageRef = imageReference.child(filename)
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR upload complete")
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
        uploadTask.resume()
    }
    @IBAction func onDownloadTapped()
    {
        let downloadImageRef = imageReference.child(filename)
        
        let downloadtask = downloadImageRef.getData(maxSize: 1024 * 1024 * 120) { (data, error) in
            if let data = data {
                 let image = UIImage(data: data)
                self.downloadImage.image = image
            }
            print(error ?? "NO ERROR download complete")
        }
        
        downloadtask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
      //  downloadtask.resume()
    }

}

