# systemd-builder
Shell script to make simple systemd service and add it to your system

## Run:

Here is the fastest way to run the script:

```shell
# Get sample.service | If you already have curl or wget there is a good chance that sysd-builder.sh will get this file for you by itself
curl https://raw.githubusercontent.com/sepehr-gh/systemd-builder/main/sample.service > sample.service
```

```shell
# Run script
bash <(curl -s https://raw.githubusercontent.com/sepehr-gh/systemd-builder/main/sysd-builder.sh)
```

## Notice
You may need to escape some special characters such as **&** and enter them like: `\\&`