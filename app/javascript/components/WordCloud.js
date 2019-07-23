import React from "react";
import styled from "styled-components";

import SupremeText from "./SupremeText";

const WordContainer = styled.div`
  padding: 20px;
  font-size: 24px;
  background-color: #d82122;

  display: flex;
  flex-wrap: wrap;
  justify-content: center;

  > a {
    display: inline-block;
    padding: 0.2em 1em;
    color: white;
    white-space: nowrap;

    transition: all 0.2s;

    &:hover {
      transform: scale(1.1);
    }
  }

  @media screen and (min-width: 576px) {
    font-size: 4vw;
  }

  @media screen and (min-width: 1200px) {
    font-size: 48px;
  }
`;

const WordCloud = ({ words }) => {
  return (
    <WordContainer>
      {words.map(word => (
        <a
          key={word}
          href={`/design?text=${encodeURIComponent(word).replace(/%20/g, "+")}`}
        >
          <SupremeText>{word}</SupremeText>
        </a>
      ))}
    </WordContainer>
  );
};

export default WordCloud;
