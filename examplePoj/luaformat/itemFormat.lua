local function f(allFldName,allTblR)
	local ret = {}
	local itemR = allTblR.item
	local itemW = {}
	for k,v in pairs(itemR) do
		itemW[v.item_id] = v
	end
	ret.item = itemW

	local giftR = allTblR.gift
	local giftW = {}
	for k,v in pairs(giftR) do
		giftW[v.gift_id] = v
	end
	ret.gift = giftW

	local lotteryR = allTblR.lottery
	local lotteryW = {}
	local lotterySum = {}
	for k,v in pairs(lotteryR) do
		local arr = lotteryW[v.lottery_id] or {}
		local sum = lotterySum[v.lottery_id] or 0
		arr[#arr+1] = v
		lotteryW[v.lottery_id] = arr
		sum = sum + v.weight
		lotterySum[v.lottery_id] = sum
	end
	ret.lottery = lotteryW
	ret.lotteryWeightSum = lotterySum

	local shopR = allTblR.shop
	local shop = {}
	for k,v in pairs(shopR) do
		shop[v.shop_id] = v
	end
	ret.shop = shop

	return ret
end

return f
