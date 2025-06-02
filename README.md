# YouTube Thumbnail Generator 🎬

A modern, responsive Flutter web application for extracting high-quality thumbnails from YouTube videos instantly.

[![Deploy to GitHub Pages](https://github.com/MohamedAbd0/youtube-thumbnail/actions/workflows/deploy.yml/badge.svg)](https://github.com/MohamedAbd0/youtube-thumbnail/actions/workflows/deploy.yml)

## 🌟 Features

- **Multiple URL Formats**: Supports all YouTube URL formats
- **High-Quality Thumbnails**: Various resolution options available
- **Multiple Domains**: Choose from different YouTube CDN domains
- **Format Options**: JPG and WEBP support
- **Responsive Design**: Works perfectly on mobile, tablet, and desktop
- **Modern UI**: Clean, professional interface with smooth animations
- **Instant Preview**: Real-time thumbnail preview
- **Easy Copy**: One-click URL copying to clipboard

## 🚀 Live Demo

Visit the live application: [YouTube Thumbnail Generator](https://mohamedabd0.github.io/youtube-thumbnail/)

## 📱 Supported URL Formats

- `https://www.youtube.com/watch?v=VIDEO_ID`
- `https://youtu.be/VIDEO_ID`
- `https://www.youtube.com/embed/VIDEO_ID`
- `https://www.youtube.com/watch?v=VIDEO_ID&t=60s`

## 🛠️ Technology Stack

- **Flutter Web**: Cross-platform UI framework
- **Responsive Design**: flutter_screenutil for responsive layouts
- **Modern UI**: Material Design 3 principles
- **GitHub Pages**: Automated deployment with GitHub Actions

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/MohamedAbd0/youtube-thumbnail.git
   cd youtube-thumbnail
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run -d chrome
   ```

## 🚢 Deployment

The app is automatically deployed to GitHub Pages using GitHub Actions when changes are pushed to the main branch.

### Manual Deployment

1. Build for web:
   ```bash
   flutter build web --base-href "/youtube-thumbnail/"
   ```

2. Deploy the `build/web` folder to your hosting service.

### GitHub Pages Setup

1. Go to your repository settings
2. Navigate to "Pages" section
3. Set source to "GitHub Actions"
4. The workflow will automatically deploy on push to main branch

## 🎨 UI Improvements

The latest version includes:

- **Modern Color Scheme**: Professional blue and gray palette
- **Enhanced Typography**: Improved font sizes and weights
- **Better Spacing**: Consistent margins and padding
- **Loading States**: Smooth loading animations
- **Error Handling**: User-friendly error messages
- **Responsive Layout**: Optimized for all screen sizes
- **Hover Effects**: Interactive elements with smooth transitions
- **Card-based Design**: Clean, organized content sections

## 📋 Available Thumbnail Qualities

- Full-size Image
- Maximum Resolution
- High Quality
- Medium Quality
- Standard Definition
- Default Thumbnail
- Various frame options (1, 2, 3)
- Alternate high-quality options

## 🌐 Domain Options

- `img.youtube.com`
- `i.ytimg.com`
- `i3.ytimg.com`

## 🔧 Development

### Prerequisites

- Flutter SDK (3.24.0 or later)
- Dart SDK
- Chrome browser for web development

### Running Locally

```bash
# Get dependencies
flutter pub get

# Run in debug mode
flutter run -d chrome

# Build for production
flutter build web --release
```

## 📱 Screenshots

The application features a modern, responsive design that works seamlessly across all devices.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Mohamed Abdo**

- GitHub: [@MohamedAbd0](https://github.com/MohamedAbd0)
- LinkedIn: [Mohamed Abdo](https://www.linkedin.com/in/mohamed-abdo95/)
- Medium: [@mohamed-abdo](https://mohamed-abdo.medium.com/)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- YouTube for providing thumbnail APIs
- GitHub Pages for free hosting

---

⭐ Star this repository if you find it helpful!
