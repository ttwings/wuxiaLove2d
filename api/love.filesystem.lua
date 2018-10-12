---@class love.filesystem
---Provides an interface to the user's filesystem.
local m = {}

--region File
---@class File : Object
---Represents a file on the filesystem.
local File = {}
---Closes a file.
---@return boolean
function File:close() end

---Flushes any buffered written data in the file to the disk.
---@return boolean, string
function File:flush() end

---Gets the buffer mode of a file.
---@return BufferMode, number
function File:getBuffer() end

---Gets the filename that the File object was created with. If the file object originated from the love.filedropped callback, the filename will be the full platform-dependent file path.
---@return string
function File:getFilename() end

---Gets the FileMode the file has been opened with.
---@return FileMode
function File:getMode() end

---Returns the file size.
---@return number
function File:getSize() end

---Gets whether end-of-file has been reached.
---@return boolean
function File:isEOF() end

---Gets whether the file is open.
---@return boolean
function File:isOpen() end

---Iterate over all the lines in a file
---@return function
function File:lines() end

---Open the file for write, read or append.
---
---If you are getting the error message "Could not set write directory", try setting the save directory. This is done either with love.filesystem.setIdentity or by setting the identity field in love.conf.
---@param mode FileMode @The mode to open the file in.
---@return boolean
function File:open(mode) end

---Read a number of bytes from a file.
---@param bytes number @The number of bytes to read
---@return string, number
function File:read(bytes) end

---Seek to a position in a file.
---@param position number @The position to seek to.
---@return boolean
function File:seek(position) end

---Sets the buffer mode for a file opened for writing or appending. Files with buffering enabled will not write data to the disk until the buffer size limit is reached, depending on the buffer mode.
---@param mode BufferMode @The buffer mode to use.
---@param size number @The maximum size in bytes of the file's buffer.
---@return boolean, string
function File:setBuffer(mode, size) end

---Returns the position in the file.
---@return number
function File:tell() end

---Write data to a file.
---@param data string @The data to write.
---@param size number @How many bytes to write.
---@return boolean
function File:write(data, size) end

--endregion File
--region FileData
---@class FileData : Data
---Data representing the contents of a file.
local FileData = {}
---Gets the extension of the FileData.
---@return string
function FileData:getExtension() end

---Gets the filename of the FileData.
---@return string
function FileData:getFilename() end

--endregion FileData
---Buffer modes for File objects.
BufferMode = {
	---No buffering. The result of write and append operations appears immediately.
	['none'] = 1,
	---Line buffering. Write and append operations are buffered until a newline is output or the buffer size limit is reached.
	['line'] = 2,
	---Full buffering. Write and append operations are always buffered until the buffer size limit is reached.
	['full'] = 3,
}
---How to decode a given FileData.
FileDecoder = {
	---The data is unencoded.
	['file'] = 1,
	---The data is base64-encoded.
	['base64'] = 2,
}
---The different modes you can open a file in.
FileMode = {
	---Open a file for read.
	['r'] = 1,
	---Open a file for write.
	['w'] = 2,
	---Open a file for append.
	['a'] = 3,
	---Do not open a file (represents a closed file.)
	['c'] = 4,
}
---Append data to an existing file.
---@param name string @The name (and path) of the file.
---@param data string @The data that should be written to the file
---@param size number @How many bytes to write.
---@return boolean, string
function m.append(name, data, size) end

---Gets whether love.filesystem follows symbolic links.
---@return boolean
function m.areSymlinksEnabled() end

---Creates a directory.
---@param name string @The directory to create.
---@return boolean
function m.createDirectory(name) end

---Check whether a file or directory exists.
---@param filename string @The path to a potential file or directory.
---@return boolean
function m.exists(filename) end

---Returns the application data directory (could be the same as getUserDirectory)
---@return string
function m.getAppdataDirectory() end

---Returns a table with the names of files and subdirectories in the specified path. The table is not sorted in any way; the order is undefined.
---
---If the path passed to the function exists in the game and the save directory, it will list the files and directories from both places.
---@param dir string @The directory.
---@return table
function m.getDirectoryItems(dir) end

---Gets the write directory name for your game. Note that this only returns the name of the folder to store your files in, not the full location.
---@param name string @The identity that is used as write directory.
function m.getIdentity(name) end

---Gets the last modification time of a file.
---@param filename string @The path and name to a file.
---@return number, string
function m.getLastModified(filename) end

---Gets the platform-specific absolute path of the directory containing a filepath.
---
---This can be used to determine whether a file is inside the save directory or the game's source .love.
---@param filepath string @The filepath to get the directory of.
---@return string
function m.getRealDirectory(filepath) end

---Gets the filesystem paths that will be searched when require is called.
---
---The paths string returned by this function is a sequence of path templates separated by semicolons. The argument passed to require will be inserted in place of any question mark ("?") character in each template (after the dot characters in the argument passed to require are replaced by directory separators.)
---
---The paths are relative to the game's source and save directories, as well as any paths mounted with love.filesystem.mount.
---@return string
function m.getRequirePath() end

