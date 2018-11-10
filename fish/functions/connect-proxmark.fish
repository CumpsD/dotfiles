function connect-proxmark
        if ls -al | grep '\proxmark3$' > /dev/null
		sudo chmod 666 $argv; ./proxmark3 $argv
	else
		echo 'Please execute \'connect-proxmark /dev/ttyS3\' in the proxmark3 client directory'
	end
end
