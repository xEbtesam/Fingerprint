function NR = normalizeImRange(XX)

mnxo = 0;
mxxo = 255;

mnx = min(min(XX(:)));
mxx = max(max(XX(:)));

NR   = mnxo + (mxxo-mnxo)*((XX-mnx)/(mxx-mnx));

end

