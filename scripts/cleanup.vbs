'script to strip out the first line of the WMIC csv files for use later

wscript.echo("cleaning up files...")

set fso = createobject("scripting.filesystemobject")
set shell = createobject("wscript.shell")

set dir = fso.getfolder("..\FILES")

set files = dir.files

for each file in files

	ext = fso.getextensionname(file.name)

	if ucase(ext) = "CSV" then

		'arrname = split(file.name, ".", -1, 1)
		'newname = arrname(0) & "-data.csv"

		oldname = file.name
		file.name = "temp-" & file.name

		'open file, delete first line

		set readfile = fso.opentextfile(file.name, 1, False, -1) 'open file for reading, pass false (don't create if missing) and -1 (open as unicode)
		set writefile = fso.createtextfile(oldname, 2) 'open file for writing

		readfile.skipline() 'move past first blank line

		do while readfile.atendofstream <> True

			'write remaining lines to new file

			line = readfile.readline
			writefile.writeline(line)

		loop

		readfile.close
		writefile.close

		fso.deletefile(file.name)

	end if

next

