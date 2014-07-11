# cloudalogue

Basic host discovery using facter and queues

Cloudalogue is a small, cross-platform ruby program which leverages
[facter](http://puppetlabs.com/facter) to communicate host information over a
network queue. This can be useful to do dumb host discovery without needing an
"always-on" agent for each node, detecting changes to facts, or just about any
other crazy thing you might want to do with facter and a queue service.

Currently, Cloudalogue uses Amazon's [Simple Queue
Service](http://aws.amazon.com/sqs/), but can be easily extended to support
other networked queues.
