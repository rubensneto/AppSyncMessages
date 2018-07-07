//
//  MessagesCollectionViewController.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 27/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class MessagesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextViewDelegate, NSFetchedResultsControllerDelegate {
    
    var senderId: Int!
    private let chatBubbleCellId = "chatBubbleCellId"
    
    
    var profile: Profile! {
        didSet{
            nameLabel.text = profile.name
            nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
            profileImageView.image =  UIImage(data: profile.profileImage!)
            setNavigationBar()
            do {
                try fetchedResultsController.performFetch()
            } catch let error {
                print(error)
            }
        }
    }
    
    let optionsButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "optionsButton")
        button.style = .plain
        button.tintColor = .white
        button.target = self as AnyObject
        button.action = #selector(optionsButtonAction)
        button.customView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
        
    }()
    
    let navigationContainerView: UIView = {
        let width = UIScreen.main.bounds.width - 120
        let frame = CGRect(x: 60, y: 0, width: width, height: 44)
        let view = UIView(frame: frame)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let inputContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .reconDarkBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    let inputTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .gray
        textView.text = "Type a message"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.alpha = 0.25
        button.isEnabled = false
        button.setImage(UIImage(named: "sendButtonIcon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        button.backgroundColor = .red
        button.layer.cornerRadius = 19
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var inputTextViewNumberOfLines = 2
    private var inputViewBottomConstraint: NSLayoutConstraint!
    private var inputContainerViewHeightConstraint: NSLayoutConstraint!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Message> = {
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "profile.id = %ld", self.profile.id)
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    //MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderId = UserDefaults.standard.value(forKey: "userId") as! Int
        navigationItem.rightBarButtonItem = optionsButton
        navigationController?.navigationBar.addSubview(navigationContainerView)
        navigationController?.navigationBar.bringSubview(toFront: navigationContainerView)
        setupCollectionViewLayout()
        setupInputComponents()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToBottom()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationContainerView.removeFromSuperview()
    }
    
    //MARK: User Actions
    
    @objc func optionsButtonAction(){
        
    }
    
    @objc func sendMessage(){
        if let text = inputTextView.text, !text.isEmpty {
            _ = MessagesDataManager.shared.createMessage(text: text, profile: profile, date: Date(), isSender: true)
            inputTextView.text = ""
            inputContainerViewHeightConstraint.constant = 56
            inputTextViewNumberOfLines = 2
        }
        toggleSendButton()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultsController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatBubbleCellId, for: indexPath) as! ChatBubbleCell
        let message = fetchedResultsController.object(at: indexPath)
        cell.message = message
        cell.bubbleWidthAnchor?.constant = estimateFrameFor(string: message.text!).width + 22
        if cell.bubbleWidthAnchor!.constant < 42 {
            cell.bubbleWidthAnchor!.constant = 42
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        let message = fetchedResultsController.object(at: indexPath)
        height = estimateFrameFor(string: message.text!).height
        let paddingConstraints: CGFloat = 6 + 1 + 12 + 4
        return CGSize(width: view.frame.width, height: height + paddingConstraints)
    }
    
    func estimateFrameFor(string: String) -> CGRect {
        let size = CGSize(width: view.bounds.width - 120, height: 1000)
        return NSString(string: string).boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.reconMessageText],
            context: nil)
    }
    
    func scrollToBottom(){
       if let count = fetchedResultsController.sections?[0].numberOfObjects, count > 0  {
            let indexPath = IndexPath(item: count - 1, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextView.endEditing(true)
    }
    
    //MARK: Styling
    
    func setNavigationBar(){
        navigationItem.titleView?.addSubview(navigationContainerView)
        navigationContainerView.addSubview(nameLabel)
        navigationContainerView.addSubview(profileImageView)
        
        navigationController?.navigationBar.addConstraintsWith(format: "H:|-43-[v0]-43-|", views: navigationContainerView)
        navigationController?.navigationBar.addConstraintsWith(format: "H:|[v0(44)]-2-|", views: navigationContainerView)
        navigationContainerView.addConstraintsWith(format: "H:|[v0]-(>=2)-[v1(36)]-0-|", views: nameLabel, profileImageView)
        navigationContainerView.addConstraintsWith(format: "V:[v0(36)]", views: profileImageView)
        
        profileImageView.centerYAnchor.constraint(equalTo: navigationContainerView.centerYAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: navigationContainerView.centerYAnchor).isActive = true
    }
    
    func setupCollectionViewLayout(){
        collectionView?.backgroundColor = .black
        collectionView?.register(ChatBubbleCell.self, forCellWithReuseIdentifier: chatBubbleCellId)
        collectionView?.alwaysBounceVertical = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView?.collectionViewLayout = layout
        collectionView?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 76, right: 0)
    }
    
    
    
    func setupInputComponents(){
        view.addSubview(inputContainerView)
        inputContainerView.addSubview(sendButton)
        inputContainerView.addSubview(inputTextView)
        inputTextView.delegate = self
        
        inputContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        inputContainerViewHeightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 56)
        inputContainerViewHeightConstraint.isActive = true
        inputViewBottomConstraint = inputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        inputViewBottomConstraint.isActive = true
        
        sendButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
        sendButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor, constant: -20).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor).isActive = true
        
        inputTextView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 20).isActive = true
        inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -20).isActive = true
        inputTextView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 10).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: -10).isActive = true
    }
    
    //MARK: TextView & Keyboard Delegate
    
    @objc func keyboardWillChange(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let isKeyboardShowing = notification.name == .UIKeyboardWillShow
            
            self.inputViewBottomConstraint.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                self.scrollToBottom()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if inputTextView.textColor == .gray {
            inputTextView.text = ""
            inputTextView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if inputTextView.text.isEmpty {
            inputTextView.text = "Type a message"
            inputTextView.textColor = .gray
            inputContainerViewHeightConstraint.constant = 56
            inputTextViewNumberOfLines = 2
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == inputTextView {
            if textView.numberOfLines() > inputTextViewNumberOfLines && textView.numberOfLines() < 4 {
                inputContainerViewHeightConstraint.constant += textView.font!.lineHeight
                inputTextViewNumberOfLines = textView.numberOfLines()
            }
        }
        toggleSendButton()
    }
    
    func toggleSendButton(){
        if let text = inputTextView.text, !text.isEmpty {
            sendButton.isEnabled = true
            sendButton.alpha = 1
        } else {
            sendButton.isEnabled = false
            sendButton.alpha = 0.25
        }
    }
    
    //MARK: Fetched Results Controller Delegate
    
    var blockOperations = [BlockOperation]()

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            blockOperations.append(BlockOperation(block: {
                self.collectionView?.insertItems(at: [newIndexPath!])
            }))
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            for operation in self.blockOperations {
                operation.start()
            }
        }, completion: { (completed) in
           self.scrollToBottom()
        })
    }
}































