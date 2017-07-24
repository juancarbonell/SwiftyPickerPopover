//
//  StringPickerPopoverViewController.swift
//  SwiftyPickerPopover
//
//  Created by Yuta Hoshino on 2016/09/14.
//  Copyright © 2016 Yuta Hoshino. All rights reserved.
//

public class StringPickerPopoverViewController: AbstractPickerPopoverViewController {

    // MARK: Types
    
    /// Popover type. It is also used as the storyboard name.
    typealias PopoverType = StringPickerPopover
    
    // MARK: Properties

    /// Popover
    var popover: PopoverType? { return anyPopover as? PopoverType }
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var picker: UIPickerView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = popover
    }

    /// Make the popover properties reflect on this view controller
    override func refrectPopoverProperties(){
        super.refrectPopoverProperties()
        
        // Set up cancel button
        navigationItem.leftBarButtonItem = nil
        cancelButton.title = popover?.cancelButton_.title
        cancelButton.tintColor = popover?.cancelButton_.color ?? popover?.tintColor
        navigationItem.leftBarButtonItem = cancelButton
        
        // Set up done button
        navigationItem.rightBarButtonItem = nil
        doneButton.title = popover?.doneButton_.title
        doneButton.tintColor = popover?.doneButton_.color ?? popover?.tintColor
        navigationItem.rightBarButtonItem = doneButton
        
        // Select row if needed
        if let select = popover?.selectedRow_ {
            picker?.selectRow(select, inComponent: 0, animated: true)
        }
    }
    
    /// Action when tapping done button
    ///
    /// - Parameter sender: Done button
    @IBAction func tappedDone(_ sender: AnyObject? = nil) {
        let selectedRow = picker.selectedRow(inComponent: 0)
        if let selectedString = popover?.choices[selectedRow]{
            popover?.doneButton_.action?(popover!, selectedRow, selectedString)
        }
        dismiss(animated: false, completion: {})
    }
    
    /// Action when tapping cancel button
    ///
    /// - Parameter sender: Cancel button
    @IBAction func tappedCancel(_ sender: AnyObject? = nil) {
        let selectedRow = picker.selectedRow(inComponent: 0)
        if let selectedString = popover?.choices[selectedRow]{
            popover?.cancelButton_.action?(popover!, selectedRow, selectedString)
        }
        dismiss(animated: false, completion: {})
    }
    
    /// Action to be executed after the popover disappears
    ///
    /// - Parameter popoverPresentationController: UIPopoverPresentationController
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        tappedCancel()
    }


}
