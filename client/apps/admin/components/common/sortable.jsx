import React, { useRef, useState } from 'react';
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
  const searchInput = useRef(null);
  const [searchText, setSearchText] = useState('');

  const clearSearch = () => {
    searchChanged('');
    setSearchText('');
  };

  const onSearchChange = (value) => {
    searchChanged(value);
    setSearchText(value);
  };

  const openSearch = () => {
    if (!isSearchOpen) {
      // Opening search
      searchInput.current.focus();
    } else {
      // Closing search
      clearSearch();
    }
    // toggles the bool isSearchOpen
    toggleSearch();
  };

  return (
    <th className="sortable-header">
      <div className="aj-flex">
        <button type="button" className="aj-sort-btn" onClick={() => setSort(column, direction)}>
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
              <input id="searchInput" value={searchText} ref={searchInput} onChange={({ target: { value } }) => onSearchChange(value)} type="text" />
            </div>
            {isSearchOpen && (
              <button className="aj-clear-button" type="button" onClick={clearSearch}>
                <i className="material-icons" aria-hidden="true">close</i>
              </button>
            )}
            <button className="aj-search-button" type="button" onClick={openSearch}>
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
