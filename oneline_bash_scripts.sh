: ' Example1: Read a file containing a list of hosts, ssh to each host and execute a command on each host'
for host in $(cat my_file_hosts.txt); do ssh -o "StrictHostKeyChecking no" $host "echo $host;sudo su - command_to_execute_on_each_host"; done

: ' Example2: Read a file with list of host, on each host (ssh and disable puppet agent -> move a my.service file -> systemd to reload units from disk -> execute status command for my service)'
for host in $(cat my_host_list.txt); do ssh -o "StrictHostKeyChecking no" $host "echo $host; sudo puppet agent --disable;sudo mv /etc/systemd/system/my.service /etc/systemd/system/my.service_orig; sudo systemctl daemon-reload;sudo su 'my_service status'"; done

: ' Example3: for each directory in current, cd to each directory, cd main, execute git restore'
for d in ./ ; do echo "$d"; cd $d; cd main; git restore .; cd ..; cd qa; git restore .;cd ..; cd ..; done

: ' Example4: for each directory in current, cd to each directory, copy recursively from ~/dir1/ to current directory '
for d in ./ ; do echo "$d"; cd $d; cp -r ~/dir1/ .; cd ..; done

: 'Example5: 
git log --all -> Scans commit history across all branches.
--format="%ae%n%ce" -> Extracts both:
%ae -> Author email 
%ce -> Committer email
"%ae%n%ce" -> ensures one email per line (with a newline %n between values).
sort -u -> Sorts all email addresses and removes duplicates (-u = unique).
grep -v '@xyz.com$' ->Filters out (-v = inverse match) any emails ending with @xyz.com.
> old_mailmap.txt ->Redirects output to old_mailmap.txt.'

git log --all --format="%ae%n%ce" | sort -u | grep -v '@xyz.com$' > old_mailmap.txt

: 'Example6: command processes old_mailmap.txt and generates new_mailmap.txt by appending a company email (@xyz.com) to each entry that doesn’t already contain an @ symbol'
awk '!/@/{printf("%s <%s@xyz.com> %s\n",$0,$0,$0)}' old_mailmap.txt > new_mailmap.txt

