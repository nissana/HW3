# HW3
### Mailbox

Week 3 Project for the [CodePath](http://www.codepath.com/) course [iOS Bootcamp for designers] (http://codepath.com/iosfordesigners).

Use Xcode to leverage animations and gestures to implement the Mailbox interactions.

> Featured as one of the Top App projects

Time spent: 11 hours spent in total 

Completed user stories:
 * [x] Required: Setup, Mailbox Screen, Message Interaction, Swipeable Menu

 * On dragging the message left...

  -  Initially, the revealed background color should be gray.
  -  As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
  - After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
  - After 260 pts, the icon should change to the list icon and the background color should change to brown.
Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
  - User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.

 * On dragging the message right...

  - Initially, the revealed background color should be gray.
  - As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
  - After 60 pts, the archive icon should start moving with the translation and the background should change to Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
  -  After 260 pts, the icon should change to the delete icon and the background color should change to red.
Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.

 * [x] Optional: Tap the segmented control
 * [x] Optional: Shake to undo
 
Walkthrough of all user stories:

![hw3](https://cloud.githubusercontent.com/assets/10460611/6320979/a42ece3e-baa2-11e4-84c0-ff1364d8f1ad.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).
