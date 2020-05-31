# Project Title

The app is a collectionView of people with their gravatars

# View a Demo

![](https://gph.is/g/ZlRwnpg)

# Avatar Setting

If you do not want to see default gravatar icons when there is no user gravatar, just in Readdle -> Model -> ProfileManager.swift
uncomment defaultImageUrl constant at 14 line and 

```
if let url = URL(string: self.masterUrl + md5Hex + "?d=" + defaultImageUrl)
```