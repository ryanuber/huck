# Huck

Huck is a small, cross-platform Ruby application to make sharing information in
a cluster easy.

Huck's current intended functionality is:

* Generate some information using an external program
  ([facter](https://projects.puppetlabs.com/projects/facter) /
  [ohai](http://docs.opscode.com/ohai.html) supported)
  currently)
* Serialize and submit the information to a messaging queue
  ([Amazon SQS](http://aws.amazon.com/sqs/) currently supported)
* Daemon process to read information from the queue and execute something for
  each received message

Extensibility is a major design goal in Huck. If you can generate some hash data
in ruby, you can make a new Huck data generator. If you can connect to a
different queueing service, you can make a new data sender/receiver, etc.

# Roadmap

* RabbitMQ support
