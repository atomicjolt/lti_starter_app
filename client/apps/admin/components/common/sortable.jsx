import React from 'react';
import PropTypes from 'prop-types';

export default function Sortable(props) {
  const {
    title,
    column,
    currentColumn,
    currentDirection,
    setSort,
    canSearch,
    searchChanged,
    toggleSearch,
    isSearchOpen,
  } = props;

  const direction = column === currentColumn && currentDirection === 'asc' ? 'desc' : 'asc';
  let icon = currentDirection === 'asc' ? 'arrow_upward' : 'arrow_downward';
  icon = column === currentColumn ? icon : '';
  const selectedColumn = column === currentColumn;

  return (
    <th className="sortable-header">
      <div className="aj-flex">
        <button className="aj-sort-btn" onClick={() => setSort(column, direction)}>
          <span className={selectedColumn ? 'aj-flex selected' : 'aj-flex'}>
            {title}
            <i className="material-icons aj-icon-btn-sort">
              {icon}
            </i>
          </span>
        </button>
        {canSearch && (
          <div className={`input input--search ${isSearchOpen ? 'is-expanded' : ''}`} id="container">
            <div className="not-the-button">
              <input id="searchInput" onChange={({ target: { value } }) => searchChanged(value)} type="text" />
            </div>
            <button className="aj-search-button" type="button" onClick={toggleSearch}>
              <i className="material-icons" aria-hidden="true">search</i>
            </button>
          </div>
        )}
      </div>
    </th>
  );
}

Sortable.propTypes = {
  title: PropTypes.string.isRequired,
  column: PropTypes.string.isRequired,
  currentColumn: PropTypes.string.isRequired,
  currentDirection: PropTypes.string.isRequired,
  setSort: PropTypes.func.isRequired,
  canSearch: PropTypes.bool,
  searchChanged: PropTypes.func,
  toggleSearch: PropTypes.func,
  isSearchOpen: PropTypes.bool,
};
