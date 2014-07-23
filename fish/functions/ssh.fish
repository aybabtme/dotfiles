function tvpn
    ssh -p 443 antoine@vpn.antoine.im -t tmux a
end

function vpn
    sh -ND 12345 -p 443 antoine@vpn.antoine.im
end
