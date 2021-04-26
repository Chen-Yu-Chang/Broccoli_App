//
//  CalendarViewController.swift
//  FoodTracker
//
//  Created by 張晨鈺 on 2021/4/25.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate=self
        // Do any additional setup after loading the view.
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        print("\(string)")
    }

}
