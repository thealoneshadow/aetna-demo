import React, { useState } from "react";
import styled from "styled-components";

// Define your styled component
const StyledButton = styled.button`
  /* Your default styles here */
  background-color: ${(props) => (props.selected ? "blue" : "green")};
  color: white;
  padding: 10px;
  margin: 5px;
  border: none;
  cursor: pointer;

  &:hover {
    background-color: ${(props) => (props.selected ? "darkblue" : "darkgreen")};
  }
`;

const ButtonList = () => {
  const [selectedButtonIndex, setSelectedButtonIndex] = useState(null);

  const handleButtonClick = (index) => {
    setSelectedButtonIndex(index);
  };

  return (
    <div>
      {[0, 1, 2, 3].map((index) => (
        <StyledButton
          key={index}
          className={
            selectedButtonIndex === index ? "rs-btn selected" : "rs-btn"
          }
          onClick={() => handleButtonClick(index)}
        >
          Button {index + 1}
        </StyledButton>
      ))}
    </div>
  );
};

export default ButtonList;
