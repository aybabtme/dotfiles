function vector
docker run -i -v (pwd)/:/etc/vector/ --rm timberio/vector:0.38.0-debian $argv[1..-1]
end
