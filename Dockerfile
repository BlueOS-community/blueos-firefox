FROM lscr.io/linuxserver/firefox:101.0.1

RUN apk update && apk add nginx

# Move our nginx configuration to the standard nginx path
COPY files/nginx.conf /etc/nginx/nginx.conf

# Add our static files to a common folder to be provided by nginx
RUN mkdir -p /site
COPY files/register_service /site/register_service

# Copy everything for your application
COPY files/entrypoint.sh /entrypoint.sh

RUN rm /defaults/autostart

# Add docker configuration
LABEL permissions='{\
  "ExposedPorts": {\
    "80/tcp": {}\
  },\
  "HostConfig": {\
    "PortBindings": {\
      "80/tcp": [\
        {\
          "HostPort": ""\
        }\
      ]\
    },\
    "Binds": [\
      "/dev:/dev:rw"\
    ],\
    "Privileged": true\
  },\
  "Env": [\
    "PUID=1000",\
    "PGID=1000",\
    "TZ=Etc/UTC"\
  ]\
}'
LABEL authors='[\
    {\
        "name": "John Doe",\
        "email": "john.doe@gmail.com"\
    }\
]'
LABEL company='{\
    "about": "This is just an example",\
    "name": "ACME Corporation",\
    "email": "acme@corporation.com"\
}'
LABEL readme="https://raw.githubusercontent.com/patrickelectric/blueos-extension-template/master/README.md"
LABEL type="example"
LABEL tags='[\
  "example"\
]'

ENTRYPOINT ["/entrypoint.sh"]