function watch
    #TODO: Make sleep time configurable
    set -l sleep_duration 2
    set -l run_this $argv
    set -l 
    if test '-t' = "$argv[1]"
        set sleep_duration $argv[2]
        set run_this $argv[3..(count $argv)]
    end
    while true
        #clear
        command $run_this
        sleep $sleep_duration
    end
end
