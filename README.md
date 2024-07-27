# Schedule Planner

The Schedule Planner App is a powerful tool designed to help users manage their tasks and stay organized. This app includes features such as task scheduling, reminders, and categorization of tasks. In this version, we introduce several new widgets and functionalities to enhance user experience and streamline task management. Key widgets include `Drawer`, `SnackBar`, `AlertDialog`, `Chip`, `Radio`, `PopupMenuButton`, and `ExpansionPanel`. We will also discuss form validation, passing arguments through named routes, and using `Provider` for state management.

## Key Widgets Used

### Drawer
- **Description**: `Drawer` is a slide-in menu that typically contains navigation options. It helps users navigate between different sections of the app.
- **Use Case in Schedule Planner App**: The `Drawer` can be used to access various parts of the app such as "Tasks," "Categories," "Settings," and "Profile." It provides a convenient way to navigate the app’s features without cluttering the main screen.
- **Example Usage**: Implementing a `Drawer` to offer navigation options and settings for managing tasks and viewing different categories.

### SnackBar
- **Description**: `SnackBar` is a temporary message that appears at the bottom of the screen, providing feedback to the user. It typically contains an action button and automatically disappears after a short duration.
- **Use Case in Schedule Planner App**: `SnackBar` can be used to notify users of actions such as task completion, errors, or successful task addition. It provides immediate feedback in a non-intrusive manner.
- **Example Usage**: Displaying a `SnackBar` when a user successfully adds a new task or when there’s an error in task input.

### AlertDialog
- **Description**: `AlertDialog` is a modal dialog that displays important information or prompts the user for confirmation. It usually contains a title, content, and actions.
- **Use Case in Schedule Planner App**: `AlertDialog` can be used for confirming task deletions, reminding users of upcoming deadlines, or requesting additional details before saving a task.
- **Example Usage**: Showing an `AlertDialog` when a user attempts to delete a task to confirm the action.

### Chip
- **Description**: `Chip` is a small, interactive element used to represent input, choices, or filters. Chips can be used for tagging or categorizing items.
- **Use Case in Schedule Planner App**: `Chip` can be used to display tags or categories for tasks, such as "Work," "Personal," or "Urgent." It helps users quickly filter and organize tasks.
- **Example Usage**: Using `Chip` to filter tasks by category or priority.

### Radio
- **Description**: `Radio` is a widget that allows users to select a single option from a group of choices. It’s useful for presenting mutually exclusive options.
- **Use Case in Schedule Planner App**: `Radio` buttons can be used to select task priorities or categories. Users can choose options like "High Priority," "Medium Priority," or "Low Priority."
- **Example Usage**: Implementing `Radio` buttons in a form to set the priority level of a task.

### PopupMenuButton
- **Description**: `PopupMenuButton` is a button that displays a menu when pressed. The menu contains a list of options that the user can select.
- **Use Case in Schedule Planner App**: `PopupMenuButton` can be used to provide additional actions or settings related to tasks, such as sorting options or task view modes.
- **Example Usage**: Using `PopupMenuButton` to offer options like "Sort by Date," "Sort by Priority," or "View Completed Tasks."

### ExpansionPanel
- **Description**: `ExpansionPanel` is a widget that expands and collapses to show or hide content. It’s useful for displaying detailed information in a collapsible format.
- **Use Case in Schedule Planner App**: `ExpansionPanel` can be used to show detailed information about tasks or categories, allowing users to expand panels to view more details without cluttering the interface.
- **Example Usage**: Implementing `ExpansionPanel` to display detailed information about a task or a list of tasks under a specific category.

## Key Concepts

### Form with Validation
- **Description**: Forms in Flutter can be validated to ensure user input meets certain criteria. Validation is crucial for maintaining data integrity and providing feedback to users.
- **Importance in Schedule Planner App**: Form validation ensures that task details are entered correctly before submission. For example, validation can check if the task title is not empty and that the due date is in the future.


### Passing Arguments through Named Routes
- **Description**: Named routes in Flutter allow you to navigate between different screens and pass arguments to those screens.
- **Importance in Schedule Planner App**: Passing arguments through named routes allows you to navigate to a specific task’s detail page with the relevant data, such as the task ID or title.

### Provider
- **Description**: `Provider` is a state management solution that allows you to manage and provide state across your app efficiently. It helps in accessing and modifying shared data.
- **Importance in Schedule Planner App**: Using `Provider`, you can manage task data, user settings, and other stateful information throughout the app. It ensures that state changes are reflected across different parts of the app without excessive boilerplate code.
