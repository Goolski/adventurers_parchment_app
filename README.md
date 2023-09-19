# Adventurer's Parchment

Adventurer's Parchment is a Dungeons & Dragons (D&D) helper app built with Flutter. It provides a user-friendly interface for accessing and exploring D&D 5th Edition spells, allowing users to filter spells by class, level, or spell school. This app utilizes the dnd5eapi.co API to fetch spell data and is designed to be a valuable resource for players and Dungeon Masters.

![Adventurer's Parchment Screenshot](screenshot.png)

## Features

- Browse and search D&D 5th Edition spells by class, level, and school of magic.
- Detailed spell information, including casting time, range, duration, components, and more.
- A user-friendly interface for easy spell exploration.
- Integration with the dnd5eapi.co API for up-to-date spell data.
- Complies with the D&D 5th Edition System Reference Document (SRD).

## Technologies Used

- **Flutter**: Adventurer's Parchment is built using the Flutter framework, allowing for a seamless and responsive user experience on both Android and iOS.

- **dio**: The dio package is used for making HTTP requests to fetch spell data from the dnd5eapi.co API.

- **jsonSerializable**: jsonSerializable is utilized for easy serialization and deserialization of JSON data received from the API.

- **googleFonts**: Custom fonts from Google Fonts are used to enhance the app's visual appeal and readability.

- **hive**: Hive is employed as a local database for caching spell data, ensuring smooth performance and offline access.

- **provider**: Provider is used for state management, making it easy to manage and update app state.

- **rxdart**: The rxdart package is used to implement reactive programming, enabling seamless data flow and state management.

- **go_router**: go_router is used for efficient and customizable routing within the app, ensuring a smooth navigation experience.

## Getting Started

To get started with Adventurer's Parchment, follow these steps:

1. Clone the repository to your local machine:

   ```shell
   git clone https://github.com/yourusername/adventurers-parchment.git
   ```

2. Navigate to the project directory:

   ```shell
   cd adventurers-parchment
   ```

3. Install the required dependencies:

   ```shell
   flutter pub get
   ```

4. Run the app on your preferred emulator or physical device:

   ```shell
   flutter run
   ```
   
---

**Disclaimer:** Adventurer's Parchment is a fan-made app and is not affiliated with Wizards of the Coast or the creators of Dungeons & Dragons. All D&D-related content is subject to copyright by Wizards of the Coast.
