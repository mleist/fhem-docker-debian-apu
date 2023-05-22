# fhem-docker-debian-apu

**Experience level: Advanced**



## build stage0 VM

- create Image with 4 GB RAM , 4 CPUs, 20 GB HD, UEFI-Boot: 'fhem_stage0.vmwarevm'
- boot from debian-bookworm-DI-rc3-amd64-netinst.iso
- [Advanced options ...] -> [... Automated install] -> Key 'E' & add:
  > ... auto=true url=https://raw.githubusercontent.com/mleist/fhem-docker-debian-apu/ipu/stage0_img_builder/preseed.txt ...
- Press F10
- wait for installed system

**Attention: for my work I have injected my ssh-key into the Stage0 system**



## login into stage0 VM

- username: root
- password: r00tme



## create stage1 ISO image

    root@debian:~# /bin/sh -c "cd /opt; git clone --branch ipu git@github.com:mleist/fhem-docker-debian-apu.git"
    root@debian:~# cd /opt/fhem-docker-debian-apu/stage1_apu_iso_builder/
    root@debian:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# ./build ipu64 --force-root

    /opt/fhem-docker-debian-apu/stage1_apu_iso_builder/images/debian-11-amd64-CD-1.iso
    root@debian:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# ls -l images/
    total 329736
    -rw-r--r-- 1 root root 337641472 Aug 26 11:26 debian-11-amd64-CD-1.iso
    -rw-r--r-- 1 root root      4945 Aug 26 11:26 debian-11-amd64-CD-1.list.gz



## build USB stick for IPU

insert USB stick

    root@stage0tmp:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# fdisk -l /dev/sdb
    Disk /dev/sdb: 14.92 GiB, 16025387008 bytes, 31299584 sectors
    Disk model: USB Flash Disk
    [...]

copy ISO image to USB stick

**Check three times if the unit address is correct**

    root@stage0tmp:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# dd if=images/debian-11-amd64-CD-1.iso of=/dev/sdb bs=16M
    20+1 records in
    20+1 records out
    337641472 bytes (338 MB, 322 MiB) copied, 52.4693 s, 6.4 MB/s
    root@stage0tmp:/opt/fhem-docker-debian-apu/stage1_apu_iso_builder# sync

Remove the USB stick and continue with stage2



## install the IPU in stage2


    SeaBIOS (version rel-1.12.1.3-0-g300e8b70)

    Press F10 key now for boot menu, N for PXE boot

F10 pressed

    Select boot device:

    1. iPXE
    2. USB MSC Drive General USB Flash Disk 1.00
    3. AHCI/0: SATA SSD ATA-10 Hard-Disk (15272 MiBytes)
    4. Payload [setup]
    5. Payload [memtest]

2 pressed

...

    ┌─────────────────────┤ Installing the base system ├──────────────────────┐
    │                                                                         │
    │                                   19%                                   │
    │                                                                         │
    │ ...running...                                                           │
    │                                                                         │
    └─────────────────────────────────────────────────────────────────────────┘

... wait for installed system

    Sent SIGKILL to all processesystem...
    Requesting system poweroff
    [ 1012.008340] reboot: Power down

stage2 done

## first start IPU

      Booting `Debian GNU/Linux'
    
    Loading Linux 5.10.0-8-amd64 ...
    Loading initial ramdisk ...
    /dev/sda5: clean, 32110/3653632 files, 679036/14599168 blocks
    
    Debian GNU/Linux 11 {hostname} ttyS0
    
    {hostname} login: 

## login into IPU

- username: root
- password: passw0rd

start "./first_boot.sh"

    {hostname} login: root
    Password: 
    Linux {hostname} 5.10.0-8-amd64 #1 SMP Debian 5.10.46-4 (2021-08-03) x86_64
    
    The programs included with the Debian GNU/Linux system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.
    
    Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
    permitted by applicable law.
    root@{hostname}:~# ./first_boot.sh 
    This is the first boot
    Cloning into 'fhem-docker-debian-apu'...
    remote: Enumerating objects: 124, done.
    [...]
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    All packages are up to date.
    [...]
    Reading package lists... Done
    Building dependency tree... Done
    root@{hostname}:~# 



## install docker infrastructre


### change username, passwords etc.

    root@{hostname}:~# cd /opt/fhem-docker-debian-apu/
    root@{hostname}:/opt/fhem-docker-debian-apu# 
    root@{hostname}:/opt/fhem-docker-debian-apu# vi .env


### 31_start_container_4_install.sh

    root@{hostname}:/opt/fhem-docker-debian-apu# ./stage3_postinstall_apu/31_start_container_4_install.sh
    Creating network "fhem-docker-debian-apu_fhem-network" with driver "bridge"
    Creating network "fhem-docker-debian-apu_default" with the default driver
    Pulling fhem (fhem/fhem:latest)...
    latest: Pulling from fhem/fhem
    [...]
    Status: Downloaded newer image for fhem/fhem:latest
    Pulling infl (influxdb:latest)...
    latest: Pulling from library/influxdb
    [...]
    Status: Downloaded newer image for influxdb:latest
    Pulling grfn (grafana/grafana:latest)...
    latest: Pulling from grafana/grafana
    [...]
    Status: Downloaded newer image for grafana/grafana:latest
    Pulling tgrf (telegraf:alpine)...
    alpine: Pulling from library/telegraf
    [...]
    Status: Downloaded newer image for telegraf:alpine
    Pulling brdg (oznu/homebridge:latest)...
    latest: Pulling from oznu/homebridge
    [...]
    Status: Downloaded newer image for oznu/homebridge:latest
    Creating fhem-docker-debian-apu_infl_1 ... done
    Creating fhem-docker-debian-apu_fhem_1 ... done
    Creating fhem-docker-debian-apu_brdg_1 ... done
    Creating fhem-docker-debian-apu_grfn_1 ... done
    Creating fhem-docker-debian-apu_tgrf_1 ... done
    root@{hostname}:/opt/fhem-docker-debian-apu# 

**wait**

After the installation is complete, the Influxdb container will have terminated.

### 32_finalize_influxdb.sh

    root@{hostname}:/opt/fhem-docker-debian-apu# stage3_postinstall_apu/32_finalize_influxdb.sh
    fhem-docker-debian-apu_infl_1 is up-to-date

**wait**

    root@{hostname}:/opt/fhem-docker-debian-apu# docker-compose exec infl influx org list
    ID			Name
    3810ea878cd66587	fhem_org


### 41_config_influxdb.sh
    root@{hostname}:/opt/fhem-docker-debian-apu# stage3_postinstall_apu/41_config_influxdb.sh
    starting 41_config_influxdb.sh ...
    creating buckets
    ID			Name		Retention	Shard group duration	Organization ID
    cfe7a9c3106b511b	fhem_fast	72h0m0s		24h0m0s			3810ea878cd66587
    ID			Name		Retention	Shard group duration	Organization ID
    b37766d36f6149f4	fhem_mid	1344h0m0s	24h0m0s			3810ea878cd66587
    ID			Name		Retention	Shard group duration	Organization ID
    90dafd08b131117f	_monitoring	168h0m0s	24h0m0s			3810ea878cd66587
    d7a8c52d24ca6f61	_tasks		72h0m0s		24h0m0s			3810ea878cd66587
    cfe7a9c3106b511b	fhem_fast	72h0m0s		24h0m0s			3810ea878cd66587
    60192763cc01c033	fhem_long	87360h0m0s	168h0m0s		3810ea878cd66587
    b37766d36f6149f4	fhem_mid	1344h0m0s	24h0m0s			3810ea878cd66587
    41_config_influxdb.sh exit

