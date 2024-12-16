# foretell
 
A simple app written for an elderly relative who is getting to the point of life where regular medical appointments and various check ups and follow ups have become a fact of life.

Something of a spiritual successor to something I did a few years ago:

https://github.com/charlierobin/desktop-clock

I wanted aforementioned relative to have a constant list of upcoming appointments on their (macOS) laptop, without having to learn anything about the Calendar app.

So I took the idea of the desktop clock app, ditched the clock part of it, and changed a few other bits (including rewriting it using Swift/SwiftUI, rather than the original’s Xojo).

Relative’s local GP works an alternate week schedule, depending on whether the week numnber is even or odd.

So as well as listing appointments from a calendar/calendars, the app also checks the number of the week, and displays the appropriate info (stored in a couple of text files within the app’s resources directory), just so relative doesn’t have to go checking around on the internet hunting this information down.

I was interested in finding out a little about SwiftUI, so this initial version has been done using that.

A slight wrinkle is that relative’s laptop is running Catalina, and they refuse to consider changing up to something more contemporary. So there are a few places where what’s been done was limited by the versions of Swift and SwiftUI available with a target of macOS 10.15.7 in Xcode.

Needs access to user’s calendar(s) (via EventKit), and runs as agent (UIElement), ie: does not appear in the Dock as a running app.

The main window runs at desktop level, so is always behind all main app windows, but just above the desktop picture.

![Screenshot 2024-12-16 at 13 41 10](https://github.com/user-attachments/assets/e392e9b5-481f-414f-b070-7559ea5c07db)

![Screenshot 2024-12-16 at 13 41 20](https://github.com/user-attachments/assets/5d613451-2fb5-46ff-90c9-d8ba1026d964)
