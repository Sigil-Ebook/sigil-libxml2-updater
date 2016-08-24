#About

This is an executable **Linux-only** "updater" that installs a patched version of libxml2 into a Sigil installation. It addresses a bug in libxml2-2.9.3 and higher that affects how QtWebKit renders html entities.

Type a visible html entity into Sigil's Code View. If it appear twice in Sigl's Preview or Book View, then you have the buggy version of libxml2.

#Creating the installer
To build the updater, you must have [makeself](https://github.com/megastep/makeself/releases/latest) installed (and on in your PATH).

Running ./makeupdater.sh will create the installer, which can then be used to update Sigil to work around the libxml2 bug on other Linux machines.

#Using the installer

Download the latest installer from:

[https://github.com/Sigil-Ebook/sigil-libxml2-updater/releases/latest](https://github.com/Sigil-Ebook/sigil-libxml2-updater/releases/latest)

Make sure its executable bit is set and run it (as sudo/su) from the command line:

> `sudo ./sigil_libxml2_update.run`

It will search for the Sigil binary in /usr/lib/sigil and /usr/local/lib/sigil. If it finds it, it will ask if you want to copy the patched version of libxml2 to Sigil's directory.

**At no time will this updater alter or affect your system version of libxml2.**

---

The script tests for uname=="x86_64" and if true, installs the 64-bit version, otherwise it installs the 32-bit version. If you have a 32-bit version of Sigil installed on a 64-bit machine, this will obviously not work (but won't cause any huge issues either). In that case you'll need to extract the contents of the archive and copy the correct one manually to your Sigil directory `<INSTALL_PREFIX>/lib/sigil/`, and rename it to libxml2.so.2.

For those familiar with makeself.sh, there are several arguments you can pass to the "sigil_libxml2_update.run" archive for various purposes:

+ --info : Print out general information about the archive (does not extract).

+ --list : List the files in the archive.

+ --check : Check the archive for integrity using the embedded checksums. Does not extract the archive.

+ --keep : Prevent the files to be extracted in a temporary directory that will be removed after the embedded script's execution. The files will then be extracted in the current working directory and will stay here until you remove them.

+ --noexec : Do not run the embedded script after extraction.

If someone wanted to manually extract the files and copy them to the Sigil directory manually, they should use

> `./sigil_libxml2_update.run --keep --noexec`

That will extract the contents of the archive (a folder named "sigil_libxml2_update") to the current directory.

You'll need to rename to correct one (64- or 32- bit) to libxml2.so.2 after you copy it to `<INSTALL_PREFIX>/lib/sigil/`, or it won't work.

