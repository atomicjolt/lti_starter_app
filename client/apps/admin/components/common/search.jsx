import React from 'react';
import PropTypes from 'prop-types';

// This component is currently unused, but one day, we may implement it, please leave it here
export default function Search(props) {
  const {
    search,
  } = props;

  return (
    <div className="c-search c-search--small">
      <input
        type="text"
        placeholder="Search..."
        onChange={(e) => search(e.target.value)}
      />
      <i className="i-search" />
    </div>
  );
}

Search.propTypes = {
  search: PropTypes.func.isRequired,
};
