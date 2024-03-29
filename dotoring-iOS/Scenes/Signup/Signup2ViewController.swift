//
//  MentoSignup2ViewController.swift
//  dotoring-iOS
//
//  Created by 우진 on 2023/09/21.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class Signup2ViewController: UIViewController {
    // Signup Data
    var school: String = ""
    var grade: Int = 0
    var fields: [String] = []
    var majors: [String] = []

    var signup2View: Signup2View!
    
    var selectedFileURL: URL?
//    var selectedFileURL2: URL?
    var isDoc = false
    
    let uiStyle: UIStyle = {
        if UserDefaults.standard.string(forKey: "UIStyle") == "mento" {
            return UIStyle.mento
        } else {
            return UIStyle.mentee
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
    }
    
    override func loadView() {
        super.loadView()
        
        signup2View = Signup2View(frame: self.view.frame)
        
        signup2View.certificateUploadButtonActionHandler = { [weak self] in
            self?.certificateOfEnrollmentUploadButtonTapped()
        }
        signup2View.nextButtonActionHandler = { [weak self] in
            self?.nextButtonTapped()
        }
        
        self.view = signup2View
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
    
    // sender : 0과 1
    func certificateOfEnrollmentUploadButtonTapped() {
        // 재학증명서 업로드
        openPdfOrImgFile(sender: 0)
    }
    
//    func graduateCertificateUploadButtonActionHandler() {
//        // 졸업증명서 업로드
//        openPdfOrImgFile(sender: 1)
//    }
    
    func checkInputValue() {
        if selectedFileURL == nil {
            Alert.showAlert(title: "안내", message: "서류를 선택해 주세요.")
            return
        }
    }
    
    func nextButtonTapped() {
        checkInputValue()
        let vc = Signup3ViewController()
        vc.school = school
        vc.grade = grade
        vc.fields = fields
        vc.majors = majors
        vc.certificationsFileURL = selectedFileURL
        vc.isDoc = isDoc
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = .BaseGray700
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let titleLabel = UILabel()
        var attrRangeText = ""
        var attrStrColor = UIColor.label

        titleLabel.textColor = UIColor.label // 전체 글씨 색상
        titleLabel.font = .nanumSquare(style: .NanumSquareOTFR, size: 15)
        titleLabel.sizeToFit()

        if uiStyle == .mentee {
            titleLabel.text = "멘티로 회원가입"
            attrRangeText = "멘티"
            attrStrColor = .BaseNavy!
        } else {
            titleLabel.text = "멘토로 회원가입"
            attrRangeText = "멘토"
            attrStrColor = .BaseGreen!
        }
        
        let attributedString = NSMutableAttributedString(string: titleLabel.text!)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: attrStrColor, range: (titleLabel.text! as NSString).range(of: attrRangeText))

        titleLabel.attributedText = attributedString

        self.navigationItem.titleView = titleLabel
    }
    
    func activeNextButton() {
        // 다음버튼 활성화
        signup2View.nextButton.isEnabled = true
        signup2View.nextButton.setTitleColor(.white, for: .normal)
        if uiStyle == .mento {
            signup2View.nextButton.backgroundColor = .BaseGreen
        } else {
            signup2View.nextButton.backgroundColor = .BaseNavy
        }
    }
    
}

extension Signup2ViewController:  UIDocumentPickerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func openPdfOrImgFile(sender: Int) {
        // Create an action sheet to let the user choose between picking a PDF or an image
        let actionSheet = UIAlertController(title: "파일 유형 선택", message: "파일 유형을 선택하세요", preferredStyle: .actionSheet)
        
        let pdfAction = UIAlertAction(title: "PDF", style: .default) { (action) in
            self.pickPDF(sender: sender)
        }
        
        let imageAction = UIAlertAction(title: "이미지", style: .default) { (action) in
            self.pickImage(sender: sender)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(pdfAction)
        actionSheet.addAction(imageAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func pickPDF(sender: Int) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        if sender == 0 {
            documentPicker.view.tag = signup2View.certificateUploadButton.tag
        }
        
        present(documentPicker, animated: true, completion: nil)
    }

    func pickImage(sender: Int) {
        self.view.makeToastActivity(.center)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        if sender == 0 { // 재학증명서 버튼일 경우
            imagePicker.view.tag = signup2View.certificateUploadButton.tag
        }
        present(imagePicker, animated: true, completion: nil)
        self.view.hideToastActivity()
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedPDFURL = urls.first {
            // Handle the selected PDF file here
            if controller.view.tag == signup2View.certificateUploadButton.tag {
                selectedFileURL = selectedPDFURL
                signup2View.certificateUploadButton.setTitle(selectedPDFURL.lastPathComponent, for: .normal)
                isDoc = true
                // 다음버튼 활성화
                activeNextButton()
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Handle the selected image here
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                if picker.view.tag == signup2View.certificateUploadButton.tag {
                    selectedFileURL = imageURL
                    signup2View.certificateUploadButton.setTitle(imageURL.lastPathComponent, for: .normal)
                    isDoc = false
                    // 다음버튼 활성화
                    activeNextButton()
                    
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
