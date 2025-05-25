## **Flutter Calorie Tracking App: Implementation Instructions**

**Project Goal:** Develop a simple Flutter mobile application focused solely on tracking calorie (kcal) intake per day. The app should be based on the provided HTML/Tailwind CSS design, prioritizing ease of use and a clean interface.

**Key Differentiator:** This app *only* tracks kcal values. It does not manage food items, nutrients, or other complex dietary details.

### 1. Core Requirements & Overview

* **Platform:** Flutter (iOS & Android).
* **Design Source:** Implement the UI based on the previously provided HTML/Tailwind CSS code. A detailed breakdown is below.
* **Functionality:**
    * Daily calorie logging.
    * Navigation between different days.
    * Summation of total calories for the selected day.
    * Listing of individual meal/calorie entries with timestamps.
    * Ability to add, edit, and delete calorie entries.
* **Theme:** Support for both Light and Dark modes.

### 2. Screen Breakdown: Daily Calorie Log Screen

The application will primarily consist of a single main screen with the following components, as derived from the HTML structure:

**2.1. AppBar (Top Navigation)**
    * **Layout:** Centered title, with navigation icons on the left and right.
    * **Left Icon:** `CaretLeft` (SVG provided in HTML). Navigates to the previous day.
    * **Title:** Displays the current selected date (e.g., "Today", "May 25, 2025").
        * Style: `text-[#111518]`, `text-lg`, `font-bold`.
    * **Right Icon:** `CaretRight` (SVG provided in HTML). Navigates to the next day.
    * **Background:** White (`bg-white`) in light mode. Adjust for dark mode.

**2.2. Total Calories Display**
    * **Layout:** A distinct card below the AppBar.
    * **Label:** "Total Calories".
        * Style: `text-[#111518]`, `text-base`, `font-medium`.
    * **Value:** Displays the sum of all calorie entries for the selected day (e.g., "2,100").
        * Style: `text-[#111518]`, `text-2xl`, `font-bold`, `tracking-light`.
    * **Card Style:**
        * Background: `bg-[#f0f2f4]` in light mode. Adjust for dark mode.
        * Padding: `p-6`.
        * Rounded corners: `rounded-xl`.

**2.3. "Meals" Section Header**
    * **Text:** "Meals".
    * **Style:** `text-[#111518]`, `text-lg`, `font-bold`. Displayed above the list of meal entries.

**2.4. Meal List**
    * **Layout:** A vertically scrollable list of calorie entries for the selected day. Entries should be sorted by their creation timestamp in ascending order (earliest first).
    * **Each Item:**
        * Displays calorie amount (e.g., "450 cal").
            * Style: `text-[#111518]`, `text-base`, `font-medium`.
        * Displays creation timestamp (e.g., "8:00 AM").
            * Style: `text-[#637688]`, `text-sm`, `font-normal`.
        * Background: `bg-white` in light mode. Adjust for dark mode.
        * Minimum height: `min-h-[72px]`.
    * **Interactions:**
        * **Edit:** Tapping an item should allow editing its calorie value (timestamp remains unchanged). Propose a suitable UI (e.g., opening a dialog similar to the add dialog).
        * **Delete:** Allow deletion of entries. Propose a suitable UI (e.g., swipe-to-delete using `Dismissible` widget, or a delete option in an edit menu/dialog).
    * **Empty State:** If no meals are recorded for the selected day, display the text "No records yet." in the area where meal items would normally appear.

**2.5. Floating Action Button (FAB)**
    * **Icon:** `Plus` icon (SVG provided in HTML).
    * **Action:** Opens a dialog to add a new calorie entry.
    * **Position:** Bottom-right of the screen.
    * **Style:**
        * Background: `bg-[#268ae8]`.
        * Text/Icon Color: `text-white`.
        * Shape: `rounded-full`.
        * Size: `h-14`.

### 3. Functional Details

* **Data Input (New Meal):**
    * Triggered by the FAB.
    * A simple popup dialog should appear, allowing the user to input a numeric kcal value.
    * The timestamp for the new entry should be automatically set to the current system time (`created_at`) when the entry is saved. This timestamp should not change if the entry is later edited.
* **Data Display:**
    * Calories should be formatted with a comma for thousands (e.g., "2,100").
    * Timestamps should be in a user-friendly format (e.g., "8:00 AM").
* **Date Navigation:**
    * The AppBar arrows allow navigation to any past or future date. There is no restriction on the date range.
    * The app should always open to "Today's" date upon launch.
    * When the date changes, the "Total Calories" and "Meals" list must update to reflect the data for the newly selected date.

### 4. Technical Specifications

* **Language & Framework:** Flutter (latest stable version).
* **State Management:** No specific package is mandated. Choose a well-established and maintainable solution (e.g., Provider, Riverpod, BLoC/Cubit). Clearly document your choice and structure the state management logically.
* **Data Persistence:**
    * Data must be stored locally on the device.
    * Choose a suitable local storage solution (e.g., `sqflite`, `isar`, `hive`). `Isar` or `Hive` might be good choices for simpler object-based storage, keeping in mind potential future cloud sync. Document your choice.
    * The data model should include at least: calorie amount (integer), creation timestamp (DateTime).
* **Fonts:**
    * The design specifies "Manrope" and "Noto Sans". Implement using a reliable method, such as the `google_fonts` package or by including font files directly in the project assets. The choice is yours, ensure it works correctly.
* **Icons:**
    * The design uses SVG icons (`CaretLeft`, `CaretRight`, `Plus`). Use the `flutter_svg` package or a similar solution to render these. Ensure they are correctly scaled and colored.
* **Styling & Theming:**
    * **Colors:** Adhere to the color palette specified in the HTML/Tailwind CSS:
        * Primary Text/Icons: `#111518`
        * Total Calories Card BG: `#f0f2f4`
        * Meal Timestamp Text: `#637688`
        * FAB Background: `#268ae8`
        * White: `#FFFFFF` (general backgrounds)
    * **Tailwind to Flutter:** Translate Tailwind CSS utility classes (for sizing, spacing, typography, flexbox, etc.) into appropriate Flutter widget properties and layouts.
    * **Dark Mode:** Implement a complete dark mode theme. The color choices for dark mode should be aesthetically pleasing and maintain good contrast and readability. You can derive them from the light theme or use Material Design 3 principles.
* **Code Style & Linting:**
    * Follow standard Flutter/Dart coding conventions.
    * Employ effective linting rules. The user referenced the [Flutter repository style guide](https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md), which is very strict. For this project, using a standard, well-regarded linting package like `flutter_lints` (default in new Flutter projects) or `lints` / `effective_dart` and adhering to its rules is sufficient.
* **Folder Structure:** Organize the project files in a logical and scalable manner (e.g., feature-first or layer-first).
* **Null Safety:** Ensure the code is fully null-safe.

### 5. Future Considerations (For Information Only - Do Not Implement Now)

* **Target Calorie Feature:** The user intends to add a feature for setting a daily target calorie intake and displaying progress in the future. While not part of this initial build, design the data models and UI structure in a way that might simplify adding this later, if feasible without over-complicating the current scope.
* **Cloud Sync:** Future plans include cloud data synchronization. The choice of local persistence might consider this, but the current implementation is local-only.

### 6. Deliverables

* Complete Flutter project source code that implements all the features and design specifications outlined above.
* Clear comments in the code where necessary.
* A brief `README.md` file if any specific setup or running instructions are needed beyond standard `flutter run`.
* Ensure the app builds and runs correctly on both iOS and Android simulators/emulators.
