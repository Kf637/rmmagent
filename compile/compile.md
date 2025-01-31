# How to Use the Automatic Compiler
## **Building the file yourself is not supported by the developers of Tactical RMM and no help is available**

**NOTE:** Ensure that Git and Go are installed.

**Git** Install: https://git-scm.com/downloads  
**Go** Install: https://go.dev/doc/install


1. [Download `Build TRMM Agent.bat (Windows Only)`](./Build%20TRMM%20Agent.bat)
2. Run the batch file and select the OS and architecture.
3. Once the compilation is complete, you will be prompted to choose where to move the compiled application.

# Installing on Linux

1. [Download the `rmm.sh` file](https://gist.githubusercontent.com/Kf637/7b4f1f791a9e5c13c08404c20af91fef/raw/1afea9ad3cd770bb8ca985ed93cdcfbbd0efde8e/gistfile1.txt) and open it in an editor like Notepad++ or Notepad
2. Fill in the following details: `meshDL`, `apiURL`, `token`, `clientID`, `siteID`, `agentType` (server or workstation).
3. Upload the compiled file from `Build TRMM Agent.bat` to https://station307.com and click "Copy URL".
4. Paste the URL into the `agentDL` field in the `rmm.sh` file.
5. Upload `rmm.sh` to station307 and click "Copy URL". If you want, you can SSH into the system where you want to install it. Use `wget` with the URL like `wget https://l.station307.com/XXXXXXX/rmm.sh`. Once downloaded, run the file with `sudo bash rmm.sh` to install.

**Note:** SSHing into the system is optional but makes the process easier. You don't have to use station307 as long as you can download from a direct link.

# How to Get `token`, `clientID`, `siteID`, and `meshDL`

## meshDL
Log into your Mesh page using the super admin account and go to "My Devices". Under there, you will see a group named TacticalRMM. Next to it, you'll see a button named "Add Agent". Click on that button and select the OS you need (for Linux, select Linux / BSD / macOS Binary Installer). Select the system type matching the system you want to install the Tactical RMM agent on. Copy the command URL, which will look something like `wget -O meshagent "https://mesh.domain.example/meshagents?id=XXXXXXXXXXXXXXXXXXXXX&installflags=0&meshinstall=6"`. Paste the URL part into the `meshDL`.

## Token (not yet tested if it works), clientID, and siteID
Click on Agents -> Install Agent and select the correct client and site -> Installation Method, and select Manual -> Show Manual Install. Copy the auth token, client ID, and site ID (all marked in red).

![Instruction Image](https://i.ibb.co/s2NWBmD/image-2024-11-25-155736001.png)
