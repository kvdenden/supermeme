import React, { useState, useEffect } from "react";

import useThrottle from "react-use/lib/useThrottle";
import styled from "styled-components";

import SupremeText from "./SupremeText";

const calculatePadding = ({ adjustments }) => {
  let paddingLeft = 0.4;
  let paddingRight = 0.4;
  let paddingTop = 0;
  let paddingBottom = 0.2;

  const { moveDown } = adjustments;
  if (moveDown) {
    paddingTop = 0.1;
    paddingBottom = 0.1;
  }

  return `${paddingTop}em ${paddingRight}em ${paddingBottom}em ${paddingLeft}em`;
};

const StyledBox = styled.div`
  display: inline-block;
  padding: ${props => calculatePadding(props)};
  font-size: ${props => `${props.size}px`};
  line-height: 1.2;
  background-color: #d82122;
  min-width: 4em;
  text-align: center;
`;

const StyledText = styled(SupremeText)`
  color: white;
  white-space: nowrap;
`;

const useAdjustments = (uri, { throttle = 500 } = {}) => {
  const [adjustments, setAdjustments] = useState({});

  const throttledUri = useThrottle(uri, throttle);

  useEffect(() => {
    let aborted = false;
    const abortController = new AbortController();

    fetch(throttledUri, {
      signal: abortController.signal
    })
      .then(response => {
        if (response.ok) {
          response.json().then(body => {
            setAdjustments(body);
          });
        }
      })
      .catch(err => {
        if (!aborted) {
          console.warn(`something went wrong`, err);
        }
      });

    return () => {
      aborted = true;
      abortController.abort();
    };
  }, [throttledUri]);

  return { adjustments };
};

const BoxLogo = ({ text, size = 72 }) => {
  const { adjustments } = useAdjustments(
    `/images/adjust?design=supreme&text=${encodeURIComponent(text)}`
  );

  return (
    <StyledBox size={size} adjustments={adjustments}>
      <StyledText>{text}</StyledText>
    </StyledBox>
  );
};

export default BoxLogo;
