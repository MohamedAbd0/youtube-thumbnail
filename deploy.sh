#!/bin/bash

# YouTube Thumbnail Generator - Deployment Script
# This script builds the Flutter web app and updates the docs folder for GitHub Pages

echo "🚀 Building Flutter Web App..."

# Build the web application
flutter build web --release --base-href "/youtube-thumbnail/"

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    echo "📁 Updating docs folder..."
    
    # Create docs folder if it doesn't exist
    mkdir -p docs
    
    # Copy built files to docs folder
    cp -r build/web/* docs/
    
    echo "✅ Files copied to docs folder!"
    echo ""
    echo "📝 Next steps:"
    echo "1. git add docs/"
    echo "2. git commit -m 'Update deployment'"
    echo "3. git push origin main"
    echo ""
    echo "🌐 Your app will be live at: https://YOUR_USERNAME.github.io/youtube-thumbnail/"
    
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi
