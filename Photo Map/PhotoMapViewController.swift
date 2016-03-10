//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	@IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
			MKCoordinateSpanMake(0.1, 0.1))
		mapView.setRegion(sfRegion, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func didPressCamara(sender: AnyObject) {
		let vc = UIImagePickerController()
		vc.delegate = self
		vc.allowsEditing = true
		
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
			vc.sourceType = UIImagePickerControllerSourceType.Camera
		} else {
			vc.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
		}
		
		self.presentViewController(vc, animated: true, completion: nil)
	}

	func imagePickerController(picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [String : AnyObject]) {
			// Get the image captured by the UIImagePickerController
			let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
			let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
			
			// Do something with the images (based on your use case)
			
			// Dismiss UIImagePickerController to go back to your original view controller
			dismissViewControllerAnimated(true) { () -> Void in
				self.performSegueWithIdentifier("tagSegue", sender: self)
			}
	}
}
