#!/bin/bash
 
###############################################
#  V0.6
#  16/02/24
#  Thomas Eeles.
#
#  Script that will autogenerate a complex random password
#  16/07/24
#   - made the passwords more secure,
#   - Added in the -s argument to include special characters.   
#  16/07/24
#   - Simplified the script to default to 16 characters, added -n option for custom length.
#   - Swapped out the old method of creating passwords with OpenSSL
###############################################

######FUNCTIONS########

generate_password(){
    length=$1
    special=$2

    if [ "$special" == "include-special" ]; then
        new_password=$(openssl rand -base64 $(( length * 3 / 4 )) | head -c "$length")
    else
        new_password=$(openssl rand -base64 $(( length * 3 / 4 )) | tr -dc 'A-Za-z0-9' | head -c "$length")
    fi
    echo "$new_password"
    exit 0
}

##### MAIN SCRIPT #####

length=16
special=""

while [ $# -gt 0 ]; do
    case "$1" in
        -n)
            shift
            if [[ $1 =~ ^[0-9]+$ ]]; then
                length=$1
            else
                echo "Error: -n option requires a numerical value."
                exit 1
            fi
            ;;
        -s)
            special="include-special"
            ;;
        -help)
            echo "Password Generator Help"
            echo -e "All passwords will have a mix of alpha and numerical characters by default.\n"
            echo -e "If no option is provided, a 16 character password will be generated.\n"
            echo -e "-n <number> will generate a password of the specified length.\n"
            echo -e "-s will include special characters in the password.\n"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -help for usage information."
            exit 1
            ;;
    esac
    shift
done

generate_password "$length" "$special"
