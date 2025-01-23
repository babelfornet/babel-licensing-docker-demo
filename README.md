# Babel Licensing Docker Demo

The Babel Licensing Docker Demo is a set of files designed to showcase the capabilities of Babel Licensing Service when integrated with a WordPress site.

> NOTE: To run this demo please request application files at sales@babelfor.net

See project [Wiki](https://github.com/babelfornet/babel-licensing-docker-demo/wiki) page for detailed instructions.

### Startup

1. Copy application files and the license file _babel.licenses_ inside this folder.

2. Start Docker Compose

```
docker-compose up -d
```

### Shutdown

```
docker-compose down
```

Shutdown and delete all volumes (restart from scratch)

```
docker-compose down -v
```