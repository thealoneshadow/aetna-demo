import "./App.css";
import { useEffect, useRef, useState } from "react";

function App({ instance }) {
  const [selectedCategory, setSelectedCategory] = useState(null);
  const [selectedDepartment, setSelectedDepartment] = useState(null);
  const [viz, setViz] = useState(null);
  const ref = useRef(null);
  const categories = ["Category 1", "Category 2", "Category 3", "Category 4"];
  const departments = [
    "Department 1",
    "Department 2",
    "Department 3",
    "Department 4",
  ];
  const data = [
    {
      name: "data1",
      data: "https://public.tableau.com/views/TableauServerAdminInsights2024/SUMMARY?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
    },
    {
      name: "data2",
      data: "https://public.tableau.com/views/PathwaysoutofPoverty_17101806671470/ConqueringPoverty?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
    },
    {
      name: "data3",
      data: "https://public.tableau.com/views/IMDBTopMovies_17101706981570/IMDbMovies?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
    },
    {
      name: "data4",
      data: "https://public.tableau.com/views/TaylorSwift-SpotifyAudioFeaturesBack2VizBasics/Spotify?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
    },
  ];

  const handleCategoryClick = (index) => {
    setSelectedCategory(index);
    setSelectedDepartment(null);
  };

  const handleDepartmentClick = (index) => {
    setSelectedDepartment(index);
  };

  const initViz = async (url) => {
    if (viz) {
      viz.dispose();
    }

    ref.current.innerHTML = "";
    const options = {
      hideTabs: true,
      width: "100%",
      height: "90vh",
    };
    const newViz = new window.tableau.Viz(ref.current, url, options);
    setViz(newViz);
  };

  const changeDash = (newUrl) => {
    initViz(newUrl);
  };

  useEffect(() => {
    initViz(data[0].data);

    return () => {
      if (viz) {
        viz.dispose();
      }
    };
  }, []);

  return (
    <>
      <div className="navbar-container">
        <h1>Navbar</h1>
        <ul className="category-list">
          {categories.map((category, index) => (
            <li
              key={index}
              onClick={() => handleCategoryClick(index)}
              className={selectedCategory === index ? "active" : ""}
            >
              {category}
            </li>
          ))}
        </ul>
        {selectedCategory !== null && (
          <div>
            <h2>Departments</h2>
            <ul className="department-list">
              {departments.map((department, index) => (
                <li
                  key={index}
                  onClick={() => handleDepartmentClick(index)}
                  className={selectedDepartment === index ? "active" : ""}
                >
                  {department}
                </li>
              ))}
            </ul>
            {selectedDepartment !== null && (
              <div>
                <h3>Data</h3>
                <ul className="data-list">
                  {data.map((item, index) => (
                    <li key={index} onClick={() => changeDash(item.data)}>
                      {item.name}
                    </li>
                  ))}
                </ul>
              </div>
            )}
          </div>
        )}
      </div>
      <div ref={ref}></div>
    </>
  );
}

export default App;