---Gets the full path to the designated save directory. This can be useful if you want to use the standard io library (or something else) to read or write in the save directory.
---@return string
function m.getSaveDirectory() end

---Gets the size in bytes of a file.
---@param filename string @The path and name to a file.
---@return number, string
function m.getSize(filename) end

---Returns the full path to the the .love file or directory. If the game is fused to the LÖVE executable, then the executable is returned.
---@return string
function m.getSource() end

---Returns the full path to the directory containing the .love file. If the game is fused to the LÖVE executable, then the directory containing the executable is returned.
---
---If love.filesystem.isFused is true, the path returned by this function can be passed to love.filesystem.mount, which will make the directory containing the main game readable by love.filesystem.
---@return string
function m.getSourceBaseDirectory() end

---Returns the path of the user's directory.
---@return string
function m.getUserDirectory() end

---Gets the current working directory.
---@return string
function m.getWorkingDirectory() end

---Initializes love.filesystem, will be called internally, so should not be used explicitly.
---@param appname string @The name of the application binary, typically love.
function m.init(appname) end

---Check whether something is a directory.
---@param path string @The path to a potential directory.
---@return boolean
function m.isDirectory(path) end

---Check whether something is a file.
---@param path string @The path to a potential file.
---@return boolean
function m.isFile(path) end

---Gets whether the game is in fused mode or not.
---
---If a game is in fused mode, its save directory will be directly in the Appdata directory instead of Appdata/LOVE/. The game will also be able to load C Lua dynamic libraries which are located in the save directory.
---
---A game is in fused mode if the source .love has been fused to the executable (see Game Distribution), or if "--fused" has been given as a command-line argument when starting the game.
---@return boolean
function m.isFused() end

---Gets whether a filepath is actually a symbolic link.
---
---If symbolic links are not enabled (via love.filesystem.setSymlinksEnabled), this function will always return false.
---@param path string @The file or directory path to check.
---@return boolean
function m.isSymlink(path) end

---Iterate over the lines in a file.
---@param name string @The name (and path) of the file.
---@return function
function m.lines(name) end

---Loads a Lua file (but does not run it).
---@param name string @The name (and path) of the file.
---@param errormsg string @The error message if file could not be opened.
---@return function
function m.load(name, errormsg) end

---Mounts a zip file or folder in the game's save directory for reading.
---@param archive string @The folder or zip file in the game's save directory to mount.
---@param mountpoint string @The new path the archive will be mounted to.
---@return boolean
---@overload fun(archive:string, mountpoint:string, appendToPath:string):boolean
function m.mount(archive, mountpoint) end

---Creates a new File object. It needs to be opened before it can be accessed.
---@param filename string @The filename of the file to read.
---@param mode FileMode @The mode to open the file in.
---@return File, string
function m.newFile(filename, mode) end

---Creates a new FileData object.
---@param contents string @The contents of the file.
---@param name string @The name of the file.
---@param decoder FileDecoder @The method to use when decoding the contents.
---@return FileData
---@overload fun(filepath:string):FileData, string
function m.newFileData(contents, name, decoder) end

---Read the contents of a file.
---@param name string @The name (and path) of the file.
---@param bytes number @How many bytes to read.
---@return string, number
function m.read(name, bytes) end

---Removes a file or directory.
---@param name string @The file or directory to remove.
---@return boolean
function m.remove(name) end

---Sets the write directory for your game. Note that you can only set the name of the folder to store your files in, not the location.
---@param name string @The new identity that will be used as write directory.
---@param appendToPath boolean @Whether the identity directory will be searched when reading a filepath before or after the game's source directory and any currently mounted archives.
function m.setIdentity(name, appendToPath) end

---Sets the filesystem paths that will be searched when require is called.
---
---The paths string given to this function is a sequence of path templates separated by semicolons. The argument passed to require will be inserted in place of any question mark ("?") character in each template (after the dot characters in the argument passed to require are replaced by directory separators.)
---
---The paths are relative to the game's source and save directories, as well as any paths mounted with love.filesystem.mount.
---@param paths string @The paths that the require function will check in love's filesystem.
function m.setRequirePath(paths) end

---Sets the source of the game, where the code is present. This function can only be called once, and is normally automatically done by LÖVE.
---@param path string @Absolute path to the game's source folder.
function m.setSource(path) end

---Sets whether love.filesystem follows symbolic links. It is enabled by default in version 0.10.0 and newer, and disabled by default in 0.9.2.
---@param enable boolean @Whether love.filesystem should follow symbolic links.
function m.setSymlinksEnabled(enable) end

---Unmounts a zip file or folder previously mounted for reading with love.filesystem.mount.
---@param archive string @The folder or zip file in the game's save directory which is currently mounted.
---@return boolean
function m.unmount(archive) end

---Write data to a file.
---
---If you are getting the error message "Could not set write directory", try setting the save directory. This is done either with love.filesystem.setIdentity or by setting the identity field in love.conf.
---@param name string @The name (and path) of the file.
---@param data string @The string data to write to the file.
---@param size number @How many bytes to write.
---@return boolean, string
---@overload fun(name:string, data:Data, size:number):boolean, string
function m.write(name, data, size) end

return m