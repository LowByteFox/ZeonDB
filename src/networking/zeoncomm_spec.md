# ZeonComm communication protocol
Is a communication protocol used by ZeonDB for effective data travel between Zeon and clients

## ZeonFrame
ZeonFrame size is 1024 bytes for each chunk sent<br>
ZeonFrame consists of 

* 1 byte integer declaring status code
* 8 byte integer specifying length of entire buffer sent from client
* XXX bytes of data

If XXX bytes at start is larger than `1024 - 8` then next `ZeonFrame`<br>
is going to contain only buffer data till buffer len matches

> Both `status` and `length` use `little endian`

### Statuses

* 0 => Everything is fine, `length` can be ommited
* 1 => Sending command buffer, `length` is needed for the command length
* 2 => Oops, error occured, `length` is needed for the Error message
* 3 => Auth, this should be sent by the client after public keys were shared, `length` is needed for `<username> <password-sha256>`
* Else => Something f'ed up
