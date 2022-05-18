import React from 'react';
import PropTypes from 'prop-types';

export default function Header(props) {
  const {
    newSite
  } = props;

  return (
    <div className="c-info">
      <div className="c-title">
        <h1>Sites</h1>
      </div>
      <button className="c-btn c-btn--yellow" onClick={newSite}>
        New Site
      </button>
    </div>
  );
}

Header.propTypes = {
  newSite: PropTypes.func.isRequired,
};
