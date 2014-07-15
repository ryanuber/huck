# Huck

Huck is a small, cross-platform Ruby application to make sharing information in
a cluster easy.

Huck's current intended functionality is:

* Generate some information using an external program
  ([facter](https://projects.puppetlabs.com/projects/facter) /
  [ohai](http://docs.opscode.com/ohai.html) and JSON or YAML files
  currently supported)
* Serialize and submit the information to a messaging queue
  ([Amazon SQS](http://aws.amazon.com/sqs/) currently supported)
* Daemon process to read information from the queue and execute something for
  each received message

Extensibility is a major design goal in Huck. If you can generate some hash data
in ruby, you can make a new Huck data generator. If you can connect to a
different queueing service, you can make a new data sender/receiver, and if you
have a function that handles a string argument, you can make a new handler.

# Using

This gem ships with a command-line interface to make things easy. You can run
them like this:

Start a server:
```
$ huck serve
```

Run the client once:
```
$ huck run
```

Take a look at the [config example](huck.conf.sample) to get an idea of how to
configure Huck for your environment.

If you don't want to put your config in `~/huck.conf` (the default), you may
pass the `-c` command-line option to both the client and server to specify a
different place.

# Roadmap

* RabbitMQ support
* Support multiple handlers per message

# Acknowledgements

Concept and prototypes brewed with @xorl
