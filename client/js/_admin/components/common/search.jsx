import React      from 'react';

// This component is currently unused, but one day, we may implement it, please leave it here
export default function search(props) {
  return (
    <div className="c-search c-search--small">
      <input
        type="text"
        placeholder="Search..."
        onChange={e => props.search(e.target.value)}
      />
      <i className="i-search" />
    </div>
  );
}

search.propTypes = {
  search: React.PropTypes.func.isRequired,
};
