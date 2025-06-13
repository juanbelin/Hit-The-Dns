#!/bin/bash 

# Hit-the-Dns Beta, Author @juanbelin

# Global variables
dir_perms=$(ls -ld | awk '{print $1}' | grep w  &> /dev/null)
PID=$$
founds=$(mktemp) 


wordlist="" 
domain=""
ip=""

complete=0
verbose=0

max_threads=12

# Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
endColour="\033[0m\e[0m"

# Functions 
# banner()
# help()
# valid_ip()
# check_complete() 
# ctrl_c()
# dig_query() 
# main()
# semaphore()

function banner() {
echo -e "\n\n"

cat << "EOF"
 █████   █████  ███   █████                                                             
░░███   ░░███  ░░░   ░░███                                                              
 ░███    ░███  ████  ███████                                                            
 ░███████████ ░░███ ░░░███░                                                             
 ░███░░░░░███  ░███   ░███                                                              
 ░███    ░███  ░███   ░███ ███                                                          
 █████   █████ █████  ░░█████                                                           
░░░░░   ░░░░░ ░░░░░    ░░░░░                                                            

              █████    █████                  ██████████   ██████   █████  █████████    
             ░░███    ░░███                  ░░███░░░░███ ░░██████ ░░███  ███░░░░░███   
             ███████   ░███████    ██████     ░███   ░░███ ░███░███ ░███ ░███    ░░░    
            ░░░███░    ░███░░███  ███░░███    ░███    ░███ ░███░░███░███ ░░█████████    
              ░███     ░███ ░███ ░███████     ░███    ░███ ░███ ░░██████  ░░░░░░░░███   
              ░███ ███ ░███ ░███ ░███░░░      ░███    ███  ░███  ░░█████  ███    ░███   
              ░░█████  ████ █████░░██████     ██████████   █████  ░░█████░░█████████    
               ░░░░░  ░░░░ ░░░░░  ░░░░░░     ░░░░░░░░░░   ░░░░░    ░░░░░  ░░░░░░░░░     
EOF

#echo -e "\n\n${purpleColour}>>> (${yellowColour}Made by juanbelin${endColour}) <<< ${blueColour}https://github.com/juanbelin${endColour}${endColour}\n"
}

function help() 
{
  echo -e "\n ${greenColour}[+] Usage:${endColour}"
  echo -e "\t ${blueColour}-d/--domain <domain> -w/--wordlist </path/to/wordlist> -i/--ip <IP>${endColour}"
  echo -e "\t ${blueColour}-v/--verbose = Verbose mode${endColour}"
  echo -e "\t ${blueColour}-h${endColour} --> Show help panel\n\n"
}

