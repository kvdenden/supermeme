import React, { useState, useEffect } from "react";

import styled from "styled-components";

import WordCloud from "./WordCloud";

const FullWidthContainer = styled.div`
  width: 100vw;
  margin-left: 50%;
  transform: translateX(-50%) skewY(-5deg);
`;

const fetchWords = async ({ count, category }) => {
  let dataUri = `/words/fake?count=${count}`;
  if (category) {
    dataUri += `&category=${category}`;
  }

  const words = await fetch(dataUri);
  return words.json();
};

const FakeDesigns = ({ count = 20, category }) => {
  const [loading, setLoading] = useState(true);
  const [words, setWords] = useState([]);

  const updateWords = () => {
    setLoading(true);
    fetchWords({ count, category }).then(words => {
      setWords(words);
      setLoading(false);
    });
  };

  useEffect(() => {
    updateWords();
  }, [count, category]);

  return (
    <div style={{ textAlign: "center" }}>
      <h3 style={{ marginBottom: "4rem" }}>Design inspiration</h3>
      <FullWidthContainer>
        <WordCloud words={words} />
        <button
          className="btn btn-lg btn-supreme btn-animated"
          onClick={updateWords}
          style={{ marginTop: "2rem" }}
        >
          Load more examples
        </button>
      </FullWidthContainer>
    </div>
  );
};

export default FakeDesigns;
