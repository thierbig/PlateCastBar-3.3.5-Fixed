# PlateCastBarFixed
## Modern nameplate castbar for WoW 3.3.5
A polished nameplate castbar addon that shows castbars on all visible enemy nameplates (even when not targeted). Includes a full options panel, test mode, Blizzard-like defaults, scrollable media pickers, and smart fading.

<img width="1076" height="642" alt="image" src="https://github.com/user-attachments/assets/df23f1cf-23fe-4446-a006-d4ef75f6b01e" />

## Features
- **All nameplates**: Shows the castbar for any visible enemy that is casting, not just your target.
- **Blizzard-like preset**: One-click "Blizzard Defaults" button sets the texture to `Interface\\TargetingFrame\\UI-StatusBar` and the font to `Fonts\\FRIZQT__.TTF`.
- **Media browser (fonts & textures)**:
  - Scrollable pickers listing all bundled files under `Textures/` and `Textures/media/`.
  - Dropdowns show your current selection by name (robust to path case/slashes). 
- **Sizing & position**: Width, Height, X Offset, Y Offset.
  - Numeric input boxes next to each slider so you can type exact values.
- **Display toggles**: Show Icon, Show Spell Name, Show Timer.
- **Timer format**: LEFT (time left), TOTAL (full duration), BOTH.
- **Fading behavior**:
  - Disable fading on non-targets (NoFade) to keep castbars fully opaque regardless of nameplate alpha.
  - No-target fade alpha: when NoFade is OFF and you have no target, castbars fade to a configurable alpha (default 0.5).
- **Test mode**: Start/Stop Test to simulate casts on visible nameplates for easy positioning and tuning. Also via `/pcb test`.
- **Stable sizing**: When NoFade is ON, castbars are reparented to `UIParent` and their scale is synced to the owner so the bar dimensions stay consistent.

## Installation
- **Download/extract** the folder `PlateCastBarFixed` into `Interface/AddOns/`.
- For Epoch servers (recommended): use the AwesomeEpoch nameplate backport to enable modern nameplate events on 3.3.5a:
  - https://github.com/thierbig/AwesomeEpoch
- Alternative (general): awesome_wotlk
  - https://github.com/someweirdhuman/awesome_wotlk

## Usage
- **Open options**: `/pcb` or `Esc → Interface → AddOns → PlateCastBarFixed`.

## Options Overview
- **Width, Height, X Offset, Y Offset**: Sliders + numeric boxes.
- **Show Icon, Show Spell Name, Show Timer**: Checkboxes.
- **Timer format**: LEFT, TOTAL, BOTH.
- **Disable fading on non-targets**: Prevents alpha changes from the nameplate parent.
- **No Target Fade (alpha)**: Global alpha used for all castbars when you have no target (only when NoFade is OFF).
- **Texture, Font**: Dropdowns with a "Browse…" button that opens scrollable pickers of all bundled media.
- **Blizzard Defaults**: One-click preset for texture and font.

## Defaults
- **CastBar**: Width 86, Height 13, X 0, Y 12.
- **Spell text**: Size 7.
- **Timer text**: Size 7; Format LEFT (time left).
- **Elements shown**: Icon, Spell Name, Timer are On.
- **Fading**: Disable fading on non-targets = Off; No Target Fade alpha = 0.5.
- **Media**: Texture `Interface\\TargetingFrame\\UI-StatusBar`, Font `Fonts\\FRIZQT__.TTF`.

## Compatibility
- **Client**: Built for WoW 3.3.5 client. Requires AwesomeEpoch if you play on Epoch (recommended for Epoch) or awesome_wotlk.

## Screenshot

## Credits
- **Original**: PlateCastBar by Macumbafeh — https://github.com/Macumbafeh/PlateCastBar_awesome_wotlk
