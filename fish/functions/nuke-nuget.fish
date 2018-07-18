function nuke-nuget
	if pwd | grep '/dotfiles/repos' > /dev/null
	        echo 'Removing packages...'
		rm -rf packages

		echo 'Clearing Paket cache...'
		mono .paket/paket.exe clear-cache

		echo 'Clearing NuGet cache...'
		dotnet nuget locals all --clear

		echo 'Removing NuGet...'
		rm -rf ~/.nuget/
	else
		echo 'WARNING: Not in a dotfiles/repos folder'
	end
end

