function nuke-nuget
        rm -rf packages; .paket/paket.exe clear-cache; dotnet nuget locals all --clear; rm -rf ~/.nuget/
end

