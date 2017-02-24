
set fso = createobject("scripting.filesystemobject")
set shell = createobject("wscript.shell")

wscript.echo("writing hosts...")

set readfile = fso.opentextfile("..\FILES\workgroup.yml", 1)
set writefile = fso.createtextfile("..\FILES\hosts.txt", true)

do until readfile.atendofstream

	line = readfile.readline

	if instr(line, "worker.hosts") > 0 then
		
		'string manip to put into an array

		tempstr = mid(line, instr(line, ":")+2)
		arrnames = split(tempstr, ",", -1, 1)

		for i = 0 to ubound(arrnames)

			'write names to text file
			writefile.writeline(trim(arrnames(i)))

		next

	end if		

loop

wscript.echo("hosts written to file...")

writefile.close
readfile.close