# Project CoCo is a Flutter application designed to **co**nditionally **co**lorize events in your Google Calendar. It leverages Google AppScript for backend logic and provides a user-friendly interface to manage which calendars are affected and how events are colored based on their properties.

## Features

*   **Google Calendar Integration:** Connects with your Google Calendar to fetch calendar lists and events.
*   **Selective Calendar Enablement:** Users can choose which of their Google Calendars they want CoCo to manage.
*   **Conditional Event Coloring:** Define event titles to automatically color-code calendar events.
    *   Pick specific colors for different event titles.
*   **Google Sign-In:** Securely authenticates users with their Google accounts to access calendar data.

## Tech Stack

*   **Frontend:** Flutter
*   **Api Logic:** Google AppScript (for interacting with Google Calendar services)
*   **Authentication:** Google Sign-In

## Project Structure (Inferred)

*   `lib/`
    *   `api/`
        *   `models/`: Contains data models like `CalendarModel.dart`, `EventPropertyModel.dart`.
        *   `util/`: Utilities for API communication like `ApiHelper.dart`.
    *   `screens/`
        *   `enable_calendars_screen.dart`: UI for users to select which calendars to manage.
        *   `event_picker_screen.dart`: UI for defining event properties and colors.
        *   `signin_screen.dart`: Handles Google Sign-In.
    *   `signin/`: Google Sign-In logic (`GoogleLogin.dart`).
    *   `main.dart`: Application entry point and routing.
*   `google_app_script/` (Assumed location for your AppScript code - *you might want to create this directory or link to your script*)