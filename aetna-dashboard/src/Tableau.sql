from flask import Blueprint, request, jsonify
import json

blueprint = Blueprint("blueprint", __name__)

@blueprint.route('/get-ai-response-feedback-all', methods=["POST"])
def get_response_feedback_all():
    try:
        query = """
            SELECT id, value, userId, threadId, feedback, comment, created_at
            FROM responseFeedback
            ORDER BY created_at DESC
        """

        with spannerDb.snapshot() as snapshot:
            result = snapshot.execute_sql(query)
            rows = []
            for row in result:
                row_dict = dict(row)
                # Convert created_at if it exists
                if "created_at" in row_dict and row_dict["created_at"] is not None:
                    row_dict["created_at"] = row_dict["created_at"].isoformat()
                rows.append(row_dict)

        return jsonify({
            "message": "Chat Fetched Successfully",
            "data": rows
        }), 200

    except Exception as e:
        print("Error:", e)
        return jsonify({"error": str(e)}), 508




import React, { useState, useMemo } from 'react';
import { Input, Collapse, Badge, Empty, Button } from 'antd';
import { SearchOutlined } from '@ant-design/icons';

const { Search } = Input;
const { Panel } = Collapse;

const App = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedSection, setSelectedSection] = useState('all');

  // Sample data organized by sections
  const allData = {
    all: [
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
    ],
    trending: [
      {
        key: '1',
        title: 'Popular Electronics',
        items: [
          { id: 2, name: 'Smartphone', description: 'Latest 5G enabled smartphone - Trending Now!' },
          { id: 3, name: 'Headphones', description: 'Wireless noise-cancelling headphones - Best Seller' },
        ]
      },
      {
        key: '2',
        title: 'Fashion Trends',
        items: [
          { id: 5, name: 'T-Shirt', description: 'Cotton comfortable t-shirt - Summer Collection' },
          { id: 8, name: 'Sneakers', description: 'Running sneakers with cushioning - Hot Item' },
        ]
      },
      {
        key: '3',
        title: 'Bestselling Books',
        items: [
          { id: 9, name: 'Fiction Novel', description: 'Bestselling mystery thriller - #1 on charts' },
          { id: 12, name: 'Cookbook', description: 'Healthy recipes for beginners - Most Popular' },
        ]
      },
      {
        key: '4',
        title: 'Home Favorites',
        items: [
          { id: 13, name: 'Sofa', description: 'Comfortable 3-seater sofa - Customer Favorite' },
          { id: 15, name: 'Lamp', description: 'Modern LED desk lamp - Design Award Winner' },
        ]
      }
    ],
    new: [
      {
        key: '1',
        title: 'New Electronics',
        items: [
          { id: 1, name: 'Laptop', description: 'High performance laptop with 16GB RAM - Just Released' },
          { id: 4, name: 'Tablet', description: '10-inch tablet with stylus support - New Arrival' },
        ]
      },
      {
        key: '2',
        title: 'New Clothing',
        items: [
          { id: 6, name: 'Jeans', description: 'Classic blue denim jeans - Fresh Stock' },
          { id: 7, name: 'Jacket', description: 'Waterproof winter jacket - Winter 2025 Collection' },
        ]
      },
      {
        key: '3',
        title: 'New Books',
        items: [
          { id: 10, name: 'Science Book', description: 'Introduction to quantum physics - Published 2025' },
          { id: 11, name: 'Biography', description: 'Life story of a famous inventor - New Release' },
        ]
      },
      {
        key: '4',
        title: 'New Home Items',
        items: [
          { id: 14, name: 'Plant Pot', description: 'Ceramic decorative plant pot - Spring Collection' },
          { id: 16, name: 'Rug', description: 'Soft wool area rug - Latest Design' },
        ]
      }
    ],
    featured: [
      {
        key: '1',
        title: 'Featured Electronics',
        items: [
          { id: 1, name: 'Laptop', description: 'High performance laptop with 16GB RAM - Editor\'s Choice' },
          { id: 3, name: 'Headphones', description: 'Wireless noise-cancelling headphones - Premium Pick' },
        ]
      },
      {
        key: '2',
        title: 'Featured Fashion',
        items: [
          { id: 7, name: 'Jacket', description: 'Waterproof winter jacket - Staff Recommended' },
        ]
      },
      {
        key: '3',
        title: 'Featured Books',
        items: [
          { id: 9, name: 'Fiction Novel', description: 'Bestselling mystery thriller - Must Read' },
          { id: 10, name: 'Science Book', description: 'Introduction to quantum physics - Featured Selection' },
        ]
      },
      {
        key: '4',
        title: 'Featured Home',
        items: [
          { id: 13, name: 'Sofa', description: 'Comfortable 3-seater sofa - Premium Quality' },
          { id: 15, name: 'Lamp', description: 'Modern LED desk lamp - Designer Choice' },
        ]
      }
    ]
  };

  const sections = [
    { key: 'all', label: 'All Products' },
    { key: 'trending', label: 'Trending' },
    { key: 'new', label: 'New Arrivals' },
    { key: 'featured', label: 'Featured' }
  ];

  // Get current section data
  const currentData = allData[selectedSection] || allData.all;

  // Filter categories based on search term
  const filteredCategories = useMemo(() => {
    if (!searchTerm.trim()) {
      return currentData;
    }

    const term = searchTerm.toLowerCase();
    return currentData
      .map(category => ({
        ...category,
        items: category.items.filter(item =>
          item.name.toLowerCase().includes(term) ||
          item.description.toLowerCase().includes(term)
        )
      }))
      .filter(category => category.items.length > 0);
  }, [searchTerm, currentData]);

  const handleSearch = (value) => {
    setSearchTerm(value);
  };

  const handleSectionChange = (sectionKey) => {
    setSelectedSection(sectionKey);
    setSearchTerm(''); // Optional: clear search when switching sections
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

    <div style={{ 
        marginBottom: 24, 
        display: 'flex', 
        gap: 32,
        borderBottom: '2px solid #f0f0f0'
      }}>
        {sections.map(section => (
          <div
            key={section.key}
            onClick={() => handleSectionChange(section.key)}
            style={{
              padding: '12px 4px',
              fontSize: 16,
              fontWeight: selectedSection === section.key ? 600 : 400,
              color: selectedSection === section.key ? '#1890ff' : '#595959',
              borderBottom: selectedSection === section.key ? '3px solid #1890ff' : '3px solid transparent',
              cursor: 'pointer',
              transition: 'all 0.3s ease',
              marginBottom: '-2px'
            }}
          >
            {section.label}
          </div>
        ))}
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
