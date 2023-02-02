#!/usr/bin/env bash

# Store the target IP range or hostnames in a variable
target=$1

# Scan the target using nmap
nmap -v -sn $target -oA nmap_passive_recon

# Filter out the live hosts from the scan results
grep "Status: Up" nmap_passive_recon.gnmap | cut -d " " -f 2 > live_hosts.txt

# Get the open ports and services information for each live host
for host in $(cat live_hosts.txt); do
    nmap -v -Pn -A $host -oA $host-recon
done

# Clean up the intermediate files
rm nmap_passive_recon.gnmap live_hosts.txt