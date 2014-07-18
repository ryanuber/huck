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

```ruby
$ gem install huck
```
