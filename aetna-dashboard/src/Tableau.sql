def quote_table_names(query):
    """
    Function to quote table names with special characters in backticks.
    Assumes table names with hyphens need to be quoted.
    """
    import re

    # Regex to match table names with hyphens or special characters
    pattern = re.compile(r'(\b\w+[-\w]*\b)')

    # Function to quote table names
    def quote_match(match):
        table_name = match.group(0)
        if '-' in table_name:
            return f'`{table_name}`'
        return table_name

    return pattern.sub(quote_match, query) 
 
 
 query_id = request.args.get('id', type=int)

    if not query_id:
        return jsonify({'error': 'Query ID is required'}), 400

    try:
        # Fetch the saved query from table `x`
        with database.snapshot() as snapshot:
            saved_query = snapshot.execute_sql(
                "SELECT query FROM x WHERE id = @id", 
                params={"id": query_id}, 
                param_types={"id": spanner.param_types.INT64}
            ).one()[0]

        # Execute the fetched query
        with database.snapshot() as snapshot:
            results = snapshot.execute_sql(saved_query)

            result_list = []
            for row in results:
                result_list.append(dict(row.items()))

        return jsonify({'message': 'Query executed successfully!', 'result': result_list})
    except Exception as e:
        return jsonify({'error': str(e)}), 500












defaultValue={[dayjs('2015/01/01', dateFormat), dayjs('2015/01/01', dateFormat)]}

const currentDate = new Date();

// Get the date from exactly one week ago
const lastWeekDate = new Date();
lastWeekDate.setDate(currentDate.getDate() - 7);

// Format the dates as YYYY-MM-DD
const currentFormattedDate = currentDate.toISOString().slice(0, 10);
const lastWeekFormattedDate = lastWeekDate.toISOString().slice(0, 10);


import React from 'react';
import { Button, message, Space } from 'antd';

const App: React.FC = () => {
  const [messageApi, contextHolder] = message.useMessage();

  const success = () => {
    messageApi.open({
      type: 'success',
      content: 'This is a success message',
    });
  };

  const error = () => {
    messageApi.open({
      type: 'error',
      content: 'This is an error message',
    });
  };

  const warning = () => {
    messageApi.open({
      type: 'warning',
      content: 'This is a warning message',
    });
  };

  return (
    <>
      {contextHolder}
      <Space>
        <Button onClick={success}>Success</Button>
        <Button onClick={error}>Error</Button>
        <Button onClick={warning}>Warning</Button>
      </Space>
    </>
  );
};