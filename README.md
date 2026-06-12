# filo_antipeek

`filo_antipeek` is a utility resource for FiveM designed to enhance combat realism and fairness. It prevents players from shooting when their weapon's muzzle is obstructed by an object, even if their third-person camera suggests a clear line of sight.

## Features

- **Obstacle Detection**: Real-time checking for objects immediately in front of the weapon muzzle.
- **Visual Feedback**: Displays a configurable on-screen indicator (e.g., ❌) when a shot is blocked.
- **Player Notifications**: Sends automated notifications to inform the player why they cannot fire.
- **Highly Configurable**: Easily adjust text, notification frequency, and toggle features via `config.lua`.

## Installation

1. Place the `filo_antipeek` folder into your server's `resources` directory.
2. Add `ensure filo_antipeek` to your `server.cfg`.

## Configuration

Modify `config.lua` to suit your server's needs:

| Option | Description |
| :--- | :--- |
| `Config.DisplayText` | Enable or disable the on-screen visual indicator. |
| `Config.Text` | The string/icon displayed when the muzzle is blocked. |
| `Config.Notify` | Enable or disable chat/UI notifications. |
| `Config.NotifyInterval` | How often (in milliseconds) the notification can trigger to avoid spam. |
| `Config.NotificationText` | The message sent to the player when an obstacle is detected. |

## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib)