# unix_organiser

Folder Organizer — Smart File Sorting Shell Script
A simple, elegant, and intelligent way to clean up your messy folders.

This project is a lightweight Bash script that automatically organizes files inside any folder by sorting them into categories such as Images, Documents, Media, Archives, and Others.

It supports dry-run mode, duplicate renaming, smart conflict detection, and gives clean, readable output showing exactly what happens during the organization process.

🚀 Features
✔️ Automatic Sorting

Files are sorted into folders based on their extensions:

Category	Extensions
Images	jpg, jpeg, png, gif, bmp, tiff
Documents	pdf, doc, docx, txt, xls, xlsx, ppt, pptx
Media	mp3, wav, flac, aac, m4a, mp4, mov, avi, wmv
Archives	zip, tar, gz, 7z, rar
Others	Anything not matching above
✔️ Dry Run Mode (-n)

Preview changes WITHOUT actually moving files.

[DRY RUN] Would move image.jpg to Images/image.jpg


Perfect when you want to test the script safely.

✔️ Duplicate File Handling

If a file already exists in the target folder, the script:

Detects the conflict

Shows a conflict alert

Auto-renames the new file with a number

Example:

[CONFLICT] File invoice.pdf already exists. Renaming...
[MOVED] invoice.pdf -> Documents/invoice_1.pdf


No overwritten files. No surprises.

✔️ Clear and Friendly Output

Every operation is displayed, including:

File moves

Renaming behavior

Errors (e.g., permission issues)

Conflicts

Dry-run previews

✔️ Zero Dependencies

Just Bash. Nothing else.
Works on Linux, macOS, WSL, servers, anywhere with a shell environment.

📦 Installation

Clone the repo (or download the script):

git clone https://github.com/YOUR_USERNAME/folder-organizer.git
cd folder-organizer


Make the script executable:

chmod +x organizer.sh


Done.

🛠️ Usage
🎯 Basic Usage

Organize a folder:

./organizer.sh /path/to/your/folder

🧪 Dry Run (Simulation Mode)

Preview without moving anything:

./organizer.sh -n /path/to/your/folder


You'll see output like:

----------------------------------
PRETEND MODE (DRY RUN) IS ON! I WILL NOT MOVE ANY FILES.
----------------------------------
[DRY RUN] Would move photo.png to Images/photo.png

📘 Examples
▶️ Example 1: Normal Run
./organizer.sh ~/Downloads


Output:

[MOVED] cat.png -> Images/cat.png
[MOVED] document.pdf -> Documents/document.pdf
[MOVED] song.mp3 -> Media/song.mp3
[MOVED] backup.zip -> Archives/backup.zip

▶️ Example 2: Dry Run With Collision
./organizer.sh -n ~/Desktop/messy


Output:

[CONFLICT] File photo.jpg already exists. Renaming...
[DRY RUN] Would move photo.jpg to Images/photo_1.jpg
[DRY RUN] Would move notes.txt to Documents/notes.txt

🗂️ How Sorting Works

The script automatically detects the extension of each file and stores it in the corresponding folder.
If the folder doesn't exist, it is automatically created.

Sorting logic:

jpg/jpeg/png/gif/bmp/tiff → Images
pdf/doc/docx/txt/xls/xlsx/ppt/pptx → Documents
mp3/wav/flac/aac/m4a/mp4/mov/avi/wmv → Media
zip/tar/gz/7z/rar → Archives
everything else → Others

🧩 Duplicate / Conflict Handling

If a file named image.jpg already exists in Images/, and another file with the same name is found, the script automatically renames the new one:

image.jpg       → original
image_1.jpg     → new file
image_2.jpg     → third file


You will clearly see:

[CONFLICT] File image.jpg already exists. Renaming...

⚠️ Error Handling

The script safely handles:

Missing folder argument

Non-existent paths

Permission problems

Invalid options (e.g., -x)

You’ll see friendly messages like:

Error: That folder does not exist!
Oops! You used a strange button: -x

🧨 Why This Script Is Awesome

No dependencies

Safe dry run mode

Prevents accidental file overwriting

Clean readable logging

Great for cleaning Downloads, Desktop, shared folders

Works on servers (cronjob + auto-organization!)



Recursive organization

Logging system
