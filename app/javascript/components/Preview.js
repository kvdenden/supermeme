import React from "react";
import PropTypes from "prop-types";

const Preview = ({ text }) => {
  return <React.Fragment>{text}</React.Fragment>;
};

Preview.propTypes = {
  text: PropTypes.string
};
export default Preview;
