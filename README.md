# Huck

Huck is a small, cross-platform Ruby application to make sharing information
about hosts, applications, or anything else easy between machines on a network.

Huck's current intended functionality is:

* Generate some information about a host using something like
  [facter](https://projects.puppetlabs.com/projects/facter) or
  [ohai](http://docs.opscode.com/ohai.html)
* Serialize and submit the information to a messaging queue
* Daemon process to read information from the queue and execute something for
  each received message

Extensibility is a major design goal in Huck. If you can generate some data
in ruby, you can make a new Huck data generator. If you can connect to a
different queueing service, you can make a new data sender/receiver, and if you
have a function that handles a string argument, you can make a new handler.

# Concepts

### Generators

These generate information on client machines to submit into a queue for a
server machine to read. Huck ships with receivers for Ohai and Facter, as well
as a few simple generators to read files, collect hostname and platform
information, or execute arbitrary scripts.

### Senders

These run on clients and submit generated data into a queue. They use a generic
interface so that more messaging systems may be added on later. Currently
[Amazon SQS](http://aws.amazon.com/sqs/) (default) and
[RabbitMQ](http://www.rabbitmq.com) are supported.

### Receivers

These poll messages out from a queue for processing, and also use a generic
interface to support more messaging systems. Currently
[Amazon SQS](http://aws.amazon.com/sqs/) (default) and
[RabbitMQ](http://www.rabbitmq.com) are supported.

### Handlers

Handlers run on Huck servers and take action based on received messages. They
are arbitrary pieces of code which parse messages and then make other calls
using the data. Huck ships with two handlers: `echo` (for demo/debugging
purposes), and `exec`, which invokes an arbitrary script on the filesystem and
passes data in via stdin, and satisfies most use cases for Huck.

# Installing
```
$ gem install huck
$ gem install aws-sdk  # if you want to use SQS
$ gem install bunny    # if you want to use RabbitMQ
$ gem install facter   # if you want to use Facter
$ gem install ohai     # if you want to use Ohai
```

**NOTE**
Huck does not depend directly on provider-related gems to avoid installing them
on every machine.

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

## As a library

You may wish to use Huck as a library instead of using its CLI. You can run the
Huck server with the following code:
```ruby
Huck.serve
```

While using Huck as a library, it is possible to pass arbitrary code blocks to
use as message handlers. This looks something like:
```ruby
Huck.serve do |msg|
  puts msg
end
```

The client can also be used from the library easily.
```ruby
Huck.run
```

The `run` method can accept a block, very similar to the `serve` method.
```ruby
Huck.run do
  "This is a test message"
end
```

Both `serve` and `run` will accept a `:config_file` option to specify the
config path. It is also possible to pass the configuration in as a hash using
the `:config` option.

# Acknowledgements

Concept and prototypes brewed with [@xorl](https://github.com/xorl)
