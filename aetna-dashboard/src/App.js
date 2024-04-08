import "./App.css";
import { useEffect, useRef, useState } from "react";
import React from "react";
import Dropdown from "rsuite/Dropdown";
import TestView from "./testView/TestView";

function App({ instance }) {
  // const [selectedCategory, setSelectedCategory] = useState(null);
  // const [selectedDepartment, setSelectedDepartment] = useState(null);
  // const [viz, setViz] = useState(null);
  // const ref = useRef(null);
  // const categories = ["Category 1", "Category 2", "Category 3", "Category 4"];
  // const departments = [
  //   "Department 1",
  //   "Department 2",
  //   "Department 3",
  //   "Department 4",
  // ];
  // const data = [
  //   {
  //     name: "Department 1",
  //     data: "https://public.tableau.com/views/TableauServerAdminInsights2024/SUMMARY?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
  //     years: ["2021", "2020", "2019", "2018"],
  //   },
  //   {
  //     name: "Department 2",
  //     data: "https://public.tableau.com/views/PathwaysoutofPoverty_17101806671470/ConqueringPoverty?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
  //     years: ["2021", "2020", "2019", "2018"],
  //   },
  //   {
  //     name: "Department 3",
  //     data: "https://public.tableau.com/views/IMDBTopMovies_17101706981570/IMDbMovies?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
  //     years: ["2021", "2020", "2019", "2018"],
  //   },
  //   {
  //     name: "Department 4",
  //     data: "https://public.tableau.com/views/TaylorSwift-SpotifyAudioFeaturesBack2VizBasics/Spotify?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
  //     years: ["2021", "2020", "2019", "2018"],
  //   },
  // ];

  // const handleCategoryClick = (index) => {
  //   setSelectedCategory(index);
  //   setSelectedDepartment(null);
  // };

  // const handleDepartmentClick = (index) => {
  //   setSelectedDepartment(index);
  // };

  // const initViz = async (url) => {
  //   if (viz) {
  //     viz.dispose();
  //   }

  //   ref.current.innerHTML = "";
  //   const options = {
  //     hideTabs: true,
  //     width: "100%",
  //     height: "90vh",
  //   };
  //   const newViz = new window.tableau.Viz(ref.current, url, options);
  //   setViz(newViz);
  // };

  // const changeDash = (newUrl) => {
  //   initViz(newUrl);
  // };

  // useEffect(() => {
  //   initViz(data[0].data);

  //   return () => {
  //     if (viz) {
  //       viz.dispose();
  //     }
  //   };
  // }, []);

  return (
    <>
      {/* <div className="navbar-container-new ">
        {categories.map((category, index) => (
          <Dropdown title={category} className=" category-list-new" key={index}>
            {data.map((department, index) => (
              <div>
                <Dropdown.Menu title={department.name}>
                  {department.years.map((year) => (
                    <Dropdown.Item onClick={() => changeDash(department.data)}>
                      {year}
                    </Dropdown.Item>
                  ))}
                </Dropdown.Menu>
              </div>
            ))}
          </Dropdown>
        ))}
        <img
          className="img-new"
          src="https://www.cvshealth.com/content/dam/enterprise/cvs-enterprise/logos/CVS_Health_logo.svg"
        />
      </div> */}
      {/* <div className="navbar-container">
        <ul className="category-list">
          {categories.map((category, index) => (
            <li
              key={index}
              onClick={() => handleCategoryClick(index)}
              className={
                selectedCategory === index ? "active dropdown" : "dropdown"
              }
            >
              {category}
              {selectedCategory === index && (
                <ul className="data-list">
                  {data.map((item, index) => (
                    <li key={index} onClick={() => changeDash(item.data)}>
                      {item.name}
                    </li>
                  ))}
                </ul>
              )}
            </li>
          ))}
        </ul>
        <img
          className="img"
          src="https://www.cvshealth.com/content/dam/enterprise/cvs-enterprise/logos/CVS_Health_logo.svg"
        />
      </div> */}
      <TestView />
    </>
  );
}

export default App;
