# EngineerLiveTokyo

## Dependencies

It uses [crossroadlabs/Markdown](https://github.com/crossroadlabs/Markdown) for parsing markdown documents, do it requires a discount installed.

on macOS:

```
brew install discount
```

on Linux:

```
sudo apt-get install libmarkdown2-dev
```

Also, if you want to build it on Xcode, you have to set Library and Header search paths:

In Xcode's project settings, 

- Open `App`'s "All" of "Build Settings", and add `/usr/local/include` to "Header Search Paths"
- Open `Markdown`'s "All" of "Build Settings", and add `/usr/local/include` to "Header Search Paths"
- Open `Markdown`'s "All" of "Build Settings", and add `/usr/local/lib` to "Library Search Paths"

```

## Configuration

```
API_ENDPOINT=https://example.com/api
```

## Deployment

```
heroku create --buildpack https://github.com/vapor-community/heroku-buildpack.git
```

```
heroku buildpacks:add --index 1 https://github.com/heroku/heroku-buildpack-apt
```
