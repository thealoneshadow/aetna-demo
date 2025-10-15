import React, { useState, useMemo } from 'react';
import { Input, Collapse, Badge, Empty } from 'antd';
import { SearchOutlined } from '@ant-design/icons';

const data = [
  { id: 1, vertical: 'Electronics', question: 'Laptop', category: 'Electronics' },
  { id: 2, vertical: 'Electronics', question: 'Smartphone', category: 'Electronics' },
  { id: 3, vertical: 'Electronics', question: 'Headphones', category: 'Electronics' },
  { id: 4, vertical: 'Electronics', question: 'Tablet', category: 'Electronics' },
  { id: 5, vertical: 'Furniture', question: 'Chair', category: 'Furniture' },
  { id: 6, vertical: 'Furniture', question: 'Table', category: 'Furniture' }
];

const result = Object.values(
  data.reduce((acc, { id, question, category }) => {
    if (!acc[category]) {
      acc[category] = {
        key: category,
        title: category,
        items: []
      };
    }
    acc[category].items.push({ id, question });
    return acc;
  }, {})
);

console.log(result);

const { Search } = Input;
const { Panel } = Collapse;

const App = () => {
  const [searchTerm, setSearchTerm] = useState('');

  // Sample data for categories
  const categoriesData = [
    {
      key: '1',
      title: 'Electronics',
      items: [
        { id: 1, name: 'Laptop', description: 'High performance laptop with 16GB RAM' },
        { id: 2, name: 'Smartphone', description: 'Latest 5G enabled smartphone' },
        { id: 3, name: 'Headphones', description: 'Wireless noise-cancelling headphones' },
        { id: 4, name: 'Tablet', description: '10-inch tablet with stylus support' },
      ]
    },
    {
      key: '2',
      title: 'Clothing',
      items: [
        { id: 5, name: 'T-Shirt', description: 'Cotton comfortable t-shirt' },
        { id: 6, name: 'Jeans', description: 'Classic blue denim jeans' },
        { id: 7, name: 'Jacket', description: 'Waterproof winter jacket' },
        { id: 8, name: 'Sneakers', description: 'Running sneakers with cushioning' },
      ]
    },
    {
      key: '3',
      title: 'Books',
      items: [
        { id: 9, name: 'Fiction Novel', description: 'Bestselling mystery thriller' },
        { id: 10, name: 'Science Book', description: 'Introduction to quantum physics' },
        { id: 11, name: 'Biography', description: 'Life story of a famous inventor' },
        { id: 12, name: 'Cookbook', description: 'Healthy recipes for beginners' },
      ]
    },
    {
      key: '4',
      title: 'Home & Garden',
      items: [
        { id: 13, name: 'Sofa', description: 'Comfortable 3-seater sofa' },
        { id: 14, name: 'Plant Pot', description: 'Ceramic decorative plant pot' },
        { id: 15, name: 'Lamp', description: 'Modern LED desk lamp' },
        { id: 16, name: 'Rug', description: 'Soft wool area rug' },
      ]
    }
  ];

  // Filter categories based on search term
  const filteredCategories = useMemo(() => {
    if (!searchTerm.trim()) {
      return categoriesData;
    }

    const term = searchTerm.toLowerCase();
    return categoriesData
      .map(category => ({
        ...category,
        items: category.items.filter(item =>
          item.name.toLowerCase().includes(term) ||
          item.description.toLowerCase().includes(term)
        )
      }))
      .filter(category => category.items.length > 0);
  }, [searchTerm]);

  const handleSearch = (value) => {
    setSearchTerm(value);
  };

  return (
    <div style={{ maxWidth: 800, margin: '40px auto', padding: '0 20px' }}>
      <div style={{ marginBottom: 24 }}>
        <h1 style={{ fontSize: 28, marginBottom: 16 }}>Product Catalog</h1>
        <Search
          placeholder="Search products by name or description..."
          allowClear
          enterButton={<SearchOutlined />}
          size="large"
          onSearch={handleSearch}
          onChange={(e) => setSearchTerm(e.target.value)}
          value={searchTerm}
        />
      </div>

      {filteredCategories.length > 0 ? (
        <Collapse
          defaultActiveKey={['1']}
          ghost
          style={{ background: '#fff' }}
        >
          {filteredCategories.map(category => (
            <Panel
              header={
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <span style={{ fontSize: 16, fontWeight: 500 }}>{category.title}</span>
                  <Badge count={category.items.length} style={{ backgroundColor: '#1890ff' }} />
                </div>
              }
              key={category.key}
            >
              <div style={{ paddingLeft: 12 }}>
                {category.items.map(item => (
                  <div
                    key={item.id}
                    style={{
                      padding: '12px 16px',
                      marginBottom: 8,
                      background: '#f5f5f5',
                      borderRadius: 6,
                      borderLeft: '3px solid #1890ff'
                    }}
                  >
                    <div style={{ fontWeight: 500, marginBottom: 4 }}>{item.name}</div>
                    <div style={{ color: '#666', fontSize: 14 }}>{item.description}</div>
                  </div>
                ))}
              </div>
            </Panel>
          ))}
        </Collapse>
      ) : (
        <Empty
          description="No products found matching your search"
          style={{ marginTop: 60 }}
        />
      )}
    </div>
  );
};

export default App;
