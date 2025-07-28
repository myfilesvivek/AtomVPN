# 🔒 AtomVPN - Secure VPN Client

<div align="center">

<img width="120" alt="AtomVPN Logo" src="assets/images/atm.png" />


**A modern, secure, and user-friendly VPN client built with Flutter and OpenVPN**

[![Flutter](https://img.shields.io/badge/Flutter-3.4.3+-blue.svg)](https://flutter.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android-green.svg)](https://developer.android.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.2-brightgreen.svg)](pubspec.yaml)

*Secure your online presence with military-grade encryption*

</div>

---

## 📋 Table of Contents

- [✨ Features](#-features)
- [🚀 Screenshots](#-screenshots)
- [🛠️ Technology Stack](#️-technology-stack)
- [📱 Requirements](#-requirements)
- [⚙️ Installation](#️-installation)
- [🔧 Configuration](#-configuration)
- [📖 Usage](#-usage)
- [🏗️ Project Structure](#️-project-structure)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## ✨ Features

### 🔐 Security & Privacy
- **Military-grade encryption** using OpenVPN protocol
- **Kill switch** functionality to prevent data leaks
- **No-logs policy** for complete privacy
- **DNS leak protection** to secure your browsing

### 🌍 Global Server Network
- **Multiple server locations** across different countries
- **Automatic server selection** for optimal performance
- **Country-specific servers** with flag indicators
- **Real-time server status** monitoring

### 📊 Network Monitoring
- **Real-time connection statistics** (upload/download speeds)
- **Network quality indicators** with color-coded status
- **Connection duration tracking**
- **Data usage monitoring**

### 🎨 Modern UI/UX
- **Sleek and intuitive interface** with Material Design
- **Dark/Light theme support**
- **Smooth animations** and transitions
- **Responsive design** for all screen sizes
- **Interactive world map** visualization

### ⚡ Performance
- **Fast connection speeds** with optimized servers
- **Low latency connections**
- **Automatic reconnection** on network changes
- **Background service** support

---

## 🚀 Screenshots

<div align="center">
<img width="250" alt="2" src="https://github.com/user-attachments/assets/71318dcf-3a47-4735-b042-ae87f00c12bb" />
<img width="250" alt="2" src="https://github.com/user-attachments/assets/bc78b703-78b9-4b9b-83c3-df8f20457011" />
<img width="250"  alt="2" src="https://github.com/user-attachments/assets/9c5bb124-0d55-4343-bedb-5ce07b1637e3" />
<img width="250"  alt="2" src="https://github.com/user-attachments/assets/420bdc9c-fdea-471f-9188-7f55c2945fc5" />
<img width="250"  alt="2" src="https://github.com/user-attachments/assets/95dd575d-e98e-479e-abeb-bf549dc98d1e" />
<img width="250"  alt="2" src="https://github.com/user-attachments/assets/232d5246-3beb-4706-8dfe-9422b2cef670" />







</div>

---

## 🛠️ Technology Stack

### Frontend
- **Flutter 3.4.3+** - Cross-platform UI framework
- **GetX** - State management and navigation
- **Material Design** - UI/UX guidelines
- **Lottie** - Smooth animations
- **Flutter SVG** - Vector graphics support

### Backend & Services
- **OpenVPN** - VPN protocol implementation
- **Firebase Messaging** - Push notifications
- **HTTP** - API communication
- **Hive** - Local data storage
- **Permission Handler** - Device permissions

### Native Integration
- **Android Native Code** - VPN service implementation
- **Method Channels** - Flutter-Native communication
- **Event Channels** - Real-time status updates

---

## 📱 Requirements

### Development Environment
- **Flutter SDK** 3.4.3 or higher
- **Dart SDK** 3.4.3 or higher
- **Android Studio** / VS Code
- **Android SDK** API level 21+

### Device Requirements
- **Android** 5.0 (API level 21) or higher
- **RAM** 2GB minimum (4GB recommended)
- **Storage** 50MB free space
- **Internet connection** for VPN functionality

---

## ⚙️ Installation

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/atomvpn.git
cd atomvpn
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure VPN Servers
Add your VPN server configurations to `assets/vpn/` directory:
```
assets/vpn/
├── japan.ovpn
├── thailand.ovpn
└── [other_server_configs].ovpn
```

### 4. Update Package Name (Optional)
```bash
flutter pub run change_app_package_name:main com.yourcompany.atomvpn
```

### 5. Build the Application
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

---

## 🔧 Configuration

### VPN Server Configuration
1. Place your `.ovpn` files in `assets/vpn/` directory
2. Update server details in `lib/models/vpn_config.dart`
3. Configure authentication credentials if required

### Firebase Setup (Optional)
1. Create a Firebase project
2. Add `google-services.json` to `android/app/`
3. Configure Firebase Messaging for notifications

### Permissions
The app requires the following permissions:
- **INTERNET** - For VPN connections
- **ACCESS_NETWORK_STATE** - Network status monitoring
- **FOREGROUND_SERVICE** - Background VPN service
- **RECEIVE_BOOT_COMPLETED** - Auto-start capability

---

## 📖 Usage

### Getting Started
1. **Launch the app** and grant necessary permissions
2. **Select a server** from the available locations
3. **Tap the connect button** to establish VPN connection
4. **Monitor connection status** through the main interface

### Features Usage
- **Server Selection**: Tap the server list to choose your preferred location
- **Network Test**: Use the network test feature to check connection quality
- **Kill Switch**: Enable kill switch to prevent data leaks when VPN disconnects
- **Statistics**: View real-time upload/download speeds and connection duration

### Troubleshooting
- **Connection Issues**: Check your internet connection and server availability
- **Permission Errors**: Ensure all required permissions are granted
- **Performance Issues**: Try switching to a different server location

---

## 🏗️ Project Structure

```
atomvpn/
├── android/                 # Android-specific code
│   ├── app/                # Main Android app
│   └── vpnLib/             # OpenVPN library integration
├── assets/                 # App assets
│   ├── flags/              # Country flag images
│   ├── fonts/              # Custom fonts
│   ├── images/             # App images and icons
│   ├── lottie/             # Animation files
│   ├── svg/                # Vector graphics
│   └── vpn/                # VPN configuration files
├── lib/                    # Flutter source code
│   ├── apis/               # API services
│   ├── controllers/        # GetX controllers
│   ├── helpers/            # Utility helpers
│   ├── models/             # Data models
│   ├── screens/            # UI screens
│   ├── services/           # Business logic services
│   ├── theme/              # App theming
│   ├── utils/              # Utility functions
│   └── widgets/            # Reusable UI components
├── pubspec.yaml            # Flutter dependencies
└── README.md              # Project documentation
```

---

## 🤝 Contributing

We welcome contributions to improve AtomVPN! Here's how you can help:

### Development Setup
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes and test thoroughly
4. Commit your changes: `git commit -m 'Add amazing feature'`
5. Push to the branch: `git push origin feature/amazing-feature`
6. Open a Pull Request

### Code Guidelines
- Follow Flutter/Dart coding conventions
- Add comments for complex logic
- Write unit tests for new features
- Ensure all tests pass before submitting

### Reporting Issues
- Use the GitHub issue tracker
- Provide detailed bug reports with steps to reproduce
- Include device information and error logs

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Acknowledgments
- **OpenVPN** - VPN protocol implementation
- **Flutter Team** - Amazing cross-platform framework
- **GetX** - State management solution
- **Material Design** - UI/UX guidelines

---

<div align="center">

**Made with ❤️ by the AtomVPN Team**

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/myfilesvivek)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/vvk27)
[![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/vivek_kumar18)

*Secure • Fast • Reliable*

</div>
