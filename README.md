# Friendly Scorer

A scoreboard for a single round of [Friendly Competition](https://www.theincomparable.com/gameshow/friendly/).

![Screenshot of Friendly Scorer, a web app with three columns. Players are on the left, special rules on the right, and answers in the middle. Answers are dragged onto players or special rules to label that answer.](readmeassets/web_light.png)

Friendly Scorer hosted as a web app: https://friendlyscorer.web.app/

## How to add answers

Add answers by typing or pasting at the bottom of the middle column. Answers can be space-, comma-, or newline-separated. Tap the row of answers that is split correctly, or press enter if you're feeling lucky (first row of answers).

> Seeking feedback about answer parsing! How are answers usually formatted from the players? Is the current answer splitting useful?

## More screenshots

Web

![Screenshot of Friendly Scorer as a web app with light mode appearance](readmeassets/web_light.png)
![Screenshot of Friendly Scorer as a web app with dark mode appearance](readmeassets/web_dark.png)

iOS

![Screenshot of Friendly Scorer as an iOS app with light mode appearance](readmeassets/ios_light.png)
![Screenshot of Friendly Scorer as an iOS app with dark mode appearance](readmeassets/ios_dark.png)

macOS

![Screenshot of Friendly Scorer as a macOS app with light mode appearance](readmeassets/mac_light.png)
![Screenshot of Friendly Scorer as a macOS app with dark mode appearance](readmeassets/mac_dark.png)


## Prerequisites

* Flutter: https://docs.flutter.dev/get-started/install

## Building and deploying for the web

1. `flutter build web`.
2. Deploy the contents of `./build/web` to a static web host.
  * https://friendlyscorer.web.app/ is hosted on Firebase Hosting, so `firebase deploy`.
