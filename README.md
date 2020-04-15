# holoDesk
- This is iOS app for my own cardboard AR goggle by combining iPhone and Leap Motion (hand tracking controller). You can manipulate contents by hand gestures, and enjoy some awesome AR experiences!
- [Demo movie](https://twitter.com/benmon0412/status/1085147985992806400)

# Watching movies in space around you
- If you want to watch movies, you should watch in AR spaces! Let's launch video apps:
<img width="914" alt="Video1" src="https://user-images.githubusercontent.com/40908783/79302021-09e97100-7f26-11ea-8b83-163ab2a9ce94.png">
- Select a movie you want to watch.
<img width="1099" alt="Video2" src="https://user-images.githubusercontent.com/40908783/79301942-d1499780-7f25-11ea-94de-0ada6eab8306.png">
- And you can watch it like this:
<img width="1104" alt="Video3" src="https://user-images.githubusercontent.com/40908783/79301930-cb53b680-7f25-11ea-80c5-d5d72618d85a.png">
- You can change screen size or rotate it using your hands.
- For details, you can check [this demo movie](https://twitter.com/benmon0412/status/1085147130333818880):

# AR search on amazon.com
- You can search anything in front of you on amazon.com. For example, let's search this comic book!
![holoDesk1](https://user-images.githubusercontent.com/40908783/79300684-66e32800-7f22-11ea-807b-a33c4608fb85.jpeg)
- Just put it in front of you, and touch "search button".
![holoDesk2](https://user-images.githubusercontent.com/40908783/79300676-5f238380-7f22-11ea-98b2-4e729366e7e0.jpeg)
- You can access to the amazon page of it on the browser.
- ![holoDesk3](https://user-images.githubusercontent.com/40908783/79300677-5fbc1a00-7f22-11ea-964c-ef6091623d92.jpeg)
- For details, you can check [this demo movie](https://twitter.com/benmon0412/status/1085147591719890944):

# Dependencies
- iOS: version 12.0~
    - This is written in Swift using ARKit 2, so you have to prepare iOS 12 or later that support ARKit 2.
- Leap Motion
- server PC (normal one, doesn't ask for specs.)
    - I realize the connection between iPhone and LeapMotion via WebSocket communication, so you need a server PC to act as an intermediary between them.
- If you want to try this application, please set your iPhone to a simple cardboard goggles like this:
![holoDesk4](https://user-images.githubusercontent.com/40908783/79300679-6054b080-7f22-11ea-9c8b-d9d31213fae5.jpeg)

