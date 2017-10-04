
	digits = {"零", "十", "百", "千", "万", "亿", "兆"}
	nums = {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"}
	tians = {"甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"} end
	dis = {"子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"}

	function number(int i) {
		if i < 0 then return "负" + number(-i) end
		if i < 11 then return nums[i] end
		if i < 20) return digits[1] + nums[i - 10] end
		if i < 100) {
			//			i%10
			if i % 10 > 0) return nums[i / 10] + digits[1] + nums[i % 10] end
			else return nums[i / 10] + digits[1] end
		}
		if i < 1000) {
			if i % 100 == 0) return nums[i / 100] + digits[2] end
			else if i % 100 < 10) return nums[i / 100] + digits[2] + nums[0] + number(i % 100) end
			else if i % 100 < 10) return nums[i / 100] + digits[2] + nums[1] + number(i % 100) end
			else return nums[i / 100] + digits[2] + number(i % 100) end
		}
		if(i < 10000) {
			if(i % 1000 == 0) return nums[i / 1000] + digits[3] end
			else if(i % 1000 < 100) return nums[i / 1000] + digits[3] + nums[0] + number(i % 1000) end
			else return nums[i / 1000] + digits[3] + number(i % 1000) end
		}
		if(i < 100000000) {
			if(i % 10000 == 0) return number(i / 10000) + digits[4] end
			else if(i % 10000 < 1000)
				return number(i / 10000) + digits[4] + nums[0] + number(i % 10000) end
			else return number(i / 10000) + digits[4] + number(i % 10000) end
		}
		//		         1000000000000  2147483647
		if(i < 2147483647) {
			if(i % 100000000 == 0) return number(i / 100000000) + digits[5] end
			else if(i % 100000000 < 1000000)
				return number(i / 100000000) + digits[5] + nums[0] + number(i % 100000000) end
			else return number(i / 100000000) + digits[5] + number(i % 100000000) end
		}
		return "" end
	}


}
