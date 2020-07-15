xcrun simctl shutdown all

path=$(find ~/Library/Developer/Xcode/DerivedData/GymApp-*/Build/Products/Debug-iphonesimulator -name "GymApp.app" | head -n 1)
echo "${path}"

filename=MultiSimConfig.txt
grep -v '^#' $filename | while read -r line
do
xcrun simctl boot "$line" # Boot the simulator with identifier hold by $line var
xcrun simctl install "$line" "$path" # Install the .app file located at location hold by $path var at booted simulator with identifier hold by $line var
xcrun simctl launch "$line" Chris.GymApp # Launch .app using its bundle at simulator with identifier hold by $line var
done
