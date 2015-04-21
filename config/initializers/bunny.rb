require 'json'


if ENV['VCAP_SERVICES']
    $vcap_services ||= JSON.parse(ENV['VCAP_SERVICES'])
    $rabbit_url = $vcap_services['VCAP_SERVICES']['cloudamqp'][0]['credentials']['uri'] rescue 'amqp://ehbqvfyo:Fj0BXWG6CzXxKg56sF3zpVc-m3os9Xm1@tiger.cloudamqp.com/ehbqvfyo'
else
    $rabbit_url = "amqp://guest:guest@localhost:5672"
end

ENV['RABBITMQ_URL']=$rabbit_url

puts ENV['RABBITMQ_URL']

$conn = Bunny.new
$conn.start

dest = $conn.create_channel
$dyn_queue = dest.queue("hr-app.cfapps.io.employee", :auto_delete => true)
$exch = dest.default_exchange
