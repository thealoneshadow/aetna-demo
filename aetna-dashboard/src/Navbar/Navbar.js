import React from "react";
import Dropdown from "rsuite/Dropdown";
import "rsuite/dist/rsuite.min.css";

function Navbar() {
  const categories = ["Category 1", "Category 2", "Category 3", "Category 4"];
  const departments = [
    "Department 1",
    "Department 2",
    "Department 3 e ",
    "Department cvxcv rg wer4",
  ];
  const data = [
    {
      name: "Department 1",
      data: "https://public.tableau.com/views/TableauServerAdminInsights2024/SUMMARY?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
      years: ["2021", "2020", "2019", "2018"],
    },
    {
      name: "Department 2",
      data: "https://public.tableau.com/views/PathwaysoutofPoverty_17101806671470/ConqueringPoverty?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
      years: ["2021", "2020", "2019", "2018"],
    },
    {
      name: "Department 3",
      data: "https://public.tableau.com/views/IMDBTopMovies_17101706981570/IMDbMovies?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
      years: ["2021", "2020", "2019", "2018"],
    },
    {
      name: "Department 4",
      data: "https://public.tableau.com/views/TaylorSwift-SpotifyAudioFeaturesBack2VizBasics/Spotify?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link",
      years: ["2021", "2020", "2019", "2018"],
    },
  ];
  return (
    <div>
      {categories.map((category, index) => (
        <Dropdown title={category}>
          {data.map((department, index) => (
            <div>
              <Dropdown.Menu title={department.name}>
                {department.years.map((year) => (
                  <Dropdown.Item>{year}</Dropdown.Item>
                ))}
              </Dropdown.Menu>
            </div>
          ))}
        </Dropdown>
      ))}
      <Dropdown title="CVSHealth">
        <Dropdown.Item>Item 1</Dropdown.Item>
        <Dropdown.Menu title="Item 2">
          <Dropdown.Item>Item 2A</Dropdown.Item>
          <Dropdown.Item>Item 2B</Dropdown.Item>
        </Dropdown.Menu>
        <Dropdown.Item>Item 3</Dropdown.Item>
        <Dropdown.Menu title="Item 4">
          <Dropdown.Menu title="Item 4A">
            <Dropdown.Item>Item 4A-A</Dropdown.Item>
            <Dropdown.Item>Item 4A-B</Dropdown.Item>
          </Dropdown.Menu>
          <Dropdown.Item>Item 4B</Dropdown.Item>
        </Dropdown.Menu>
      </Dropdown>
    </div>
  );
}

export default Navbar;
