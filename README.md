# ArmA Reforger Server Setup Script by [Save5Bucks]  
                           
    ┏━━━┓╋╋╋╋╋╋╋╋┏━━━┓╋╋╋┏━┓
    ┃┏━┓┃╋╋╋╋╋╋╋╋┃┏━┓┃╋╋╋┃┏┛
    ┃┃╋┃┣━┳┓┏┳━━┓┃┗━┛┣━━┳┛┗┳━━┳━┳━━┳━━┳━┓
    ┃┗━┛┃┏┫┗┛┃┏┓┃┃┏┓┏┫┃━╋┓┏┫┏┓┃┏┫┏┓┃┃━┫┏┛
    ┃┏━┓┃┃┃┃┃┃┏┓┃┃┃┃┗┫┃━┫┃┃┃┗┛┃┃┃┗┛┃┃━┫┃
    ┗┛╋┗┻┛┗┻┻┻┛┗┛┗┛┗━┻━━┛┗┛┗━━┻┛┗━┓┣━━┻┛
    ╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋┏━┛┃
    ╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋╋┗━━┛

> **💥 Boom!** Ready to deploy your own ArmA Reforger Server in **military** style?  
> **Arma Reforger** is all about immersive battlefields, and now you can set up your own server **fast** with this script!  

## ⭐ Features  
- **Automated Installation**: Downloads and extracts SteamCMD, installs ArmA Reforger server files.  
- **Multiple Server Folders**: Dynamically creates `Server_0`, `Server_1`, etc.  
- **Optional Base Config**: Creates a pre-filled JSON config file for quick setup.  
- **Firewall Rules**: Optionally opens the required UDP ports (2001, 17777) for inbound/outbound traffic.  
- **Start Script Generation**: Automatically makes a `start.bat` with auto-updates, auto-restart, and crash logging.  

## 🪖 How It Works
1. **Clone or Download** this repository.  
2. **Locate** `setup_arma_server.bat`.  
3. **(Recommended) Run as Administrator** in Windows, or open `cmd` and run the script manually.  
4. Follow the **on-screen prompts** to:  
   - Choose installation drive.  
   - Create a server folder (e.g., `C:\Server\Server_0`).  
   - (Optional) Download & install SteamCMD if missing.  
   - Install/Update **ArmA Reforger** server.  
   - (Optional) Create a base configuration file.  
   - (Optional) Open firewall ports.  
   - (Optional) Generate a `start.bat` script.  

## 🚀 Usage Steps  
1. **Double-click** or **run** `setup_arma_server.bat` in a **command prompt** window.  
2. **Answer** the prompts (Y/N) to tailor your setup.  
3. Once finished, **open** the newly created server folder (e.g., `Server_0`).  
4. **Optional**: Edit `config.json` to customize server settings.  
5. **Launch** the server with `start.bat`.  

## 🔥 Crash & Restart Handling  
- If you opt to create `start.bat`, it:  
  - **Updates** your server via SteamCMD.  
  - **Launches** the game executable.  
  - Logs **crashes** or graceful stops to a `server.log`.  
  - **Auto-restarts** after 5 seconds, so your server returns to battle quickly!  

## 🎖️ Notes & Tips  
- **Make sure your ports 2001 & 17777 are open** if you want public connections.  
- **Check** your `server.log` for any crash-related messages or exit codes.  
- If you prefer manual control, you can skip some prompts (like firewall rules).  

## 🏅 Contributing  
Pull requests are welcome! If you’d like to tweak or enhance the script further, feel free to fork and submit a PR.

## ⚠️ Disclaimer  
This script is provided **as-is**, without warranty. Use at your own risk. Always back up your files before installing or updating.

---

Made with 💥 by **[Save5Bucks]** & The ArmA Reforger Community  
**Enjoy the battlefield!** 🪖⚔️  

