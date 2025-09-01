class_name HMAC

const HMAC_SECRET_KEY: String = ""


func generate(data: String, timestamp: String) -> String:
	var hmac = HMACContext.new()
	hmac.start(HashingContext.HASH_SHA256, HMAC_SECRET_KEY.to_utf8_buffer())
	hmac.update(data.to_utf8_buffer())
	hmac.update(timestamp.to_utf8_buffer())
	return hmac.finish().hex_encode()
