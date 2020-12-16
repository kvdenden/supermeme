import React, { useState } from "react";
import styled from "styled-components";

import Fit from "./Fit";
import SupremeText from "./SupremeText";
import BoxLogo from "./BoxLogo";

const TextContainer = styled.div`
  background-color: #d82122;
  color: white;
  font-size: 6rem;
  padding: 2rem;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;

  @media screen and (min-width: 576px) {
    padding: 4rem 2rem;
  }
`;

const DesignForm = ({ action, initialText = "" }) => {
  const [text, setText] = useState(initialText);

  const handleTextChange = event => {
    const normalizedText = event.target.value;
    setText(normalizedText);
  };

  return (
    <React.Fragment>
      <div style={{ marginBottom: "1em" }}>
        <TextContainer>
          <Fit>
            <SupremeText>{text || "Supermeme"}</SupremeText>
            {/* <BoxLogo text={text || "Supermeme"} size={196} /> */}
          </Fit>
        </TextContainer>
      </div>
      <form action={action} method="get">
        <div className="form-group">
          <input
            name="text"
            type="text"
            value={text}
            onChange={handleTextChange}
            maxLength={24}
            placeholder="Write something awesome!"
            className="form-control"
          />
          <small id="designHelp" className="form-text text-muted">
            {text.length} of maximum 24 characters
          </small>
        </div>
        <button
          type="submit"
          className="btn btn-lg btn-supreme btn-animated btn-block"
        >
          Create
        </button>
      </form>
    </React.Fragment>
  );
};

export default DesignForm;
