import React from 'react';
import PropTypes from 'prop-types';

export default function Sortable(props) {
  const {
    title,
    column,
    currentSortColumn,
    currentSortDirection,
    setSort,
  } = props;

  const direction = column === currentSortColumn && currentSortDirection === 'asc' ? 'desc' : 'asc';
  let icon = currentSortDirection === 'asc' ? 'keyboard_arrow_up' : 'keyboard_arrow_down';
  icon = column === currentSortColumn ? icon : '';

  return (
    <th className="sortable-header" onClick={() => setSort(column, direction)}>
      <span>
        {title}
        <i className="material-icons">
          {icon}
        </i>
      </span>
    </th>
  );
}

Sortable.propTypes = {
  title: PropTypes.string.isRequired,
  column: PropTypes.string.isRequired,
  currentSortColumn: PropTypes.string.isRequired,
  currentSortDirection: PropTypes.string.isRequired,
  setSort: PropTypes.func.isRequired,
};
