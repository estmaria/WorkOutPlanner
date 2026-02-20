# WorkoutPlannerApp

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Video Demo](#Video-Demo)

## Overview

### Description

- This app allows users to build custom workout routines by adding exercises with details such as sets, reps, and weights.
- When creating a new routine, users can reuse previously saved routines, referencing their most recent weights for guidance.
- The app includes a calendar view to log and view workout history by date.
- Additionally, a dedicated tab displays personal records (PRs) for each exercise, helping users track progress and stay motivated.
- An external API integration provides exercise suggestions based on the user's selected muscle groups.

### App Evaluation
- **Category:** Health & Fitness
- **Mobile:**  I don’t think there is or at least I haven't seen something like this that is actually good so in that aspect it would be unique. There will be an implementation of a calendar to see what days user did what routine.
- **Story:** This app empowers users to take control on their workouts with customized routines. The ability to track progress and see their PRs also adds motivation.
- **Market:** The market is very big. Nowadays there is a lot of people that are into fitness so it would be very valuable
- **Habit:** users would use the app every time they workout so the engagement would depend on how often the user workout. It is engaging because you can compare your progress of doing the same routine and how you went up in weight. They user creates content and gets insights from it.
- **Scope:**  I don’t think is double to fully create the app with all the functionalities I have in mind but I think I can create a base with basic functionalities and build from that

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
1. Create workout routines
   - Users can create custom workout routines by adding exercises that include:
      - Exercise name
      - Number of sets
      - Reps per set
      - Weight used
2. View saved routines
   - Users can see a list of routines they’ve created, including:
      - Routine title
      - Optional subtitle
      - Date created or last used
3. Routine detailed view
   - Tapping a routine shows all included exercises with full details (sets, reps, weight).
4. Calendar integration
   - Tapping a routine shows all included exercises with full details (sets, reps, weight).

**Optional Nice-to-have Stories**
1. Personal Records Tab
   - It displays the user's personal best for each exercise
2. Variable weights and reps for the sets
   -  Allows users to log different weights and reps for each individual set within an exercise
3. Exercise suggestion via API
   - Based on a selected muscle group (e.g. "chest" or "legs"), the app recommends exercises pulled from an external fitness API
4. Previous routine reference
   - When selecting an existing routine to perform again, the app shows weights used during the last session for reference
5. Routine search in calendar:
   - Search for a specific routine by name and highlight the days it was performed within the calendar
6. Progress visualization
   - basic charts or graph that show improvement over time for specific exercises
7. Change between pounds and kilograms
8. Add some kind of optional notes to the exercises

### 2. Screen Archetypes
**Routine Stream Screen (Stream)**
- Users can view a list of saved workout routines
- Each item shows the routine name, optional notes, and last used date
- Tap a routine to see details
  
**Routine Detail Screen (Detail)**
- Displays full list of exercises within a selected routine
- For each exercise: show sets, reps, and weights

**Exercise Creation Screen (Creation)**
- Enter:
   - Exercise name
   - Number of sets
   - Reps
   - Weight per set
  
**Calendar Screen (Calendar)**
- Users can view a calendar showing which routine was completed on each day
- Tap on a date to see routine details performed that day
- Search for a routine and the days in which that routine was completed will highlight

**Personal Records (PR) and Progress Visualization Screen (Profile/Stream)**
- Users can view their best performance for each exercise (Example: Bench Press – 200lbs x 5 reps)
- Users can also see graphs that show the improvement in the exercises

**Exercise Suggestion Screen (Stream)**
- Based on selected muscle group, show exercise suggestions fetched via API
- Allow users to add a suggested exercise into their custom routine


### 3. Navigation

**Tab Navigation** (Tab to Screen)
- Routine Stream Screen
- Calendar Screen
- Personal Records (PR) and Progress Visualization Screen
- Exercise Suggestions Screen

**Flow Navigation** (Screen to Screen)
- Routine Stream Screen
   - Tap a routine → Routine Detail Screen
   - Tap "+" button → Routine Detail Screen (empty)
- Routine Detail Screen
   - Tap "+" button → Excersise Creation Screen
  -  Tap a exercise → Excersise Creation Screen(pre-filled for editing)
  -  Tap "Back" button → Back to Routine Stream Screen
- Exercise Creation Screen
  - Tap "Save" button  → Back to Routine Detail Screen
- Calendar Screen
  - Tap on a date with a workout → Routine Detail Screen (shows details of routine completed that day)
- Personal Records (PR) and Progress Visualization Screen
   - None
- Exercise Suggestions Screen
   - None

## Wireframes
<img src="https://github.com/user-attachments/assets/964d0170-171b-4a2e-b8d8-f18ec040610f" width=600>

## Video Demo
<div style="padding:204.95% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1166565397?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479&amp;autoplay=1&amp;loop=1" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Screen Recording 2026-02-19 at 9.52.02 PM"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>
