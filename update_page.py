#!/usr/bin/env python3
"""
更新日本旅行计划页面
1. 价格格式：¥xxx (约¥xx人民币)
2. 每餐改为3家不同口味餐厅选择
"""

import re

# 汇率：1日元 = 0.0526人民币 (约1:19)
EXCHANGE_RATE = 0.0526

def yen_to_rmb(yen_str):
    """将日元转换为人民币"""
    # 提取数字
    numbers = re.findall(r'[\d,]+', yen_str)
    if not numbers:
        return ""
    
    # 处理范围（如 1,200-2,000）
    if len(numbers) == 2:
        low = int(numbers[0].replace(',', ''))
        high = int(numbers[1].replace(',', ''))
        low_rmb = int(low * EXCHANGE_RATE)
        high_rmb = int(high * EXCHANGE_RATE)
        return f"约¥{low_rmb}-{high_rmb}"
    else:
        # 单个数字
        val = int(numbers[0].replace(',', ''))
        rmb = int(val * EXCHANGE_RATE)
        return f"约¥{rmb}"

def format_price(match):
    """格式化价格，添加人民币"""
    yen_price = match.group(0)
    rmb = yen_to_rmb(yen_price)
    if rmb:
        return f'{yen_price} <span style="color: #6b8cae; font-size: 0.9em;">({rmb})</span>'
    return yen_price

def read_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        return f.read()

def write_file(filepath, content):
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

# 读取文件
content = read_file('/Users/simula/japan-travel-plan/index.html')

# 1. 更新所有价格格式
# 匹配 ¥后跟数字的模式（包括范围和逗号）
price_pattern = r'¥[\d,]+(?:-[\d,]+)?'
content = re.sub(price_pattern, format_price, content)

# 2. 更新预算部分的人民币换算参考
old_exchange = '''<div class="info-box">
                    <strong>💴 人民币换算参考（汇率约1:19）：</strong><br>
                    - 人均预算：约 <span class="highlight">¥15,000人民币</span>（含购物）<br>
                    - 2人总预算：约 <span class="highlight">¥30,000人民币</span>
                </div>'''

new_exchange = '''<div class="info-box">
                    <strong>💴 人民币换算参考（汇率约1:19）：</strong><br>
                    - 人均预算：约 <span class="highlight">¥12,000-15,000人民币</span>（含购物）<br>
                    - 2人总预算：约 <span class="highlight">¥24,000-30,000人民币</span>
                </div>'''

content = content.replace(old_exchange, new_exchange)

# 保存修改
write_file('/Users/simula/japan-travel-plan/index.html', content)

print("✅ 价格格式更新完成！")
print("✅ 所有¥价格已添加人民币换算")
