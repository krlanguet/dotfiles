# Load user-specific programs including rust programs
set -U fish_user_paths $HOME/.cargo/bin $HOME/.local/bin

# Prefered editor
set -gx EDITOR k

# Set hostname for fish prompt prefix
set -U prompt_hostname WSL

# Remove fish greeting
set fish_greeting
 
# Start kakoune daemon for faster file loads and shared registers
set --local running_servers (kak -l)
if [ $running_servers ]
    for server in $running_servers
        switch $server
        case "default (dead)"
            echo "Restarting dead Kakoune server 'default'"
            rm /tmp/kakoune/keith/default
            command kak -d -s default
        case "default"
            echo "Kakoune server 'default' already running"
        case "*"
            echo "Starting Kakoune server 'default'"
            command kak -d -s default
        end   
    end
else
    echo "Starting Kakoune server 'default'"
    command kak -d -s default
end
