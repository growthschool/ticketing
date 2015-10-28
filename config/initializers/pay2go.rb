Pay2go.setup do |pay2go|
  pay2go.merchant_id = Figaro.env.pay2go_merchant_id
  pay2go.hash_key    = Figaro.env.pay2go_hash_key
  pay2go.hash_iv     = Figaro.env.pay2go_hash_iv
end