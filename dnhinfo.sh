echo -e "\nOS"
lsb_release -a
echo -e "\nMemory"
cat /proc/meminfo
echo -e "\nCPU"
lscpu
