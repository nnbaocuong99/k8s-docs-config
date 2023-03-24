<h1 align="center"> Usage guide - setup node k8s </h1> 

---

## 1. Request server:
### <ins>Request server to System with the informations included below:</ins>
- *CPUs:*
- *RAM capacity:*
- *OS partition storage capacity:*
- *Data partition storage capacity:*
- *IP range of the server assigned to the project:*
- *SSH user granted Sudo privileges*
- *Things needs to be checked after receiving the server:*
- *Compared to the request to the server specifications *
- *SSH User:*
- *Installed OS and version:*
- *Docker*

### <ins>Warning:</ins>
#### *You must change your server name similar to the name you use to join the node: `root@name-nodexx`*

*In this case:*
- `name`: name of the project you wanna use, for example: mpos, payment, etc...
- `xx`: cardinal numbers of the node
> - Optional: Cài đặt Docker


---


## 2. Join server as a worker node of the k8s cluster
### <ins>Basic requirement informations configuration:</ins>
#### *✏️ 1. Config Docker*

- Run `crontab -e` and then comment comment: `@reboot sleep 60 && mkdir /data/docker-run -p`

- Delete `/var/lib/docker`
```
$ rm -rf /var/lib/docker
```

- Create folder `/data/docker` 
```
$ mkdir /data/docker
```

- Create symbolic link `/data/docker to /var/lib`
```
$ ln -s /data/docker /var/lib
```

- Create a file name it `daemon.json` then use the content below:
```
$ vi /etc/docker/daemon.json

#config
{
"log-driver": "json-file",
"log-opts": {
    "max-size": "100m",
    "max-file": "2"
    }
}
```

- Restart Docker: 
```
$ Systemctl restart docker
```


#### *✏️ 2. Create LVM Disk data:*
- Create a `PersistentVolume`: 
```
$ pvcreate /dev/disk-name
```

- Create volume group: 
```
$ vgcreate vg-name /dev/disk-name
```

- Create logical volume: 
```
$ lvcreate -L size -n lv-name vg-name
```

- Format logical volume to `ext4`: 
```
$ mkfs.ext4 /dev/vg-name/lv-name
```

- Mount logical vomune to `/data`:
```
$ mount /dev/vg-name/lv-name /data
```

- Mount dynamic logical vomune to `/data`:
  - check id lv: `$ blkid`
  - add dynamic mount: `$ vi /etc/fstab -> UUID=lv-uuid /data ext4 defaults 0 0`



#### *✏️ 3. Join node to cluster:*
- Run the command to join the node from Rancher
- config Tains (optional) for node when the active mode of the node successfully enabled

---

Congrats! you're all set

Thanks for Reading!