function valid_ip() 
{
  [[ $1 =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || { echo -e "${redColour}[!] Invalid IP${endColour}\n\n"; exit 1; }
  for octet in ${1//./ }; do
    ((octet >= 0 && octet <= 255)) || { echo -e "${redColour}[!] Invalid IP range${endColour}\n\n"; exit 1; }
  done
}

banner

function check_complete () 
{
  echo -e "\n\n"

  local current=$(cat $founds | wc -l)

  if [[ "$current" -gt 0 && "$complete" -eq 1 ]]; then
    echo -e "\n${greenColour}[+] Wordlist complete! ($current) subdomains found.${endColour}"
    echo -e "\n${blueColour}Check The +++ ${purpleColour}dns.logs${endColour} +++${endColour}\n\n"
    sleep 1

  elif [[ "$current" -gt 0 && "$complete" -eq 0 ]]; then
    echo -e "\n${yellowColour}[~] Terminated. ($current) subdomains found.${endColour}"
    echo -e "\n${blueColour}Check the +++ ${purpleColour}dns.logs${endColour} +++${endColour}\n\n"
    sleep 1

   elif [[ "$current" -eq 0 && "$complete" -eq 1 ]]; then

    echo -e "\n${redColour}[-] Wordlist completed. No subdomains found.${endColour}\n\n"
    sleep 1

  else 
    echo -e "\n${redColour}[-] Terminated. No subdomains found.${endColour}\n\n"

  fi

  rm -rf $founds 

}


function ctrl_c(){
  echo -e "\n${grayColour}[-] Ctrl + C pressed${endColour}"
  check_complete 1
  sleep 0.5
  echo -e "\n${yellowColour}[*] Exiting...${endColour}\n\n" 
  exit 0 
} 


function dig_query()
{

    local dig_temp=$(mktemp)
    local sub="$1"
    

    if [[ $verbose -eq 1 ]]; then
      echo -e "\n${blueColour}[*] Trying +++ ${purpleColour}$sub${endColour} +++${endColour}"

    fi

    dig $sub.$domain @$ip > "$dig_temp" 2> /dev/null

    if [[ $? -eq 124 || $? -eq 9 ]]; then
      echo -e "\n${redColour}[!] Timeout in ${yellowColour}$sub.${endColour}${endColour}"
      sleep 0.5 
    elif [[ $? -ne 0 && $? -ne 1 ]]; then 
     echo -e "\n${redColour}[!]Unkown error while fuzzing. Forced Exit${endColour}\n\n"
     kill $PID &> /dev/null
    
    fi 
    
    cat $dig_temp | grep -v ';\|SOA' | sed -r '/^\s*$/d' | grep $sub &> /dev/null  

    if [[ $? -eq 0 ]]; then

      echo '.' >> $founds
      echo -e "\n\n${greenColour}[+] Found subdomain: ${purpleColour}$sub${endColour}, added in -- ${grayColour}dns.log${endColour} ---${endColour}\n"
      echo -e "[-] dig axfr $sub.$domain @$ip\n" >> dns.logs
    fi

    rm -f "dig_temp"

}

semaphore() {
  while (( $(jobs -rp | wc -l) >= max_threads )); do
    sleep 0.2
  done
}

# --------------------------- MAIN-----------------------------------

function main()
{

  $dir_perms # Check dir permissions

  if [ $? -eq 1 ]; then
    echo -e "\n${redColour}[!]  This directory seems to not have write permissions (w).${endColour}"
    echo -e "${yellowColour}[*] Run: chmod +w .${endColour}\n\n"
    sleep 2
    exit 1
  fi 

  valid_ip "$ip" # Check IP input

  if [ -f dns.logs ]; then # Check if dns.logs exists 

    echo -e "\n"
    echo -e "\n${yellowColour}[!] dns.logs already exists from previous session. Delete it? [y/n]${endColour}"
    read -r ans

    if [[ "$ans" =~ ^[yY]$ ]]; then # Check user input

      rm -f ./dns.logs 

      if [[ ! -f dns.logs ]]; then

        echo -e "\n${greenColour}[+] dns.logs content succesfully deleted\n${endColour}\n"
        sleep 1
        echo -e "+++ $(date) +++\n\n[+] Next queries to recon:\n" >> dns.logs
      else 
        echo -e "\n${redColour}[!] Could not delete dns.logs${endColour}"
      fi

    elif [[ "$ans" =~ ^[nN]$ ]]; then
      :
    else 
      echo -e "\n${redColour}[!] Invalid option. Exiting...${endColour}\n\n"
      exit 1
    fi
  fi

  tput civis # Remove coursor




  echo -e "${blueColour}\n[*] Checking connectivity with the target...${endColour}"
  sleep 0.8
  dig $domain @$ip &> /dev/null  #Check connectivity with target

  if [[ $? -eq 124 || $? -eq 9 ]]; then
    
    echo -e "\n${redColour}[!] Timeout${endColour}"
    sleep 0.8
    echo -e "\n${yellowColour}[!] Check connectivity with $ip (try manually:${turquoiseColour} dig $domain @$ip)${endColour}${endColour}"
    echo -e "${grayColour}[!] Also check your /etc/hosts file if it is not already added.${endColour}\n\n"
    sleep 1
    exit 1
   

  else 
  echo -e "${greenColour}\n[+] Connection succesful${endColour}\n"

  fi


    echo -e "\n${blueColour}-------- [*] Using${endColour}  ${purpleColour} $wordlist -------- ${endColour}"
    sleep 1
    
    echo -e "+++ $(date) +++\n\n[+] Next queries to recon:\n" >> dns.logs


  while read -r sub; do #Start the fuzzing
    semaphore
    dig_query "$sub" &
  done < "$wordlist"

  tput cnorm

  wait  
 
  complete=1
  check_complete 0
}

trap ctrl_c INT # Ctrl + C

# --------------------------- PARAMETER PARSER -----------------------------------

parameter_counter=0

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -d|--domain)
            domain="$2"; shift 2; ((parameter_counter++))
            ;;
        -w|--wordlist)
            wordlist="$2"; shift 2; ((parameter_counter++))
            ;;
        -i|--ip)
            ip="$2"; shift 2; ((parameter_counter++))
            ;;
        -h|--help)
            help; exit 0
            ;;
        -v|--verbose)
            verbose=1; shift 1
            ;;
        *)
            echo -e "\n${redColour}[!] Invalid parameter: $1${endColour}"
            help
            exit 1
            ;;
    esac
done

if [[ $parameter_counter -eq 3 ]]; then
  main 
else 
  help
  exit 1
fi

