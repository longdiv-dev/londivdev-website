#!/bin/bash
# Optimize images for web

echo "Installing image optimization tools..."

# Check if brew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Please install Homebrew first:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

# Install optimization tools
brew install imagemagick pngquant 2>/dev/null || true

cd ~/workspace/londivdev-website/photos

# Create optimized directory
mkdir -p optimized

echo "Optimizing carousel images..."
for f in carousal/*.png; do
    filename=$(basename "$f" .png)
    
    # Convert to JPG with compression
    convert "$f" -resize 800x -strip -interlace Plane -gaussian-blur 0.05 -quality 85 "optimized/${filename}.jpg"
    
    echo "Optimized: $f → optimized/${filename}.jpg"
done

echo ""
echo "Optimizing AppIcon.png..."
convert AppIcon.png -resize 512x512 -strip -quality 90 optimized/AppIcon.jpg

echo ""
echo "Done! Checking sizes..."
ls -lh optimized/
echo ""
echo "Original carousel total:"
du -sh carousal/
echo "Optimized total:"
du -sh optimized/
