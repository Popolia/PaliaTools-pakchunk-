# PaliaTools (pakchunkTools)
pakchunkTools

pakchunkTools.EXE =  to download a pakchunk by typing, for example : pakchunk2-WindowsClient.pak  (pour avoir le pakchunk2)

Palia_manifeste.EXE= create 2 manifests, one that creates a hash from the files you have and the other that takes the manifest from palia (where the vertion is marked, download url is the hash of each document)

Logs_Filter_2.exe= allows you to filter the 2 manifests quickly and easily


ps1: I've kept the .bat just in case, but normally you won't need to use it.  ^_^

ps2 : .exe on ,  just run it as an .exe

ps3 : File Integrity Verification:

If you have a hash value (e.g., MD5, SHA-1, or SHA-256) of the original file, you can recalculate the hash of the current file and compare it to the original hash. If the hashes do not match, the file is corrupted.

So, what I've done is created a manifest using this method and compared it with the reference manifest. All you need to do is compare the values between the two manifests. Currently, I haven't been able to automate this process.

ps4 : https://github.com/Lyaaaaaaaaaaaaaaa/Logs_Filter_2/tree/v1.2.0 

Functionalities

Efficiently search through logs - ctrl+f isn't efficient for big files

Start by casting a wide net - By setting to off you can fetch all the lines where at least one filter appears.Search for all filters

Sharpen your search - By setting to on you can fetch the lines where all your filters appear.Search for all filters

Disable/Enable case sensitivity

See in real time the statistics of your search - The number of lines searched and the number of lines matching your filters are displayed in the top right-hand corner of the application.

Copy to the clipboard - In one click you can copy the whole output into your clipboard.

Saved preferences - You can change the size, style or color of the font and more.

Drag and drop - Don't waste time! Drag your log file directly into the software.



![Capture d’écran 2023-09-03 023648](https://github.com/Popolia/PaliaTools-pakchunk-/assets/69745473/dee4372f-8093-45ff-a492-6b2dc7c8de24)

![Capture d’écran 2023-09-03 023543](https://github.com/Popolia/PaliaTools-pakchunk-/assets/69745473/520c0313-7f54-402f-a246-fbeda5a4c1ba)

![Capture d’écran 2023-09-03 023954](https://github.com/Popolia/PaliaTools-pakchunk-/assets/69745473/4992a1f5-05a2-4c8f-826f-7ff006e1b003)

![Capture d’écran 2023-09-03 024029](https://github.com/Popolia/PaliaTools-pakchunk-/assets/69745473/ce89d1d5-f168-47be-a4e5-81417fdacfe5)

The basic default file path is : C:\Users\Admin\AppData\Local\Palia\Client\Palia\Content\Paks

to remind  , to go to the AppData => Window + R => %localappdata%

![Capture d’écran 2023-09-02 011134](https://github.com/Popolia/PaliaTools-pakchunk-/assets/69745473/7939ed09-074a-4afc-8553-dbc8bb19478a)
