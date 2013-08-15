# Rabbit Poll

A very minimal Dynamo application used to fetch queue statistics from RabbitMQ.

## Installation

Check out this repository on a server running RabbitMQ,
and run the application like this:

    $ mix server

Or run it in production mode:

    $ MIX_ENV=prod mix do compile, server

Then send a HTTP GET request to fetch the statistics:

    $ wget http://0.0.0.0:4000/vhost/queue

This returns a JSON object:

    {"queue-name":["3","6","9"]}

Whereby the first number is the messages ready, the second number the messages unacknowledged and the last one the total number of messages.

The statistics are fetched with the following command:

    $ rabbitmqctl list_queues -p /vhost name messages_ready messages_unacknowledged messages

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
