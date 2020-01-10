# Hacker's Guide to Visual FoxPro

See the GitHub pages site ([https://hackfox.github.io/](https://hackfox.github.io/)) if you want to read the content.

If you wish to contribute to Hacker's Guide, the source repository ([https://github.com/HackFox/Source](https://github.com/HackFox/Source)) has two tables you'll find useful:

* Contents.dbf: contains the names of the files representing all documents except those in the reference section (section 4). Documents are in folders by section. For example, the FileName field in Contents contains s1c4.html for the "SQL—The Original" document. The first two characters indicate the section, so this is section 1. Although FileName has "html" as the extension, that was used when generating the help (CHM) file. On this site, all documents are Markdown (md) files, so the document for "SQL—The Original" is section1/s1c4.md.

* NewAllCAndF.dbf: contains every command, function, class, property, method, and event in VFP and its document number. All documents are in the section4 folder and start with "s4g". For example, the nGroup field in NewAllCAndF contains 408 for TAGNO(), which means the document for that function is section4/s4g408.md.

Both of these tables are provided as DB2 files, which are text equivalents of the DBF files. To convert these files to tables, use FoxBin2PRG or run ConvertTextToBinary.bat.