import React from 'react';
import PropTypes from 'prop-types';

// This component is currently unused, but one day, we may implement it, please leave it here
export default function search(props) {
  const {
    search: searchFct,
  } = props;

  return (
    <div className="c-search c-search--small">
      <input
        type="text"
        placeholder="Search..."
        onChange={(e) => searchFct(e.target.value)}
      />
      <i className="i-search" />
    </div>
  );
}

search.propTypes = {
  search: PropTypes.func.isRequired,
};
