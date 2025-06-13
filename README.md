# Hit-The-Dns

![Logo](assets/img/Logo.png)


**Hit-The-Dns** is a modern DNS recon tool written in bash which will help you during the DNS recon similar to tools like `subfinder` or `dnsenum`.

- [Installation](https://github.com/juanbelin/Hit-The-DnsInstallation##installation)
- [Example Usage](https://github.com/juanbelin/Hit-The-DnsInstallation##example-usage)
	- [DNS Fuzzing](https://github.com/juanbelin/Hit-The-DnsInstallation###dns-fuzzing)
 	- [Dns Fuzzing verbose mode](https://github.com/juanbelin/Hit-The-DnsInstallation###dns-fuzzing-verbose-mode)
 	- [cheking dns.logs and following the next step](https://github.com/juanbelin/Hit-The-DnsInstallation###cheking-dns.logs-and-following-the-next-step)
- [Usage](https://github.com/juanbelin/Hit-The-DnsInstallation##Usage)
- [Hit-The-Dns with Dnsenum comparation](https://github.com/juanbelin/Hit-The-DnsInstallation##Hit-The-Dns-with-Dnsenum-comparation)

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

### cheking dns.logs and following the next step
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

## Hit-The-Dns with Dnsenum comparation

https://github.com/user-attachments/assets/f97bd939-7b29-42bb-829e-be0352a52af1

