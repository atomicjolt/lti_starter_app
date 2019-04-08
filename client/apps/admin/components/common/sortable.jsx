import React from 'react';
import PropTypes from 'prop-types';

export default function Sortable(props) {
  const {
    title,
    column,
    currentColumn,
    currentDirection,
    setSort,
  } = props;

  const direction = column === currentColumn && currentDirection === 'asc' ? 'desc' : 'asc';
  let icon = currentDirection === 'asc' ? 'keyboard_arrow_up' : 'keyboard_arrow_down';
  icon = column === currentColumn ? icon : '';

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
  currentColumn: PropTypes.string.isRequired,
  currentDirection: PropTypes.string.isRequired,
  setSort: PropTypes.func.isRequired,
};
