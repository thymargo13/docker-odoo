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

copy the sources and put them inside a source container.

Use the openerp/sources Dockerfile
Copy it in the directory where your sources are
inside the file, rename the COPY instruction first argument with your source directory name

run 
```
docker build -t="openerp/sources" . 
docker run -d --name="mysources" openerp/sources echo sources init
```


Then build the Execution container and run it using the data container above
hostame to be set to work with the right configuration file
```
cd execution
docker build -t="openerp/execution" .
docker run -t -i -p 8069:8069 --hostname=odoocontainer --name="openerp" --volumes-from mydata --volumes-from mysources openerp/execution /bin/bash
```

## A few how tos

Once the execution container has been run, you can access openerp from your browser going to `localhost:8069`

Do not `exit` from the container shell as it gives you a view on what is going on. If you want to stop it, prefer `docker stop openerp` from another terminal. When you want to start it again :

```
docker start openerp
docker attach openerp
```
sends you back inside the container main shell



