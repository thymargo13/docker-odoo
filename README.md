docker-openerp
==============

standalone docker container for openerp enabling to test separate data and sources container

Build the initial installation image (this is the long one, the one you do not want to reproduce everytime you change)

```
cd installation
docker build -t="openerp:installation" .
```

Build a data container

```
cd data
docker build -t="openerp/data" .
docker run -d --name="mydata" openerp/data echo data creation
```

Then build the Execution container and run it using the data container above
```
cd execution
docker build -t="openerp/execution" .
docker run -t -i --volumes-from mydata openerp/execution /bin/bash
```


