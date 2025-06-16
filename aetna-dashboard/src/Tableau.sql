    prompt = f"""
You are a data visualization expert.

Analyze the following JSON data and recommend the most appropriate chart type from this fixed list:

["bar", "line", "pie", "scatter", "histogram", "area", "bubble", "heatmap", "table"]

Data:
{data_str}

Only return a single word — the chart type name — from the list above.
Do not explain your answer.
If the data is invalid, return "invalid".
"""
