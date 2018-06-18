args = "fish -l -c ""terminator --working-directory=~"""
WScript.CreateObject("Shell.Application").ShellExecute "wsl.exe", args, "", "open", 0