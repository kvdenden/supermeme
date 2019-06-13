import React, { useState, useEffect } from "react";

import styled from "styled-components";

import WordCloud from "./WordCloud";

const FullWidthContainer = styled.div`
  width: 100vw;
  margin-left: 50%;
  transform: translateX(-50%) skewY(-5deg);
`;

const fetchWords = async ({ word, count }) => {
  let dataUri = `/words/related?word=${encodeURIComponent(
    word
  )}&count=${count}`;
  const result = await fetch(dataUri);
  const allWords = await result.json();
  return allWords.filter(word => word.length <= 24);
};

const RelatedDesigns = ({ word, count = 20 }) => {
  const [loading, setLoading] = useState(true);
  const [words, setWords] = useState([]);

  const updateWords = () => {
    setLoading(true);
    fetchWords({ word, count }).then(words => {
      setWords(words);
      setLoading(false);
    });
  };

  useEffect(() => {
    updateWords();
  }, [word, count]);

  if (words.length < 5) {
    return null;
  }

  return (
    <div style={{ textAlign: "center" }}>
      <h3>Related designs</h3>
      <FullWidthContainer>
        <WordCloud words={words} />
      </FullWidthContainer>
    </div>
  );
};

export default RelatedDesigns;
