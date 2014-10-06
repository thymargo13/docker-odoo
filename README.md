docker-openerp
==============

standalone docker container for openerp enabling to test separate data and sources container

Build a data container

```
cd data
docker build -t="openerp/data"
docker run -d --name="mydata" openerp/data echo data creation
```

Then build the Execution container and run it using the data container above
```
cd execution
docker build -t="openerp/execution"
docker run -t -i --volumes-from mydata openerp/execution /bin/bash
```


