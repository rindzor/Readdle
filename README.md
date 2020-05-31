# Project Title

The app is a collectionView of people with their gravatars

# View a Demo

![](https://media.giphy.com/media/ThAMUJRQEArXzm7xlX/giphy.gif)

# Avatar Setting

If you do not want to see default gravatar icons when there is no user gravatar, just in Readdle -> Model -> ProfileManager.swift
uncomment `defaultImageUrl` constant at 14 line and 

```swift
if let url = URL(string: self.masterUrl + md5Hex + "?d=" + defaultImageUrl)
```
