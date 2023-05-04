# Footprint - Social Media Tracker for Easy Digital Information Management.
<p align="center">
    <img 
    width="500"
    height="500"
    src="https://user-images.githubusercontent.com/57926472/162923906-efea1e84-8af5-481e-b8a5-a16c3fe828d6.png"
  >
</p>

## Introduction
Every single posts, comments, and shares that you made on social media are most likely to still be there until now. Social medias make it really hard for you to keep track of your data and remove your contributions. Thus, majority of the users feel that they have lost control over their digital infromation on social media.

We strongly resonated with the anxiety that users feel about their personal information. As the first step to help people regain their control over their personal information, we have created Footprint. Footprint is a social media tracker that helps you to easily manage your digital information on social media.

Footprint mainly focusses on these two problems:
Problem #1: It takes too much time to scroll down and view all of your past posts
Problem #2: People are worried that they might have contents on social media that they don't want others to view


We have solved these two problems through:
1) Bringing social media post data in a low memory format that could be easily loaded and organized.
2) Providing suggestions for posts that you might want to delete by analyzing your posts with threat analysis algorithm.

## App Demo
Solarized dark             |  Solarized Ocean
:-------------------------:|:-------------------------:
![main_screen](https://user-images.githubusercontent.com/57926472/236097544-b6a2722c-4959-4db0-82f2-ab7f41d0831e.PNG)  |  ![threat_level](https://user-images.githubusercontent.com/57926472/236097579-79fecad7-1ead-4dd0-bdb8-358840fe8e7d.PNG)


## About the Team
Our team is called Bottlecap. We have named our team with the first thing that we saw in front of us. As bottlecap is one of the most ubiquitous things around us, we want to find problems within the things that are around us. With the belief that well-made products are defined by the problems they solve, we obsessively focus on the things that people feel uncomfortable about. 


## Versions
* Flutter: 2.10.4
* Dart: 2.16.2
_IOS version on Podfile was set to 15.4_


## Dependencies
_For Additional Information, check yhack2022/pubspec.yaml_
* Firebase Core: 1.14.0
* Firebase Auth: 3.3.13
* Firebase Analytics: 9.1.4
* Cloud Firestore: 3.1.11
* Cloud Functions: 3.2.11
* URL Launcher: 6.0.20


## Installing
### For IOS:
1. git clone this repository
2. run flutter pub get command in yhack2022/yhack2022 folder
3. move to yhack2022/yhack2022/ios and run pod install (make sure that podfile.lock indicates IOS version of 15.4)

### For Android:
-To be updated-

## Miscallaneous:
* Threat Analysis Algorithm has not been fully integrated with the app. Threat Analysis Algorithm currently works seperately from the app.

## Contributors
* Seung Chol Cho - App Development
* Kyu Hwan Choi - App Development
* Eui Sang Lee - Data Analysis
