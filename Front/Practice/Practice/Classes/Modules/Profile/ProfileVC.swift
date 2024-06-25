
import AutoLayoutSugar
import Kingfisher
import UIKit

class ProfileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.selectedItem?.title = L10n.Profile.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let profile = dataService?.appState.user {
            self.profile = profile
        } else {
            loadData()
        }
    }

    func setup() {
        photoProfile.centerX()
        nameLabel.centerX().top(to: .bottom(16), of: photoProfile)
        speciality.centerX().top(to: .bottom(0), of: nameLabel)
    }

    func setup(with profileService: ProfileService, dataService: DataService) {
        self.profileService = profileService
        self.dataService = dataService
    }

    private func loadData() {
        profileService?.getProfile { (result: Result<Profile, Error>) in
            switch result {
            case let .success(data):
                self.profile = data
            case let .failure(error):
                self.snacker?.show(snack: error.localizedDescription.description, with: .error)
            }
        }
    }

    private func display() {
        guard let nameP = profile?.name,
              let surname = profile?.surname,
              let type = profile?.readableType
        else {
            return
        }

        if let preview = profile?.avatarUrl, let previewUrl = URL(string: preview) {
            photoProfile.kf.setImage(
                with: previewUrl,
                placeholder: Asset.itemPlaceholder.image,
                options: [
                    .transition(.fade(0.2)),
                    .forceTransition,
                    .cacheOriginalImage,
                    .keepCurrentImageWhileLoading,
                ]
            )
        } else {
            photoProfile.image = Asset.itemPlaceholder.image
        }
        ProfileView.addSubview(nameLabel)
        ProfileView.addSubview(photoProfile)
        ProfileView.addSubview(speciality)
        photoProfile.layer.cornerRadius = 45
        photoProfile.clipsToBounds = true

        nameLabel.text = nameP + " " + surname
        speciality.text = type

        setup()
    }

    // MARK: Internal

    private var snacker: Snacker?

    private var profile: Profile? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.display()
            }
        }
    }

    private var profileService: ProfileService?
    private var dataService: DataService?

    private lazy var photoProfile: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.height(90).width(90)

        return image
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(Asset.settings.image, for: .normal)
        button.layer.cornerRadius = 50
        return button
    }()

    private lazy var nameLabel: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 24, weight: .medium)
        txt.textColor = .white
        return txt
    }()

    private lazy var speciality: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 14, weight: .medium)
        txt.textColor = .white
        return txt
    }()

    @IBOutlet var ProfileView: ProfileView!

    @IBAction func logoutPressedButton(_: Any) {
        let alert = UIAlertController(title: L10n.Action.exit, message: L10n.Question.exit, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.Action.exitAction, style: .default) { (_: UIAlertAction) -> Void in

            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
            self.dataService?.appState.accessToken = nil
        })
        alert.addAction(UIAlertAction(title: L10n.Action.cancel, style: .cancel) { (_: UIAlertAction) -> Void in
        })
        present(alert, animated: true, completion: nil)
    }
}
