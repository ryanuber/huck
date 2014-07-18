---
layout: default
title: Huck
---

<div class="landing">
Meet Huck, a one-way communication framework for registering things.
</div>

Huck is a small concept and framework for registering nodes, applications, and
other things using a message queue. It is highly extensible, light-weight, and
flexible. It can be run as a daemon using the CLI, or plugged into from other
Ruby applications.

<table>
	<tr>
		<td><span class="title">Supported Message Queues</span></td>
		<td><span class="title">Supported Data Generators</span></td>
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
				<li>File Reader</li>
				<li>Command Execution</li>
			</ul>
		</td>
	</tr>
</table>

```ruby
Huck.serve do |msg|
  puts "received message: #{msg}"
end
```
