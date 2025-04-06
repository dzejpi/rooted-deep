# Rooted Deep
My videogame for Ludum Dare #57.

![itchio_game_banner](https://github.com/user-attachments/assets/5c64c871-55c7-401d-9de9-17b5e5c86c97)

Job market’s desperate — so you answered a mysterious job offer. Now you’re deep underwater with no idea what’s coming next. Are you up to the task?

# How to play
The corporation (you’re not allowed to name it — NDAs and all) is experimenting with underwater plant growth, and you’re the “volunteer” assigned to make it work.

Grow strange new plants, harvest their fruits, and sell back what you can. Oxygen is limited, resources are tight, and the corporation couldn’t care less about your comfort — only your output.

To escape your contract, you’ll need to earn 2500 currency — enough to buy your ticket out. Until then… keep planting. And keep breathing.

![Snímek obrazovky 2025-04-06 221510](https://github.com/user-attachments/assets/e3b356c5-e455-4c12-b8c1-f191d4186b0f)

# Gameplay
You start out with one Lunara seed:

![Snímek obrazovky 2025-04-06 205159](https://github.com/user-attachments/assets/7783bbd5-09a8-4e28-8eaa-815251f0c89f)

You can press 1 and start planting the new plant. Confirm the plant with left click.

![Snímek obrazovky 2025-04-06 204223](https://github.com/user-attachments/assets/c4afce5e-5430-4394-bb57-448c6f737327)

Plant will start growing its fruits right away. Once fruits are fully grown, you will see “Collect fruit” tooltip, which lets you know that you can harvest fruits. No need to click on each fruit separately, just hold your left mouse button.

![Snímek obrazovky 2025-04-06 204006](https://github.com/user-attachments/assets/b40278b8-4f08-4415-aafd-7fc2067c72b9)

Look out for the oxygen levels - only now you realise that you should have exercised a little bit more. Once you’re out of breath, go to your safety pot.

Your safety pot contains a computer, which you can use by looking at it and pressing E.

![Snímek obrazovky 2025-04-06 204131](https://github.com/user-attachments/assets/2050cb11-7d05-4a13-90f7-a5b80fef4b4b)

This will show you the computer screen where you can:

* Sell your fruits - either by one, or all fruits at once
* Buy new seeds - you can buy seeds by one, or you can buy as many as you can afford.
* Upgrade - upgrades can increase your maximum oxygen, speed, profits. Last update is your ticket out.

![Snímek obrazovky 2025-04-06 204030](https://github.com/user-attachments/assets/b80519bc-11fd-4533-8d45-1767a30df65f)

If you have more than 250 #, you can upgrade your pots as well. Every non-upgraded pot will show you this prompt:

![Snímek obrazovky 2025-04-06 214726](https://github.com/user-attachments/assets/733db926-7b9b-48da-a89e-31c3308b9f19)

If you upgrade your pot by pressing E, fruits in that specific pod will autocollect themselves. You can also tell which pot is upgraded and which isn’t, because you will see a new arrow object:

![Snímek obrazovky 2025-04-06 214733](https://github.com/user-attachments/assets/300cb760-2be8-4d16-91df-c7ad6ba497d7)

Good luck!

# Controls
WSAD: Move like in all 3D first person games.
Space: Go upwards
C/Q: Go downwards
Left click: Interaction with items.
1-4: Star placing flower pot
Escape: Toggle pause menu. Focus on HTML5 on Itchio is not perfect, so if you’re playing HTML5 version, press Esc twice and click on the Continue button with your mouse to focus it back properly.
Shift (hold): Sprint (or well, its equivalent for swimming)
E: Interact with computer/buy autoharvested update.

# Tools used
Nothing fancy here.

Game engine: Godot 4.3.
Aseprite
Blender
Audacity

# Known issues
* Sometimes you are thrown around a tiny bit - I have absolutely no idea why. I suspected some colliders, but there are no extra colliders anywhere, and it didn’t happen in debug mode, which definitely makes everything more interesting. face_palm
* Web version - If you place around 135 flowers, all objects disappear. Unfortunately, this is Godot’s web limitation. It happens once you go over a certain amount of nodes in the scene. Thankfully, this is way, way beyond reasonable number of flowers, so, this should not happen to you, unless you’re testing limits. However, if you want to get serious with building your own garden, download local builds.

# Commentary

This felt like a bit off more than I could chew, but I managed to get something playable out there. However, for the future, I think I will stick with my FPS games. Once games require some UI with more elements, it is my end, and I’m not that good at creating nice UIs quickly. On a positive note, I learned a lot about groups and shaders!
