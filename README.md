[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/S6S310DONO)

# FiveM Vehicle Deletion Script

## Description

This FiveM script provides functionality to delete vehicles in or around the player's vicinity. It includes checks to ensure the player is in the appropriate seat or near a vehicle before deletion. The script also handles retries and provides feedback messages to the entire server.

## Features

- **Vehicle Deletion:** Delete vehicles the player is in or near.
- **Seat Validation:** Ensures the player is in the driver seat to delete a vehicle.
- **Retry Mechanism:** Retries vehicle deletion if the initial attempt fails.
- **Feedback Messages:** Provides informative messages to players using the chat system.

## How to Use

**In-Game Command:**
   - Use the `/dv` command to attempt vehicle deletion.

## Installation

1. **Download:**
   - Place the script (`AJ_DV`) into your FiveM server's resources folder.

2. **Configuration:**
   - Add `start AJ_DV` to your `server.cfg` configuration file.

3. **Start Server:**
   - Restart your FiveM server or start it if it's not already running.
