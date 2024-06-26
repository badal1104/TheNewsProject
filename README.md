# TheNewsProject
Showing latest new from free News API

# Screenshots
![ss1](https://github.com/badal1104/TheNewsProject-main/assets/36571426/d10fcd56-7e7b-4450-bd19-7968881b05a1)
![ss2](https://github.com/badal1104/TheNewsProject-main/assets/36571426/c97491cc-2a73-4acd-85d4-c44702d7b950)
![ss3](https://github.com/badal1104/TheNewsProject-main/assets/36571426/0e88aff8-1ed2-4fb8-9066-9af9795ef73a)
![ss4](https://github.com/badal1104/TheNewsProject-main/assets/36571426/899fe9ce-ead0-433e-ae53-ea25ce31348a)
![ss5](https://github.com/badal1104/TheNewsProject-main/assets/36571426/8fa33691-be00-4304-8d42-d923e139dc70)
![ss6](https://github.com/badal1104/TheNewsProject-main/assets/36571426/465b59b6-68fa-43f6-b10f-4f358a13e601)

# Description
TheNewsProject is developed using the MVVM (Model-View-ViewModel) approach, separating responsibilities into different classes with proper abstractions. This ensures reusability, testability, scalability, and maintainability. Below is a brief description of the approach
1) **View Layer**: Includes NewsListView, ArticleCardView, ArticleDetailsView, BookmarkView, etc., which represent the UI.
2) **Models**: Includes NewsResponseModel, NewsArticleModel, and Category, which represent simple data models.
3) **ViewModel**: The NewsListViewModel depends on NewsServiceProtocol and SwiftDataManager, handling all the business logic and operations, then passing the data to the UI.
4) **NewsService**: The API service layer responsible for network requests. This abstraction allows for easy testing and swapping of network layers without affecting the rest of the codebase.
5) **ResponseDecoder**: Helps in decoding the response into meaningful objects.
6) **NetworkManager**: A singleton class for communicating with the server.
7) **SwiftDataManager**: A singleton class that handles local DB operations for storing, updating, and retrieving selected news categories like sports, business, health, etc.
8) **APIEndPoints**: An enum containing the API endpoints and aiding in the generation of URLRequest objects.
9) **NetworkError**: An enum of errors with descriptions.
10) **NetworkConfig**: A file of default values that helps in setting up the URL.
11) **NewsAppConstant**: A file storing all constant messages and images in the application.

# UIFlow:
![UIFlow](https://github.com/badal1104/TheNewsProject-main/assets/36571426/e7c9549b-f66e-481f-b491-f09b6cdb246f)
1) **ArticleCardView** - This view shows the title, description, and image of the news. For image loading, NUKE (https://github.com/kean/Nuke) is used for downloading and caching purposes. While URLCache and NSURLCache can be used, managing them becomes difficult as the project complexity increases. NUKE offers a scalable and stable framework, avoiding the need to reinvent the wheel.
2) **ArticleDetailView** - This view opens details of the news in a WKWebView. WKWebView is used because the content in the response is limited text for free APIs, like: **"content":"You may have heard reports in recent days of a flesh-eating bacteria spreading in Japan, referring to an illness that can occur with streptococcal toxic shock syndrome (STSS). \r\nMedia reports indicat…_ [+5501 chars]"_** 
The response also contains the news URL with specific full details, so WKWebView is chosen to show the complete content.
3) **BookmarkView** - The bookmarks are displayed in the latest order, meaning the most recent bookmarks will be visible first. The bookmarking data is stored in a local array and will be reset after every relaunch.
I used a local array because ideally, there should be an API for bookmarking, and while fetching news from the News API, it should indicate the bookmark status (true or false). However, I handled this by adding an isBookmark property in the response. This property is modified and stored whenever the user interacts with the bookmark action.


# SequenceDiagram:
![SequenceDiagram](https://github.com/badal1104/TheNewsProject-main/assets/36571426/e7d674a5-d3a0-4aaa-96b6-57087ed25b8f)


# ClassAndUMLDiagram:
![ClassAndUmlDiagram](https://github.com/badal1104/TheNewsProject-main/assets/36571426/eee036e6-5e7d-458f-8446-099feee490e0)


# Testing:
Focus on unit testing, which is done using the XCTest framework. We've achieved good coverage, as shown in the attached figure.
<img width="1233" alt="Screenshot 2024-06-25 at 6 28 48 PM" src="https://github.com/badal1104/TheNewsProject-main/assets/36571426/da0e4d22-79f7-47cc-bee0-e96f9ad05f4b">

# Tools used
Xcode - 15.3\
iOS minimum target - 17.0\
Framwork - SwiftUI, Observation framwork, Nuke\
Database - SwiftData\
MacOS - 14.3\
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

