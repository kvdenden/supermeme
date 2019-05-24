import React, { useState } from "react";
// import PropTypes from "prop-types";
import Preview from "./Preview";

const DesignForm = ({ action }) => {
  const [text, setText] = useState("Supermeme");

  return (
    <React.Fragment>
      <div>
        <Preview text={text} />
      </div>
      <form action={action}>
        <input
          type="text"
          value={text}
          onChange={event => setText(event.target.value)}
        />
        <button type="submit">Create</button>
      </form>
    </React.Fragment>
  );
};

// DesignForm.propTypes = {
//   text: PropTypes.string
// };
export default DesignForm;
