function nuke-nuget
    if pwd | grep '/repos' > /dev/null
        if ls -al | grep '\packages' > /dev/null
            echo 'Removing packages...'
            rm -rf packages
        end

        if ls -al | grep '\.paket' > /dev/null
            echo 'Clearing Paket cache...'
            mono .paket/paket.exe clear-cache
        end

        if ls -al | grep '\paket-files' > /dev/null
            echo 'Removing paket-files...'
            rm -rf paket-files
        end

        if ls -al | grep '\.fake' > /dev/null
            echo 'Removing .fake folder...'
            rm -rf .fake
        end

        if ls -al | grep '\.vs' > /dev/null
            echo 'Removing .vs folder...'
            rm -rf .vs
        end

        echo 'Clearing NuGet cache...'
        dotnet nuget locals all --clear

        if ls -al ~ | grep '\.nuget' > /dev/null
            echo 'Removing NuGet...'
            rm -rf ~/.nuget/
        end

        find . -type d -regextype posix-extended -regex ".*/(bin|obj)" ! -regex '\./node_modules/.*' -prune -exec echo "Preparing to delete {}" \;
        find . -type d -regextype posix-extended -regex ".*/(bin|obj)" ! -regex '\./node_modules/.*' -prune -exec rm -rf "{}" +

        echo 'DONE: You got rid of all NuGet cruft!'
    else
        echo 'WARNING: Not in a /repos folder'
    end
end
