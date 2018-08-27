//
//  AboutViewController.swift
//  Panemar
//
//  Created by Bogdan Pintilei on 4/14/17.
//  Copyright © 2017 Bogdan Pintilei. All rights reserved.
//

import UIKit
import ImageSlideshow
import UIColor_Hex_Swift
import MapKit
import CoreLocation

class AboutViewController: UIViewController {

    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var Map: MKMapView!
    
    private func annotationForLocation() {
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let location = CLLocationCoordinate2DMake(46.770367, 23.596250 )
        let region = MKCoordinateRegionMake(location,span)
        Map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()

        annotation.coordinate = location
        annotation.title = "Panemar"
        annotation.subtitle = "- Eroilor -"
        Map.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callButton.layer.cornerRadius = 17
        slideShowSettings()
        annotationForLocation()
    }

    let alamofireSource = [ AlamofireSource(urlString: "https://www.panemar.ro/images-html/magazine/Panemar-Polus.jpg")!,
                            AlamofireSource(urlString: "https://www.panemar.ro/images-html/magazine/Panemar-Memo.jpg")!,
                            AlamofireSource(urlString: "https://www.panemar.ro/images-html/magazine/Panemar-croitorilor.jpg")!,
                            AlamofireSource(urlString: "https://www.panemar.ro/images-html/magazine/Panemar-Gara.jpg")!,
                            AlamofireSource(urlString: "https://www.panemar.ro/images-html/magazine/Panemar-Oasului.jpg")! ]
    
    
    private func slideShowSettings() {
        let bcolour  = UIColor("#472918").cgColor
        let ycolour = UIColor("#FFB800").cgColor
        imageSlideShow.backgroundColor = UIColor.clear
        imageSlideShow.slideshowInterval = 5.0
        imageSlideShow.pageControlPosition = PageControlPosition.custom(padding: CGFloat(-4))
        imageSlideShow.pageControl.currentPageIndicatorTintColor = UIColor(cgColor: ycolour)
        imageSlideShow.pageControl.pageIndicatorTintColor = UIColor(cgColor: bcolour)
        imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        imageSlideShow.setImageInputs(alamofireSource)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlideShow.addGestureRecognizer(recognizer)
    }
    
    func didTap() {
        _ = imageSlideShow.presentFullScreenController(from: self)
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
        let url: NSURL = NSURL(string: "tel://0742213412")!
        UIApplication.shared.open(url as URL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
