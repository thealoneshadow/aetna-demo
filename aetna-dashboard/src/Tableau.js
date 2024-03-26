import React, { useEffect, useRef } from "react";
import "./App.css";
import tableau from "tableau-api";

import { AuthenticatedTemplate } from "@azure/msal-react";
function Tableau() {
  const url =
    "https://public.tableau.com/views/TableauServerAdminInsights2024/SUMMARY?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link";
  const ref = useRef(null);
  //   const init = () => {
  //     navigator.geolocation.getCurrentPosition(async (position) => {
  //       const { latitude, longitude } = position.coords;
  //       try {
  //         const response = await fetch(
  //           `https://us1.locationiq.com/v1/reverse.php?key=pk.b0059febf3713043d0eec0cfb57fd313&lat=${latitude}&lon=${longitude}&format=json`
  //         );
  //         const data = await response.json();
  //         setCountry(data.address.country);
  //       } catch (error) {
  //         console.error(error);
  //       }
  //     });
  //     new tableau.Viz(ref.current, url, {
  //       width: "100%",
  //       height: "90vh",
  //     });
  //   };

  // eslint-disable-next-line react-hooks/exhaustive-deps

  return (
    <AuthenticatedTemplate>
      <div ref={ref}></div>
      <AuthenticatedTableauVisualization ref={ref} url={url} />
    </AuthenticatedTemplate>
  );
}

export default Tableau;

const AuthenticatedTableauVisualization = React.forwardRef(({ url }, ref) => {
  let viz = null;

  useEffect(() => {
    const initViz = async () => {
      if (viz) {
        viz.dispose();
      }

      const vizUrl = url;
      ref.current.innerHTML = "";
      const options = {
        hideTabs: true,
        width: "100%",
        height: "90vh",
      };
      viz = new window.tableau.Viz(ref.current, vizUrl, options);
    };
    initViz();

    return () => {
      if (viz) {
        viz.dispose();
      }
    };
  }, [url, ref]);

  return <div ref={ref}></div>;
});

<div className="search-container">
  <form onSubmit={handleSearch}>
    <div className="search-icon" onClick={toggleOpen}>
      <Search size={20} />
    </div>
    {isOpen && (
      <div className="dropdown">
        <input
          type="text"
          className="search-input"
          value={inputValue}
          onChange={handleInputChange}
          placeholder="Search..."
        />
        <button type="submit" className="search-button">
          <Search size={20} />
        </button>
        <ul>
          {searchResults.map((result, index) => (
            <li key={index}>{result}</li>
          ))}
        </ul>
      </div>
    )}
  </form>
</div>;
