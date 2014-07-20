---
layout: default
title: Huck
---

<div class="landing">
Meet Huck, a one-way communication framework for registering things.
</div>

Huck is a small concept and framework for registering nodes, applications, and
other things using a message queue. It is extensible, light-weight, and
flexible. Huck can be run as a daemon using the CLI, or plugged into from other
Ruby applications.

Huck is composed of a server and many clients. The server machine will poll a
queue for messages, and execute configured handler(s) upon receipt of a message.
Clients can submit messages ad-hoc, and do not require any long-lived process to
be running.

<table class="center">
	<tr>
		<td><span class="title">Message Queues</span></td>
		<td><span class="title">Data Generators</span></td>
		<td><span class="title">Message Handlers</span></td>
	</tr>
	<tr>
		<td>
			<ul>
				<li>Amazon SQS</li>
				<li>RabbitMQ</li>
			</ul>
		</td>
		<td>
			<ul>
				<li>Facter</li>
				<li>Ohai</li>
				<li>File reader</li>
				<li>Command execution</li>
				<li>stdin</li>
			</ul>
		</td>
        <td>
            <ul>
                <li>Command execution</li>
                <li>Ruby blocks</li>
            </ul>
        </td>
	</tr>
</table>

Many things can be accomplished using Huck. It is intended to solidify a
practice that many are likely implementing in their own "one-off" scripts, and
builds on top of proven message bus systems to deliver a reliable experience.

Huck is written in ruby, and lives on
[GitHub](https://github.com/ryanuber/huck).

# Installing

Huck's core is a single gem with a short list of dependencies. To install it,
run the following command:

```ruby
$ gem install huck
```

You will also need to have your message bus' gem installed, which would be
`aws-sdk` for Amazon SQS, or `bunny` for RabbitMQ. Huck does not pull these in
automatically to avoid forcing you to install both.

Similarly, if you wish to use Facter or Ohai, you should have those gems
installed. This is not required, as there are providers which do not require any
external gems (such as the `file` or `exec` handlers).

# Configuring

Huck accepts configuration in two different ways based on how you are using it:
either from a YAML config file, or from a ruby hash if you are using the
library.

You can see all available configuration options in the
[sample config](https://github.com/ryanuber/huck/blob/master/huck.conf.sample).
A minimal configuration might look something like the following:

### Client

```
sender: sqs
sqs: { queue_name: myqueue }
generators:
  - stdin
```

### Server

```
receiver: sqs
sqs: { queue_name: myqueue }
handlers:
  - exec: { command: cat >> /var/log/nodeinfo.log }
```

In this example, the client will submit anything piped into the `huck run`
command, and the server will dump it into a log file. As more clients run, you
would see lines being appended to the log file on the server machine.

Running the following command on the client would submit data into the stdin
generator:

```
$ echo "$(hostname): $(uname)" | huck run
```

# Running

Starting Huck from the command line is the quickest way to get going. Included
with the gem is a small CLI wrapper you can use to launch both the server and
the client.

```bash
# Start a server
huck serve

# Run the client
huck run
```

By default, Huck looks in `~/huck.conf` for configuration. You can pass an
alternate path for both the server and client using the `-c <path>` option.

The client and server may also be run by importing the gem into other ruby
programs. See the readme for usage.

# Use cases

A few things one might want to do with Huck are:

* Add hosts into a monitoring system
* Create entries for hosts in DNS
* Register a new endpoint to an API proxy
* Add nodes to a load balancer
* Send call-backs for asynchronous tasks
* Submit state to a centralized orchestrator

# Roadmap

* Support message tagging and allow handlers to run based on tags
