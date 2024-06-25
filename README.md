# TheNewsProject
Showing latest new from free News API

# Screenshots
![Simulator Screenshot - Clone 3 of iPhone 15 Pro - 2024-06-26 at 00 59 54](https://github.com/badal1104/TheNewsProject-main/assets/36571426/e8f4024e-ab57-47ea-9ca9-5735f38f6af6)
![Simulator Screenshot - Clone 3 of iPhone 15 Pro - 2024-06-26 at 01 02 27](https://github.com/badal1104/TheNewsProject-main/assets/36571426/e95de89d-c56f-45e0-97de-f3f60faef1aa)
![Simulator Screenshot - Clone 3 of iPhone 15 Pro - 2024-06-26 at 01 01 08](https://github.com/badal1104/TheNewsProject-main/assets/36571426/1f17e90e-8499-4306-b570-06eb00e5b140)
![Simulator Screenshot - Clone 3 of iPhone 15 Pro - 2024-06-26 at 01 00 35](https://github.com/badal1104/TheNewsProject-main/assets/36571426/ab3e964a-407b-414c-93d6-eb05d7dfcb23)
![Simulator Screenshot - Clone 3 of iPhone 15 Pro - 2024-06-26 at 01 00 25](https://github.com/badal1104/TheNewsProject-main/assets/36571426/c00cb787-4148-4a54-834c-307f019bda49)
![Simulator Screenshot - Clone 3 of iPhone 15 Pro - 2024-06-26 at 01 00 11](https://github.com/badal1104/TheNewsProject-main/assets/36571426/4b9f333a-f34b-46cd-85a3-da68b25e08c3)
![Simulator Screenshot - Clone 3 of iPhone 15 Pro - 2024-06-26 at 01 00 03](https://github.com/badal1104/TheNewsProject-main/assets/36571426/ad020e8b-330a-465b-b461-d84929103bbd)



# UIFlow:
![UIFlow](https://github.com/badal1104/TheNewsProject-main/assets/36571426/e7c9549b-f66e-481f-b491-f09b6cdb246f)


# SequenceDiagram:
![SequenceDiagram](https://github.com/badal1104/TheNewsProject-main/assets/36571426/e7d674a5-d3a0-4aaa-96b6-57087ed25b8f)


# ClassAndUMLDiagram:
![ClassAndUmlDiagram](https://github.com/badal1104/TheNewsProject-main/assets/36571426/eee036e6-5e7d-458f-8446-099feee490e0)


# Testing:
Focus on unit testing, which is done using the XCTest framework. We've achieved good coverage, as shown in the attached figure.
<img width="1233" alt="Screenshot 2024-06-25 at 6 28 48 PM" src="https://github.com/badal1104/TheNewsProject-main/assets/36571426/da0e4d22-79f7-47cc-bee0-e96f9ad05f4b">

# Tools used
Xcode - 15.3
iOS minimum target - 17.0
Framwork - SwiftUI, Nuke (for image caching, I used Nuke and avoided reinventing the wheel. (https://github.com/kean/Nuke))
Database - SwiftData (for storing the selected category, because I want to show the news of the lastest selected category when the user relaunches the application.)
MacOS - 14.3
Macbook pro, M3

# Issue
I created this project in Xcode 15.3, as mentioned in the tools used section, and published it on GitHub. However, when I cloned it on another machine (MacBook Pro, Intel i7, Xcode 15.2), it showed an error: "Missing package product 'NukeUI'." The SPM was causing issues. I tried resetting the package cache and updating to the latest version, but without success.

Note: It's not necessary that everyone will face this issue, but I did. Here's the solution that worked for me:

1) Right-click on TheNews.xcodeproj
2) Click "Show Package Contents"
3) Right-click on project.xcworkspace
4) Click "Show Package Contents"
5) Select xcshareddata
6) Select swiftpm
7) Delete Package.resolved
8) Wait for the package to resolve in Xcode. If successful, then run the project.

 <img width="534" alt="Screenshot 2024-06-26 at 12 25 31 AM" src="https://github.com/badal1104/TheNewsProject-main/assets/36571426/660fe7ac-d4a8-4e6a-adfb-11d2249c8262">

