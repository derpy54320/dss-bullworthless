# Bullworthless!
A freeroam server where I may be adding whatever I feel like.
If you want to make some stuff for it too, feel free to reach out on [discord](https://discord.gg/r6abc7Avpm) or start a discussion on github.

# Connect
1. Download and install the [latest version of DSL](http://bullyscripting.net/downloads.html#dsl).
2. Start the game then open the newly generated `_derpy_script_loader/config.txt` file.
3. Set `allow_networking` to `true` and restart the game.
4. Run `/connect bullyscripting.net` in the console.

# Develop
If you want to make changes or entirely new scripts for Bullworthless, you'll first need to get the server running on your computer so you can test changes.
It does not require port forwarding or anything like that unless you need multiple people to test it. If you struggle with this, bring it up on discord.

## Github
If you're not familiar with github, the basic idea is that you *fork* the server to make your own copy of it on github, then create a *pull request* here when ready.
You can use [GitHub Desktop](https://desktop.github.com/) to work on your fork.

## Setup
1. Clone your fork of the server to your computer. We'll call this new folder the *server folder*.
2. Download [derpy's script server](http://bullyscripting.net/downloads.html#dsl) and put the executable in the server folder.
3. Start the server. It will tell you to configure the server. The defaults are fine, so run it again.
4. Run `/connect localhost` to connect to your server and test your scripts.

## Admin
You may also want to add yourself as an admin while testing the server.
On the real server, there is an `admin.txt` file in `scripts/[BASICS]/admin` that is not uploaded to github.
You'll have to make this file yourself, but it is fairly simple. Just put `admin_ip 127.0.0.1` in it and save it.
Restart the scripts using `/restart admin` if the server is already running and you're good to go!
You can see your new admin commands using `/help` (in the console).