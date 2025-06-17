<h1 align="center"> Hit-The-Dns (Beta)</h1>

<p align="center">
  <img src="assets/img/Logo.png" alt="Logo" width="300"/>
</p>


**Hit-The-Dns** is a modern open-source DNS recon tool written in bash which will help you during the DNS recon similar to tools like `subfinder` or `dnsenum`.

- [Installation](#installation)
- [Example Usage](#example-usage)
  - [DNS Fuzzing](#dns-fuzzing)
  - [Verbose Mode](#dns-fuzzing-verbose-mode)
  - [Analyzing dns.logs](#checking-dnslogs-and-following-the-next-step)
- [Usage](#usage)
- [Comparison with Dnsenum](#hit-the-dns-with-dnsenum-comparation)
- [License](#license)

## Installation 
```
wget https://raw.githubusercontent.com/juanbelin/Hit-The-Dns/refs/heads/main/hit-the-dns.sh
```

```
chmod +x hit-the-dns.sh
```

## Example Usage
> [!NOTE]
> This example was done using [Attacking DNS Lab from HTB Academy](https://academy.hackthebox.com/module/116/section/1512).

### DNS Fuzzing 
```
./hit-the-dns -d inlanefreight.htb -i 10.129.203.6 -w ~/seclists/Discovery/DNS/subdomains-top1million-110000.txt
```

https://github.com/user-attachments/assets/fa2420e5-3267-4568-bfa3-fc597894c4ba


### DNS Fuzzing verbose mode  
`-v` or `--verbose` in order to view fuzzing attempts.

```
./hit-the-dns -d test.com -i 10.129.203.6 -w ~/seclists/Discovery/DNS/subdomains-top1million-110000.txt -v
```

### Checking dns.logs and following the next step
The **dns.logs** file will give you the next step in the recon (zone transfer attack) according with the subdmains that the tool has found during the fuzzing.



https://github.com/user-attachments/assets/5878ce49-a2e9-44aa-9bd7-5e5bfa3419fa



![image](https://github.com/user-attachments/assets/257d4d61-3936-43cd-bfc2-0b0cc1990872)

![image](https://github.com/user-attachments/assets/568ac592-3c0f-4b06-bcbe-be5f4c952a96)



## Usage 

```
./hit-the-dns -d domain.com -i 10.10.2.15 -w /path/to/wordlist.txt <-v>
```

```
./hit-the-dns.sh



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

 [+] Usage:
	-d/--domain <domain> -w/--wordlist </path/to/wordlist> -i/--ip <IP>
	-v/--verbose = Verbose mode
	-h --> Show help panel
```

> [!IMPORTANT]
> Do not forget adding the domain to the `/etc/hosts` file
> `nano /etc/hosts` and add a new line which contains '10.10.2.1 domain.com'


## Hit-The-Dns with Dnsenum comparation
Some tools such as dnsemun does not always find the subdomains even if they exist in the DNS because of the way it implements threads and filters.

https://github.com/user-attachments/assets/f97bd939-7b29-42bb-829e-be0352a52af1

<p align="center">
  <img width="250" src="https://github.com/user-attachments/assets/159cf532-f0db-4101-b634-a3861c10ccc2"
</p>

## License
> © 2025 juanbelin. All rights reserved.
