//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate {
	
	@IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		mapView.delegate = self
		
		let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
			MKCoordinateSpanMake(0.1, 0.1))
		mapView.setRegion(sfRegion, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		
		if segue.identifier == "tagSegue" {
			let destination = segue.destinationViewController as! LocationsViewController
			destination.delegate = self
		}
    }

	
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
	
	func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
//		navigationController!.popToViewController(self, animated: true)
		
		let annotation = MKPointAnnotation()
		annotation.coordinate = CLLocationCoordinate2D(
			latitude: CLLocationDegrees(latitude),
			longitude: CLLocationDegrees(longitude))
		annotation.title = String(format:"lat: %.2f, long: %.2f", CGFloat(latitude), CGFloat(longitude))
		mapView.addAnnotation(annotation)
	}
	
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		let reuseID = "myAnnotationView"
		
		var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
		if (annotationView == nil) {
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
			annotationView!.canShowCallout = true
			annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
		}
		
		let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
		imageView.image = UIImage(named: "camera")
		
		return annotationView
	}
}
