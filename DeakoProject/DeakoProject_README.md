# DeakoProject_README

## Project description: 

A mobile app that fetches a list of Seattle traffic cameras and displays them in a table. The table of Seattle traffic cameras are in order of nearest to the user. Users are able to move freely through the table. Users are also able to select a traffic camera by tapping the table cell arrow to obtain further information and see the traffic camera image. 

# How tos:

## Instructions for installing dependencies:

***must have cocoapods installed. if not, run this line in your terminal:
sudo gem install cocoapods

more info here->  https://cocoapods.org/

### Steps:

1. Open the terminal 
2. cd filepath to project folder [ cd = change directories ]
3. type pod install 
4. press enter [This should successfully install pods]

## Instructions for building the app:

***This is assuming you have xCode & Cocoapods already installed on your mac device. If you do not, please copy & paste the link(s) below: 

link for xCode install -> https://apps.apple.com/us/app/xcode/id497799835?mt=12
link for cocoapod install-> https://cocoapods.org/

*Disclaimer: xCode is only available for mac devices and will not work for windows/linux devices

### Steps:

1. open Xcode (iOS IDE)
2. On the menu, click the last option reading "Open file or project"  [ This will open up your finder ]
3. . Go to the directory where DeakoProject is saved on your device
4.  Click on the file project that has ".xcworkspace" as its file extension 
5. Click Open  [ This should open the project file in xCode where you can see the written code ]
6. Go to Scheme Selector and select DeakoProject  (next to the stop button on the top of the xCode application) 
7.  Click the Phone Selector to select iPhone 11 Pro Max on simulator bar on the top of xCode (optional)
7. Click the "play" or "build" button on the top left of the application screen OR press cmd R simutaneously  [ This should build and run the application ]



## Design choices:

For this particular project design, I chose to present the data as a table because of the data quantity and the cells only needing to display a string. I decided to use a custom cell for the table to make them more appealing and apparent that they can be selected. As for the detail screen, I chose to split the screen in half. The top half depicts the traffic camera image, while the lower half displays that individual traffic camera's detailed information. This was also done in a table because the quantity of fields within each individual camera. In addition, each view contains a navigation bar at the top of the screen and is used to return to the camera list from the details view. I used UI inspiration from other apps that I found to be applicable (i.e. Deako). Not only does this UI work functionally for the traffic camera application but it is a good way to show that I am able to take a mock up design and effectively implement it programaticaly. This is important because I will be working with a team that has different design ideas and I will need the ability to replicate these ideas for the application. Lastly, I chose this UI design because it shows that I am able to complete a design that will be up to company standard in a short period of time when needed. 
