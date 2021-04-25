//
//  AddViewController.swift
//  FoodTracker
//
//  Created by 張晨鈺 on 2021/4/25.
//

import UIKit
import VisionKit

class AddViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Scanner(_ sender: Any) {
        configureDocumentView()
    }
    
    private func configureDocumentView(){
        let scanningDocumentVC = VNDocumentCameraViewController()
        scanningDocumentVC.delegate=self
        self.present(scanningDocumentVC, animated: true, completion: nil)
    }
}

extension AddViewController: VNDocumentCameraViewControllerDelegate{
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan){
        for pageNumber in 0..<scan.pageCount{
            let image = scan.imageOfPage(at: pageNumber)
            print(image)
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
