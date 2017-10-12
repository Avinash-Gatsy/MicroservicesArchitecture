require 'thrift' 
$:.push('gen-rb') 
require 'can_levels'
begin
	trans_ep = Thrift::Socket.new(ARGV[0], ARGV[1]) 
	trans_buf = Thrift::BufferedTransport.new(trans_ep) 
	proto = Thrift::BinaryProtocol.new(trans_buf) 
	client = CanLevels::Client.new(proto)
	trans_ep.open()
	client.update_can_level(42, 0.85) 
	client.update_can_level(57, 0.89)
	res = client.get_cans_above_threshold(0.8) 
	puts '[Client] received: ' + res.count.to_s 
	puts res.inspect
	trans_ep.close()
rescue Thrift::Exception => tx
	print 'Thrift::Exception: ', tx.message, "\n"
end
